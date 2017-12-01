//
//  KnowledgeDetailTableViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/21.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpandableTableViewHeaderModel.h"

@interface KnowledgeDetailTableViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *knowledgeDetailDic;
@property (strong, nonatomic) NSMutableArray *ExpandableModelArray;
@property (nonatomic, strong) NSArray *firstCatalogArray;
@property (nonatomic, strong) NSArray<NSArray *> *secondCatalogsArray;



@end
