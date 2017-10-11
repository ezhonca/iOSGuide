//
//  CONSTFile.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/10/10.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//


#import "UIView+FrameExtension.h"
#import <UIKit/UIKit.h>

#define SEARCHHISTORY_CACHEPATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Searchhistories.plist"] // the path of search record cached

UIKIT_EXTERN CGFloat const HOTSEARCH_MARGIN;
UIKIT_EXTERN NSInteger const SEARCHHISTORY_COUNT;
//UIKIT_EXTERN NSString const *SEARCHHISTORY_CACHEPATH;

