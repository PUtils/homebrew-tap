class Switch < Formula
  desc "Shell profiles that act like Debian 13 or another OS, on your own files"
  homepage "https://github.com/PUtils/switch"
  url "https://github.com/PUtils/switch.git",
      using:    :git,
      tag:      "v1.0.0",
      revision: "0bfe627f5c8087c4cf6baf78a55f350a6fcd3d4d"
  head "https://github.com/PUtils/switch.git", using: :git, branch: "main"

  def install
    system "make", "install", "PREFIX=#{prefix}", "CC=#{ENV.cc}"
  end

  def caveats
    <<~EOS
      Linux profiles (debian13, the default) run in Docker, so they need
      Docker Desktop: https://www.docker.com/products/docker-desktop/
      macOS profiles work without it. Start with: sw   (manual: man sw)
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sw --version")
    ENV["SW_HOME"] = (testpath/"sw").to_s
    assert_match "debian13", shell_output("#{bin}/sw profile list")
    assert_match "/usr/bin:/bin", shell_output("#{bin}/sw profile add mac macos && #{bin}/sw mac -c 'echo $PATH'")
  end
end
