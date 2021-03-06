require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Swoole < AbstractPhp71Extension
  init
  desc "Event-driven asynchronous & concurrent networking engine for PHP."
  homepage "https://pecl.php.net/package/swoole"
  url "https://github.com/swoole/swoole-src/archive/v2.1.0.tar.gz"
  version "2.1.0"
  sha256 "a569ad163059519d0378c45ea2dc6f9971c1c061d4f40bac8c3b63b2d8e2249f"
  head "https://github.com/swoole/swoole-src.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a37008f95e363eee9027546199fed1e8c72a2ff7f5b6a9a1b5ba048aa6d91ab5" => :sierra
    sha256 "f17facd20ff33f71cdcc46604c7e4287d4634d4bcb106b333e72143904409764" => :el_capitan
    sha256 "8dbf96eea7e1fc6bfc3fc9431a700010651058e23db2f227010d251305f11e45" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--enable-coroutine", phpconfig
    system "make"
    prefix.install "modules/swoole.so"
    write_config_file if build.with? "config-file"
  end
end
