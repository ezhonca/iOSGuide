//
//  SearchSuggestionViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSuggestionTableView.h"

@interface SearchSuggestionViewController : UISearchController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) SearchSuggestionTableView *tableView;

@end
