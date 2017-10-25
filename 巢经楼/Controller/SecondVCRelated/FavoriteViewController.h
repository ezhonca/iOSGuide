//
//  FavoriteViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/10/19.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookmarkModel+CoreDataModel.h"

@interface FavoriteViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property(strong, nonatomic) NSFetchedResultsController<Bookmark *> *fechedResultController;

@end
