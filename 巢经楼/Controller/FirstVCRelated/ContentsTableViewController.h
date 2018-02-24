//
//  ContentsTableViewController.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/27.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bookmark+CoreDataClass.h"
#import "BookmarkHandle.h"
@class CJLTipModel;

@interface ContentsTableViewController : UITableViewController

@property(nonatomic, copy) NSDictionary *contentsDic;
@property(strong, nonatomic) NSArray<CJLTipModel *> *tipsArray;

@end
