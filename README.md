xProcessing
======================

About
--------
iOSでただシンプルにProcessingを動かすためのプロジェクト一式です。  
WebViewとprocessing.jsだけのシンプルな構成なのが特徴です。  
Xcode 4.6を対象としています。

使い方は簡単、app/app.pdeにProcessingのコードを書いて実行するだけです。

![画面例](http://cafe.eyln.com/GitHub/xProcessing/screenshot.jpg "ScreenShot")

Extra
-------
オマケとしてJavaScriptとnativeAPI (ObjectiveC) の連携処理のサンプルが入っています。  
連携しているコードはapp/xcode.jsとxProcessing/P5ViewController.mにあります。

Attention
-----------
デフォルトでwebGLを有効にしていますが、これはあくまで実験用の処理です。  
AppStoreに申請する際にはenableWebGLメソッドをプログラムから削除した方がよいかもしれません。

#### P5ViewController.m
    
    - (void)viewDidLoad
    {
        [super viewDidLoad];
    
        [self enableWebGL]; // P3Dを使用する場合に必要(実験用)
    
        // 中略
    }
    
    // 中略
    
    // WebGLを有効にする（実験用）
    - (void)enableWebGL
    {
        id webDocumentView = [webView performSelector:@selector(_browserView)];
        id backingWebView = [webDocumentView performSelector:@selector(webView)];
        [backingWebView setValue:[NSNumber numberWithBool:YES] forKey:@"WebGLEnabled"];
    }
 
License
----------
Copyright &copy; 2013 NISHIDA Ryota
Distributed under the [ZLIB License][ZLIB].
 
[ZLIB]: http://opensource.org/licenses/zlib
