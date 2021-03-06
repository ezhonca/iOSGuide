//
//  SearchSuggestionTableView.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/30.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HotLabelDidClickBlock)(NSString *);
typedef void (^ClearButtonClickBlock)(void);

@interface SearchSuggestionTableView : UITableView

@property(nonatomic, strong) HotLabelDidClickBlock hotLabelDidClickBlock;
@property(nonatomic, strong) ClearButtonClickBlock clearButtonClickBlock;

@end
