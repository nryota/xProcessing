//
//  P5ViewController.m
//  xProcessing
//
//  Created by n_ryota on 13/5/5.
//  Copyright (c) 2012 n_ryota. All rights reserved.
//

#import "P5ViewController.h"
#import "P5SubViewController.h"

@interface P5ViewController ()

@end

@implementation P5ViewController

// インスタンス生成時の処理
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self enableWebGL]; // P3Dを使用する場合に必要(実験用)

    webView.delegate = self;

    // WebViewでindex.htmlを表示
    NSString *path = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //NSURL *url = [NSURL URLWithString:@"http://www.google.com/"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];

    [webView loadRequest:req];
}

// メモリ不足時の処理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// WebGLを有効にする（実験用）
- (void)enableWebGL
{
    id webDocumentView = [webView performSelector:@selector(_browserView)];
    id backingWebView = [webDocumentView performSelector:@selector(webView)];
    [backingWebView setValue:[NSNumber numberWithBool:YES] forKey:@"WebGLEnabled"];
}

// URLリクエスト時のカスタムスキームを判別し、JavaScriptからObjectiveCの機能を呼ぶ
- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
    navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    if ([requestString rangeOfString:@"native-api://"].location == NSNotFound){
        return YES;
    }
    
    NSError *error = nil;
    NSString *pattern = [NSString stringWithFormat:@"native-api://(.+)\\((.*)\\)"];
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if(error != nil){
        NSLog(@"nativeAPI: error : %@", [error description]);
        return NO;
    }
    
    NSTextCheckingResult *match = [reg firstMatchInString:requestString options:0 range:NSMakeRange(0, requestString.length)];
    if(match.numberOfRanges == 0){
        NSLog(@"nativeAPI: not match");
        return NO;
    }
    
    NSString *method = [requestString substringWithRange:[match rangeAtIndex:1]];
    NSString *params = [requestString substringWithRange:[match rangeAtIndex:2]];
    NSLog(@"nativeAPI: call '%@' params:`%@`", method, params);

    if(![self callNativeAPI:method params:params]) {
        NSLog(@"nativeAPI: '%@' not found", method);
        return NO;
    }
    return NO;
}

// ObjectiveCからJavaScriptの関数を呼ぶ
// 例)[self callJsAPI:@"alert('test');"];
// 例)[self callJsAPI:@"p5jsAPI_sample();"];
-(void)callJsAPI:(NSString *)jscode
{
    [webView stringByEvaluatingJavaScriptFromString:jscode];
}

// JavaScriptからObjectiveCの関数を呼ぶ
// 例)[callNativeAPI:@"nativeAPI_sample params:test"];
//
// JavaScriptコード上の例)
//  function nativeAPI_sample() {
//    document.location = "native-api://sample(message)"
//  }
-(BOOL)callNativeAPI:(NSString *)method params:(NSString *)params
{
    if([method isEqualToString:@"alert"]){
        [self nativeAPI_alert:params];
        return TRUE;
    }
    if([method isEqualToString:@"showSubView"]){
        [self nativeAPI_showSubView];
        return TRUE;
    }
    return FALSE;
}

// JavaScriptから呼び出すNativeコードのサンプル（ダイアログを表示）
-(void)nativeAPI_alert:(NSString *)message
{
    // ダイアログを表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                            message:message delegate:nil
                            cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

// JavaScriptから呼び出すNativeコードのサンプル（サブビューを表示）
-(void)nativeAPI_showSubView
{
    P5SubViewController *subView;
    subView = [self.storyboard instantiateViewControllerWithIdentifier:@"P5SubViewController"];
    [self presentViewController:subView animated:YES completion:nil];

    // 逆にNativeコードからJavaScriptコードを呼ぶテスト
    [self callJsAPI:@"p5jsAPI_ellipse(255, 255, 0);"];
}

@end
