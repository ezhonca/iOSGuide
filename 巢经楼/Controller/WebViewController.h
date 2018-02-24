//
//  WebViewController.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/28.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "BookmarkModel+CoreDataModel.h"
#import "AppDelegate.h"
#import "BookmarkHandle.h"
#import "CJLTipView.h"

@interface WebViewController : UIViewController<WKNavigationDelegate>

@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *name;
//@property(nonatomic, strong) Bookmark *bookmark;
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIView *tipView;
@property (strong, nonatomic) CJLTipModel *tipModel;
@property (nonatomic, assign) BOOL isFavorite;

@end
