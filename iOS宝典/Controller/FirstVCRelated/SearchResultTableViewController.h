//
//  SearchResultTableViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TableViewDidScrollBlock) (void);
typedef void (^TableViewDidSelectedBlock) (NSString *, NSString *);

@interface SearchResultTableViewController : UITableViewController
@property (nonatomic, strong) TableViewDidScrollBlock tableViewDidScrollBlock;
@property (nonatomic, strong) TableViewDidSelectedBlock tableViewDidSelectedBlock;
@property (nonatomic, strong) NSMutableDictionary *dateDic;
@property (nonatomic, strong) NSString *searchString;
//
//- (void)setDateDicWithRootDic:(NSDictionary *)rootDic;


@end
