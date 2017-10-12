//
//  SearchSuggestionViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSuggestionTableView.h"

@interface SearchSuggestionViewController : UISearchController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) SearchSuggestionTableView *tableView;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, assign) BOOL searbarDidSelected;
//@property (strong, nonatomic) UINavigationController *navi;
//@property (nonatomic, strong) NSMutableDictionary *dateDic;
//@property (nonatomic, strong) NSMutableDictionary *searchResultDic;
//
//- (void)setDateDicWithRootDic:(NSDictionary *)rootDic;

@end
