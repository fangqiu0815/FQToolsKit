//
//  FQWKWebViewController.h
//  FQWKWebView
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKWebView;
@protocol FQWebViewDelegate<NSObject>

@optional
- (BOOL)FQWebView:(WKWebView *)webview shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType;

@end

@interface FQWKWebViewController : UIViewController
//delegate
@property (nonatomic, weak) id <FQWebViewDelegate> delegate;
/** 是否显示Nav */
@property (nonatomic,assign) BOOL isNavHidden;
- (void)loadURL:(NSURL *)URL;

/**
 加载纯外部链接网页
 
 @param string URL地址
 */
- (void)loadWebURLSring:(NSString *)string;

/**
 加载本地网页
 
 @param string 本地HTML文件名
 */
- (void)loadWebHTMLSring:(NSString *)string;

/**
 加载外部链接POST请求(注意检查 XFWKJSPOST.html 文件是否存在 )
 postData请求块 注意格式：@"\"username\":\"xxxx\",\"password\":\"xxxx\""
 
 @param string 需要POST的URL地址
 @param postData post请求块
 */
- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData;


@end
