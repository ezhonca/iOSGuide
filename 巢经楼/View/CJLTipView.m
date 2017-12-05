//
//  CJLTipView.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/5.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "CJLTipView.h"
#import <WebKit/WebKit.h>
#import "CJLTipModel.h"

@implementation CJLTipView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(UIView *)tipViewWithTipModel:(CJLTipModel *)tipModel
{
    switch (tipModel.type) {
        case CJLTipViewTypeWeb:{
            WKWebView *webView = [[WKWebView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tipModel.URL] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:120]];
            return webView;
            break;}
        case CJLTipViewTypeImage:{
            return [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            break;}
        case CJLTipViewTypeText:{
            return [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            break;}
            
      
    }
}
@end
