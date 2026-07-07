class RapidReminder < Formula
  desc "Set reliable reminders from messy human text without breaking terminal flow"
  homepage "https://github.com/e7nt/rapid-reminder"
  url "https://github.com/e7nt/rapid-reminder/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4fe9584e8455faca81639ff9ceefad110235908961dacc2e0955b2579d9de54a"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/e7nt/rapid-reminder.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rr --version")
    assert_match "Reminder set", shell_output("HOME=#{testpath} XDG_DATA_HOME=#{testpath} " \
                                              "#{bin}/rr in 5 mins brew smoke test")
  end
end
