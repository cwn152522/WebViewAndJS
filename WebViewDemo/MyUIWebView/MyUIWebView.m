//
//  MyUIWebView.m
//  WebViewDemo
//
//  Created by cwn on 2019/4/9.
//  Copyright © 2019年 cwn. All rights reserved.
//

#import "MyUIWebView.h"

@interface MyUIWebView()<UIWebViewDelegate>
@property (strong, nonatomic) JSContext *context;
@end

@implementation MyUIWebView
@synthesize sum = _sum;

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.webView];
        [self.webView cwn_makeConstraints:^(UIView *maker) {
            maker.edgeInsetsToSuper(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}


- (void)loadUrlString:(NSString *)urlString {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //js调oc
      //方式1
    {
        //创建context
        self.context = context;
        //设置异常处理
        self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
            [JSContext currentContext].exception = exception;
            //            NSLog(@"exception:%@",exception);
        };
        //将obj添加到context中
        self.context[@"OCObj"] = self;
    }
    
    
      //方式2
      //定义好JS要调用的方法, f2就是调用的f2方法名
    context[@"f2"] = ^{
        NSArray *args = [JSContext currentArguments];
        
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSString *result = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"hello(%d)", arc4random()%2]];//调用js，直接拿到返回值
//            NSLog(@"%@", result);
//            [weakContext evaluateScript:[NSString stringWithFormat:@"hello(%d)", arc4random()%2]];
        });
        
        //直接返回值给js
        return [NSString stringWithFormat:@"%d", 3];
    };
}



//实现协议方法
- (NSInteger)add:(NSInteger)a b:(NSInteger)b
{
    return a+b;
}
- (void)hello:(NSString *)msg{
    NSLog(@"%@", msg);
}
//重写setter方法方便打印信息，
- (void)setSum:(NSInteger)sum
{
    NSLog(@"--%@", @(sum));
    _sum = sum;
}
@end
