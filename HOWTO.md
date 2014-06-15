# 参考URL

- http://dsas.blog.klab.org/archives/50574774.html
- http://blog.asial.co.jp/715

- http://httpd.apache.org/docs/2.2/developer/API.html#basics
- http://apr.apache.org/docs/apr/1.4/

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

# その他メモ

## でフォルトのhttpd.confの場所

/etc/apache2/httpd.conf

- http://blog.kcg.ne.jp/leeway/2009/12/06/mac-os-x-snow-leopardのguiでapache2のhttpd-confを編集保存する/

## デフォルトのdocrootの場所

/Library/WebServer/Documents

## プリコンパイル

### まず

構造体の構成とかAPIがぜんぜん分からんので、取り込むヘッダファイルを見る。
Apacheならちゃんとコメント書いてあるはず。またC言語ならコンパイル時に必ず定義を書いた.hを取り込んでいるはず。
ヘッダファイルの場所が分からないが、コンパイルオプションの指定でプリコンパイル時点で止めることができる。
ccの-Eオプションでプリコンパイルで止める。 これだけだとコメントが除去されてしまうので、-Cオプションでコメントを残す。

で、makeのコンパイルのコマンドに -E -C を加えて結果をリダイレクトする。

    $ /Applications/Xcode.app/Contents/Developer/Toolchains/OSX10.8.xctoolchain/usr/bin/cc -I/usr/local/include    -DDARWIN -DSIGPROCMASK_SETS_THREAD_MASK    -I/usr/include/apache2 -I. -I/usr/include/apr-1  -c mod_hello_module.c -C -E > precompile.txt

### 大事そうなヘッダファイル

- # 1 "/usr/include/apache2/httpd.h" 1
- # 1 "/usr/include/apache2/ap_config.h" 1

/usr/include/apache2 の下にapache関連のヘッダファイルがあるようだ。

- # 1 "/usr/include/apr-1/apr.h" 1

aprとはApache Portable Runtimeの略で、環境の違いを吸収するライブラリっぽい。
ApacheのコアDSO(動的共有オブジェクト)関数はAPRのAP_DECLARE()というマクロで定義されている。


