# 参考URL

- http://dsas.blog.klab.org/archives/50574774.html
- http://blog.asial.co.jp/715

# 構成

makeの際、ccが所定の場所にないというエラーが出た。
OS X command Line Toolsはインストールしてあったので、sudoで適当にシンボリックリンクを貼ってごまかす。

`/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain`
ここにならusr/bin/ccがあるが
`/Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.8.xctoolchain`
Makefileが見てるのはこっち。
そこで、

    $ cd /Applications/Xcode.app/Contents/Developer/Toolchains
    $ sudo ln -s XcodeDefault.xctoolchain OSX10.8.xctoolchain

とする。


# やりたいことを実現するためのステップ

- 設定段階のハンドラを設定する
- リクエストからカスタムHTTPヘッダ「X-Subdir」を取得し、文字列として得る
- 設定ファイル（その時点のDocumentRoot）の内容を文字列として得る
- 新しいdocrootのパスを編集し、DocumentRootを書き換える


# そのためも

## httpd.confの場所
/etc/apache2/httpd.conf
- http://blog.kcg.ne.jp/leeway/2009/12/06/mac-os-x-snow-leopardのguiでapache2のhttpd-confを編集保存する/

## docrootの場所
/Library/WebServer/Documents

