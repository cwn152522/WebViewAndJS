//
//  ViewControllerV2.m
//  WebViewDemo
//
//  Created by cwn on 2019/4/9.
//  Copyright © 2019年 cwn. All rights reserved.
//

#import "ViewControllerV2.h"
#import "MyWebView.h"

@interface ViewControllerV2 ()
@property (strong, nonatomic) MyWebView *webView;
@end

@implementation ViewControllerV2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView cwn_makeConstraints:^(UIView *maker) {
        maker.edgeInsetsToSuper(UIEdgeInsetsZero);
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WKWebViewDemo" ofType:@"html"];
    [self.webView loadUrl:[NSURL fileURLWithPath:path]];
    // Do any additional setup after loading the view from its nib.
}

- (MyWebView *)webView {
    if (!_webView) {
        _webView = [MyWebView new];
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
