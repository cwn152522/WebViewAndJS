//
//  MyWebView.m
//  MyWebView
//
//  Created by cwn on 2017/7/18.
//  Copyright © 2017年 cwn. All rights reserved.
//

#import "MyWebView.h"
//#import "IndicatorView.h"
#import <WebKit/WebKit.h>

@interface MyWebView()<WKNavigationDelegate,MyWebViewDelegate, UIScrollViewDelegate, WKScriptMessageHandler>

@property (strong ,nonatomic) UIProgressView *progress;
//@property (strong ,nonatomic) IndicatorView *loading;
@property (copy ,nonatomic) NSString *urlString;
@property (assign ,nonatomic) BOOL isLoaded;
@property (strong ,nonatomic) NSTimer *timer;

@end

@implementation MyWebView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.webView];
        self.loadOutTime = 10.0;
//        kAvailable(11, self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;);
        [self insertSubview:self.progress aboveSubview:self.webView];
//        [self.webView addSubview:self.loading];
        
        [self.webView cwn_makeConstraints:^(UIView *maker) {
            maker.leftToSuper(0).rightToSuper(0).topToSuper(0).bottomToSuper(0);
        }];
        
        [self.progress cwn_makeConstraints:^(UIView *maker) {
            maker.leftToSuper(0).rightToSuper(0).topToSuper(0).height(2);
        }];
        
//        [self.loading cwn_makeConstraints:^(UIView *maker) {
//            maker.centerXtoSuper(0).centerYtoSuper(0);
//        }];
        
//        WS(ws);
//        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            switch (status) {
//                case AFNetworkReachabilityStatusReachableViaWWAN:
//                {
//                    if (ws.isLoaded==NO) {
//                        [ws loadUrlString:ws.urlString];
//                    }
//                }
//                    break;
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                {
//                    if (ws.isLoaded==NO) {
//                        [ws loadUrlString:ws.urlString];
//                    }
//                }
//                    break;
//
//                default:
//                    break;
//            }
//        }];
//        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    return self;
}

-(void)setNotLoading:(BOOL)notLoading{
    if (notLoading) {
        [self.progress removeFromSuperview];
        //        [self.loading removeFromSuperview];
    }
}
- (void)removeLoadingView {
    [self.progress removeFromSuperview];
//    [self.loading removeFromSuperview];
}

- (void)endFullScreen {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
-(WKWebView *)webView{
    if (_webView==nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:config];
        _webView.navigationDelegate = self;
        _webView.scrollView.delegate = self;
        _webView.opaque = NO;
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        _webView.backgroundColor = [UIColor clearColor];
//        kAvailable(9.0, _webView.allowsBackForwardNavigationGestures = YES;);
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];
//        NSArray* methods = @[
//                             copyWeiXinHao,         // 复制微信号
//                             getCurrentContent,     // 获取当前剪切板内容
//                             goToWeiXinApp,         // 跳转微信号
//                             closeCurrentView,      // 关闭当前页面
//                             getPopInfo,            //
//                             goToHistory,           // 跳转大师金股历史
//                             alertMessage,          // 系统弹窗
//                             alertToastMessage,     // 吐丝提示
//                             getWebShowType,
//                             getPCode,
//                             showDredgeTimePicker,
//                             goToIOSNavWebView,     // 跳转新的web页面
//                             handleArticleAuthority,// 处理文章权限
//                             getWeiXinAccount,      // 获取微信账号
//                             getUserIdInfo,         // 获取用户id
//                             getUserAccountFromWeb, // 从web注册获取帐号
//                             goToGFLiaoTianShi,     // 跳转聊天室
//                             handleAuthority,       // 处理权限
//                             callMe,                // 测试打电话
//                             goToLoginPage,         // 跳转登录页面
//                             goBackHomePage,        // 返回首页
//                             isInstallWX,           // 是否安装微信
//                             getAuthority,          // 获取权限
//                             goToZhangYuMing,       // 跳转张宇明
//                             goToLive,              // 跳转直播
//                             goToVideoDetail,       // 跳转录播
//                             goToPersonalCenter,    // 跳转个人中心
//                             goToPersonalChat,      // 跳转私聊
//                             goToXiaoChengXu,       // 跳转小程序
//                             goToAIZhenGu,          // 跳转AI诊股
//                             goToZhiHuiKXian,       // 跳转智慧k线
//                             goToShiNianGuiLv,      // 跳转十年规律
//                             goToZhangDieSanXian,   // 跳转涨跌三线
//                             goToMaiMaiBoYi,        // 跳转买卖博弈
//                             goToBaFeiTe,           // 跳转超级巴菲特
//                             goToGuiDaoXian,        // 跳转超级轨道线
//                             goToJiaoXue,           // 跳转教学
//                             goToModule,            // 跳转模块
//                             webBounces,            // web的反弹能力
//                             getAppAllInfo,         // 获取应用信息
//                             shareInfo,             // 分享
//                             signInCompletion,      // 签到完成
//                             isNeedNotice,          // 当前web需要通知
//                             evaluationEvent,       // web中的评价事件
//                             goToLiveNormal,        // 跳转直播，可正常返回
//                             showPictures,          // 显示图片
//                             ];
//        for (NSString* method in methods) {
//            [_webView.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self.webManager] name:method];
//        }
        [_webView.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"f2"];
    }
    return _webView;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSString *name = message.name;;
    NSDictionary *obj = message.body;
    [_webView evaluateJavaScript:[NSString stringWithFormat:@"hello(%d)", arc4random()%2] completionHandler:nil];
}
- (void)onclickBtn{
    NSLog(@"哈哈哈");
}


-(UIProgressView *)progress{
    if (_progress==nil) {
        _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progress.trackTintColor = [UIColor lightGrayColor];
        _progress.progressTintColor = [UIColor greenColor];
        _progress.frame = CGRectMake(0, 0, self.bounds.size.width, 2);
    }
    return _progress;
}

//-(IndicatorView *)loading{
//    if (_loading==nil) {
//        _loading = [[IndicatorView alloc] initWithType:IndicatorTypeMusic1 tintColor:RiseColor];
//        _loading.center = CGPointMake(self.webView.bounds.size.width/2.0, self.webView.bounds.size.height/2.0);
//    }
//    return _loading;
//}

-(NSTimer *)timer{
    if (_timer==nil) {
        _timer = [[NSTimer alloc] initWithFireDate:[NSDate distantFuture] interval:self.loadOutTime target:self selector:@selector(timeOutAction) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}

//-(WebManager *)webManager{
//    if (_webManager==nil) {
//        _webManager = [[WebManager alloc] initWithWeb:self.webView withObject:nil];
//    }
//    return _webManager;
//}

#pragma mark - <************************** 代理 **************************>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [self.delegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
/// 开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    DLog(@"url:%@",webView.URL.absoluteString);
//    [self.loading startAnimating];
    // 设置 userId
    [self setUpUserId];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didStartWebView:)]) {
        [self.delegate didStartWebView:self];
    }
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.loadOutTime]];
}

/// 获取到网页内容
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"获取到内容");
    [self setUpUserId];
}
/// 加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
    
    [self setUpUserId];
//    [self.loading stopAnimating];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didFinishWebView:)]) {
        [self.delegate didFinishWebView:self];
    }
    self.isLoaded = YES;
    [self.timer invalidate];
}
/// 加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败");
    [self setUpUserId];
//    [self.loading stopAnimating];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didFailWebView:)]) {
        [self.delegate didFailWebView:self];
    }
    [self.timer invalidate];
}
//服务器返回200以外的状态码时，都调用请求失败的方法，从而可以做一些处理。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
//    if (((NSHTTPURLResponse *)navigationResponse.response).statusCode == 200) {
//        decisionHandler (WKNavigationResponsePolicyAllow);
//    }else {
//        decisionHandler(WKNavigationResponsePolicyCancel);
//    }
}


#pragma mark - <************************** kvo监听 **************************>
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // 监听标题
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView){
            if (self.delegate&&[self.delegate respondsToSelector:@selector(didGetTitle:)]) {
                [self.delegate didGetTitle:self.webView.title];
            }
        }
        else
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
    // 监听进度
    else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webView) {
            NSLog(@"%f",self.webView.estimatedProgress);
            [self.progress setProgress:self.webView.estimatedProgress animated:YES];
            self.progress.hidden = self.progress.progress==1?YES:NO;
            self.progress.progress = self.progress.progress==1?0:self.progress.progress;
            if (self.progress.progress==1) {
//                [self.loading stopAnimating];
            }
        }
        else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}




#pragma mark - <************************** 私有方法 **************************>
-(void)loadUrlString:(NSString *)urlString{
    if (urlString.length==0) {
        return;
    }
    urlString = ![urlString hasPrefix:@"http"] ? [@"http://" stringByAppendingString:urlString] : urlString;
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    _urlString = urlString;
    
    if ([self hasChinese:urlString]) {
        NSArray* list = [urlString componentsSeparatedByString:@"?"];
        NSString* headString = [NSString stringWithFormat:@"%@?",list.firstObject];
        NSString* query = [urlString stringByReplacingOccurrencesOfString:headString withString:@""];
        query = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        urlString = [NSString stringWithFormat:@"%@%@",headString,query];
    }
    
    NSURL *URL = [NSURL URLWithString:urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}
- (void)loadUrl:(NSURL *)url{
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

//判断是否有中文
-(BOOL)hasChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}
-(void)timeOutAction{
//    [self.loading stopAnimating];
    [self.webView stopLoading];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(loadWebTimeOut)]) {
        [self.delegate loadWebTimeOut];
    }
    [self.timer invalidate];
}

// !!!!: 处理登录成功的通知，重新设置 userId
-(void)handleLoginSucceed:(NSNotification*)noti{
    [self setUpUserId];
    [self operateWeb];
}
-(void)handleChangeSegement:(NSNotification*)noti{
    NSString *promptCode = [NSString stringWithFormat:@"iosStopVideo(\"\")"];
    [self.webView evaluateJavaScript:promptCode completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
}

-(void)setUpUserId{
    // 主动调用web，提供userId给web
//    NSString *userid = GetInfoForKey(kUserid_UserDefaults);
//    NSDictionary* dic = @{@"userid":userid.length?userid:@""};
//    NSData* data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    if (data) {
//        NSString* jsonString = [NSString stringWithFormat:@"userid=%@",userid];
//        NSString *JSCode = [NSString stringWithFormat:@"window.GLOBAL_USERINFO=(\"%@\")",jsonString];
//        [self.webView evaluateJavaScript:JSCode completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//            if (error) {
//                DLog(@"----:%@",error.localizedDescription);
//            }
//        }];
//    }
}

-(void)operateWeb{
    NSString *promptCode = [NSString stringWithFormat:@"nativeLoginSuccess(\"\")"];
    [self.webView evaluateJavaScript:promptCode completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
}


// !!!!: 执行某种code
/**
 执行某种code

 @param promptCode js代码
 @param type 已定了类型
 */
-(void)evaluateJavaScript:(NSString*)promptCode orJavaScriptType:(NSString*)type{
//    if ([type isEqualToString:javaScript_isNeedNotice]) {
////        if (self.webManager.needRefresh == NO) {
////            return;
////        }
//        promptCode = [NSString stringWithFormat:@"webNoticed(\"\")"];
//    } else if ([type isEqualToString:javaScript_evaluate]) {
//        promptCode = [NSString stringWithFormat:@"appUserComment(\"\")"];
//    }
    if (promptCode.length == 0) {
        return;
    }
    [self.webView evaluateJavaScript:promptCode completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        
    }];
}



#pragma mark - <************************** dealloc **************************>
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.timer invalidate];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self deleteWebCache];
}


- (void)deleteWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[
                                                        WKWebsiteDataTypeDiskCache,
                                                        WKWebsiteDataTypeOfflineWebApplicationCache,
                                                        WKWebsiteDataTypeMemoryCache,
                                                        WKWebsiteDataTypeLocalStorage,
                                                        WKWebsiteDataTypeCookies,
                                                        WKWebsiteDataTypeSessionStorage,
                                                        WKWebsiteDataTypeIndexedDBDatabases,
                                                        WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

@end
