//
//  KnowledgeViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchSuggestionViewController.h"

@interface KnowledgeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UICollectionView *grid;
@property (strong, nonatomic) NSDictionary *rootDic;
@property (weak, nonatomic) IBOutlet UIView *searchBarView;
@property (strong, nonatomic) SearchSuggestionViewController *searchController;

@end
