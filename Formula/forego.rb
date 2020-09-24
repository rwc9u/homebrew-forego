class Forego < Formula
  desc "Foreman in Go for Procfile-based application management. Fork by rwc9u"
  homepage "https://github.com/rwc9u/forego"
  url "https://github.com/rwc9u/forego/archive/0.20.0-3-gc52882b.tar.gz"
  sha256 "355b2cba661f499058e7e4020713083a34ef43d54eaf9c9408dbb393e5eca3aa"
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
