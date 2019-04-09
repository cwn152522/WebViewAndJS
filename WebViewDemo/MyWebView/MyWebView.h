//
//  MyWebView.h
//  MyWebView
//
//  Created by cwn on 2017/7/18.
//  Copyright © 2017年 cwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "WeakScriptMessageDelegate.h"
//#import "WebManager.h"
//
//static  NSString* javaScript_isNeedNotice   = @"notice";     // 通知web需要更新
//static  NSString* javaScript_evaluate       = @"evaluate";  // 粉丝圈中老师文章的评价

@protocol MyWebViewDelegate;

@interface MyWebView : UIView

@property (nonatomic,weak) id <MyWebViewDelegate> delegate;

@property(strong,nonatomic) WKWebView *webView;
//@property (strong ,nonatomic) WebManager *webManager;

@property (assign ,nonatomic) BOOL notLoading;  // 不需要加载视图
@property (assign ,nonatomic) NSTimeInterval loadOutTime;  // 加载超时时间

/**
 加载网页
 */
-(void)loadUrlString:(NSString *)urlString;
-(void)loadUrl:(NSURL *)url;
/**
 移除loading视图
 */
- (void)removeLoadingView;
/**
 执行某些 JS 代码

 @param promptCode 自定义 JS code
 @param type 已定的 JS code
 */
-(void)evaluateJavaScript:(NSString*)promptCode orJavaScriptType:(NSString*)type;


@end



@protocol MyWebViewDelegate <NSObject>

@optional

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
/**
 开始加载
 */
- (void)didStartWebView:(MyWebView *)webView;
/**
 完成加载
 */
- (void)didFinishWebView:(MyWebView *)webView;
/**
 加载失败
 */
- (void)didFailWebView:(MyWebView *)webView;

/**
 获取到标题
 */
- (void)didGetTitle:(NSString *)title;

/**
 超时
 */
- (void)loadWebTimeOut;

@end

