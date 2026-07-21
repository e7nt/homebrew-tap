class Lantern < Formula
  desc "Understanding-first AI coding workbench built around Helix"
  homepage "https://github.com/e7nt/lantern"
  version "0.1.0"
  license "AGPL-3.0-only"

  depends_on "git"
  depends_on "node@22"
  depends_on "python@3.12"
  depends_on "tmux"
  depends_on :macos

  on_arm do
    url "https://github.com/e7nt/lantern/releases/download/v0.1.0/lantern-0.1.0-darwin-arm64.tar.gz"
    sha256 "7fbd3ad7811905b3953744243921edebc9f3d208de90d89d74cdc79ca8c02c95"
  end

  on_intel do
    url "https://github.com/e7nt/lantern/releases/download/v0.1.0/lantern-0.1.0-darwin-x86_64.tar.gz"
    sha256 "75d59f39427c53205cd01a6ecf66fd4f8d9d9a9d1906a65e1e2f6bc69f5ad5fb"
  end

  def install
    libexec.install Dir["*"]
    runtime_path = [
      Formula["node@22"].opt_bin,
      Formula["python@3.12"].opt_bin,
      Formula["tmux"].opt_bin,
      ENV.fetch("PATH"),
    ].join(File::PATH_SEPARATOR)
    bin.write_env_script libexec/"bin/lantern", PATH: runtime_path, HOMEBREW_PREFIX: HOMEBREW_PREFIX
  end

  test do
    assert_match "lantern #{version}", shell_output("#{bin}/lantern --version")
  end
end
