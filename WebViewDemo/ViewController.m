//
//  ViewController.m
//  WebViewDemo
//
//  Created by cwn on 2019/4/9.
//  Copyright © 2019年 cwn. All rights reserved.
//

#import "ViewController.h"
#import "MyUIWebView.h"

@interface ViewController ()
@property (strong, nonatomic) MyUIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView cwn_makeConstraints:^(UIView *maker) {
        maker.edgeInsetsToSuper(UIEdgeInsetsZero);
    }];
    
    NSString *url = [[NSBundle mainBundle] pathForResource:@"WKWebViewDemo" ofType:@"html"];
    [self.webView loadUrlString:url];
    // Do any additional setup after loading the view from its nib.
}

- (MyUIWebView *)webView {
    if (!_webView) {
        _webView = [MyUIWebView new];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
