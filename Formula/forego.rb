class Forego < Formula
  desc "Foreman in Go for Procfile-based application management. Fork by rwc9u"
  homepage "https://github.com/rwc9u/forego"
  url "https://github.com/rwc9u/forego/releases/tag/0.20.1-proxy-support"
  sha256 "9e8464250c71b129a54f1336575825bc016ee98446b8efb0980a8afed97bb9d1"
  license "Apache-2.0"
  head "https://github.com/rwc9u/forego.git", branch: "develop"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/rwc9u/forego").install buildpath.children
    cd "src/github.com/rwc9u/forego" do
      system "go", "build", "-o", bin/"forego", "-ldflags",
             "-X main.Version=#{version} -X main.allowUpdate=false"
      prefix.install_metafiles
    end
  end

  test do
    (testpath/"Procfile").write "web: echo \"it works!\""
    assert_match "it works", shell_output("#{bin}/forego start")
  end
end
