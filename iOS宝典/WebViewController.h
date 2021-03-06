//
//  WebViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/28.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController<WKNavigationDelegate>

@property(nonatomic, strong) NSString *urlString;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end
