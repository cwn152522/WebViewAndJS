//
//  TabBarViewController.m
//  WebViewDemo
//
//  Created by cwn on 2019/4/9.
//  Copyright © 2019年 cwn. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"
#import "ViewControllerV2.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ViewController *vc = [ViewController new];
    vc.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    vc.tabBarItem.title = @"UIWebView";
    [self addChildViewController:vc];
    
    ViewControllerV2 *vc2 = [ViewControllerV2 new];
    vc2.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    vc2.tabBarItem.title = @"WKWebView";
    [self addChildViewController:vc2];
    
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
