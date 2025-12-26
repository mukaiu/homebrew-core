class Vapor < Formula
  desc "Command-line tool for Vapor (Server-side Swift web framework)"
  homepage "https://vapor.codes"
  url "https://github.com/vapor/toolbox/archive/refs/tags/20.0.0.tar.gz"
  sha256 "b3b215a69ae8b5235d4f37229313ee1947de5c5b9ad2142a76b17c105dd758cf"
  license "MIT"
  head "https://github.com/vapor/toolbox.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0b7badbe8dc247d8711759c98c039f5ac2b606177482d8de73b54d6067ec9cfe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fda51b3a3a414b157f4907120e23cf7dd7dae9c20020f182934a9fc7cffeec27"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "28ef956bc555e48cd0a6a3aa2123b1d0d8ffe3375f9f9e31d5bbf8741f8f4aab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ff2a31edb179938c3463129948bb4ab6cf2f017596349bcee15eab0d831bd7e"
  end

  depends_on xcode: ["26.0", :build]
  depends_on macos: :sequoia

  uses_from_macos "swift" => :build

  def install
    args = if OS.mac?
      ["--disable-sandbox"]
    else
      ["--static-swift-stdlib"]
    end
    system "swift", "build", *args, "-c", "release", "-Xswiftc", "-cross-module-optimization"
    bin.install ".build/release/vapor"
  end

  test do
    system bin/"vapor", "new", "hello-world", "-n"
    assert_path_exists testpath/"hello-world/Package.swift"
  end
end
