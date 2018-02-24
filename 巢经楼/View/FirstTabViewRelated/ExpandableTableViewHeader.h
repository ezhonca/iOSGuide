//
//  ExpandableTableViewHeader.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/26.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableTableViewHeaderModel.h"

typedef void (^HeaderViewClickBackBlock)(void);


@interface ExpandableTableViewHeader : UITableViewHeaderFooterView

//@property (nonatomic, strong) ExpandableTableViewHeaderModel *headerModel;
@property (nonatomic, strong) HeaderViewClickBackBlock headerClickBackBlock;
@property (nonatomic, strong) UIImageView *accessoryView;
@property (nonatomic, strong) UIColor *headerColor;

@end
