//
//  MyUIWebView.h
//  WebViewDemo
//
//  Created by cwn on 2019/4/9.
//  Copyright © 2019年 cwn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

//定义一个JSExport protocol
@protocol JSExportTest <JSExport>

//用宏转换下，将JS函数名字指定为add；
JSExportAs(add, - (NSInteger)add:(NSInteger)a b:(NSInteger)b);
- (void)hello:(NSString *)msg;
@property (nonatomic, assign) NSInteger sum;

@end



@interface MyUIWebView : UIView<JSExportTest>
@property (strong, nonatomic) UIWebView *webView;

/**
 加载网页
 */
-(void)loadUrlString:(NSString *)urlString;
@end
