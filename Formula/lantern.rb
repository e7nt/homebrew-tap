class Lantern < Formula
  desc "Understanding-first AI coding workbench built around Helix"
  homepage "https://github.com/e7nt/lantern"
  version "0.1.1"
  license "AGPL-3.0-only"

  depends_on "git"
  depends_on "node@22"
  depends_on "python@3.12"
  depends_on "tmux"
  depends_on :macos

  on_arm do
    url "https://github.com/e7nt/lantern/releases/download/v0.1.1/lantern-0.1.1-darwin-arm64.tar.gz"
    sha256 "d635e3adf880b073d8cc8ba889b5a4446bf37c403de36f7333ab6f1aac7fcb62"
  end

  on_intel do
    url "https://github.com/e7nt/lantern/releases/download/v0.1.1/lantern-0.1.1-darwin-x86_64.tar.gz"
    sha256 "c53a5a7890f32e29911d4f661e7b81197e5214094f0f6b29907c57d7057d70af"
  end

  def install
    libexec.install Dir["*"]
    semantic_runtime = libexec/"libexec/lantern/semantic"
    system "tar", "-C", semantic_runtime, "-cf", semantic_runtime/"vendor.tar", "vendor"
    rm_r semantic_runtime/"vendor"
    pi_runtime = libexec/"libexec/lantern/pi"
    system "tar", "-C", pi_runtime, "-cf", pi_runtime/"node_modules.tar", "node_modules"
    rm_r pi_runtime/"node_modules"
    runtime_path = [
      Formula["git"].opt_bin,
      Formula["node@22"].opt_bin,
      Formula["python@3.12"].opt_bin,
      Formula["tmux"].opt_bin,
      ENV.fetch("PATH"),
    ].join(File::PATH_SEPARATOR)
    (bin/"lantern").write_env_script libexec/"bin/lantern", PATH: runtime_path, HOMEBREW_PREFIX: HOMEBREW_PREFIX
  end

  def post_install
    semantic_runtime = libexec/"libexec/lantern/semantic"
    archive = semantic_runtime/"vendor.tar"
    if archive.exist?
      system "tar", "-C", semantic_runtime, "-xf", archive
      rm archive
    end
    pi_runtime = libexec/"libexec/lantern/pi"
    pi_archive = pi_runtime/"node_modules.tar"
    if pi_archive.exist?
      system "tar", "-C", pi_runtime, "-xf", pi_archive
      rm pi_archive
    end
  end

  test do
    assert_match "lantern #{version}", shell_output("#{bin}/lantern --version")
  end
end
