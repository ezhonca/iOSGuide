//
//  FavoriteViewController.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/10/19.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "FavoriteViewController.h"
#import "AppDelegate.h"
#import "WebViewController.h"
#import "BookmarkHandle.h"
#import "DBAccess.h"
#import "CJLFavoriteModel.h"
#import "UIView+FrameExtension.h"
#import "CJLFavoriteTableViewCell.h"
#import "UITableView+CJLAnimation.h"


@interface FavoriteViewController ()
@property(nonatomic, strong) NSMutableArray<CJLFavoriteModel *> *favoriteArray;
@end

@implementation FavoriteViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.favoriteArray = [DBAccess getAllFavorites];
    [self.tableView reloadData];
    [self.tableView startAnimationWithType:CJLTableViewAnimationAlpha];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[] mutableCopy];
//    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    self.managedObjectContext = app.persistentContainer.viewContext;
    self.title = @"收藏";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.fechedResultController.sections.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //id<NSFetchedResultsSectionInfo> sectionInfo = self.fechedResultController.sections[section];
    //return [sectionInfo numberOfObjects];
    return self.favoriteArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJLFavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteTableViewCell" forIndexPath:indexPath];
    //    NSString *key = [[self.contentsDic allKeys] objectAtIndex:indexPath.row];
    //    cell.textLabel.text = key;
    CJLFavoriteModel *favorite = self.favoriteArray[indexPath.row];
    cell.textLabel.text = favorite.name;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.addTimeLabel.text = [@"收藏于：" stringByAppendingString:favorite.time];
    [cell.addTimeLabel sizeToFit];
    //cell.detailTextLabel.x_Adjustable += 50;
    cell.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
    [cell.contentView bringSubviewToFront:cell.addTimeLabel];
    
    //cell.imageView.image = [UIImage imageNamed:@""];

    //cell.backgroundColor = [UIColor redColor];
    // Configure the cell...
    //cell.textLabel.minimumScaleFactor = 0.5;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        NSManagedObjectContext *context = self.fechedResultController.managedObjectContext;
//        [context deleteObject:[self.fechedResultController objectAtIndexPath:indexPath]];
//
//        NSError *error = nil;
//        if(![context save:&error]){
//            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//            abort();
//        }
        CJLFavoriteModel *model = self.favoriteArray[indexPath.row];
        [self.favoriteArray removeObject:model];
        [DBAccess deleteFavoriteWithName:model.name];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[BookmarkHandle DeleteBookmark:[self.fechedResultController objectAtIndexPath:indexPath]];
        
    }
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ShowWebFromFavorite"]){
        if([segue.destinationViewController isKindOfClass:[WebViewController class]]){
            WebViewController *vc = segue.destinationViewController;
            if([sender isKindOfClass:[UITableViewCell class]]){
                UITableViewCell *cell = sender;
                NSString *key = cell.textLabel.text;
                CJLTipModel *tipModel = [DBAccess getTipModelWithTipName:key];
                vc.tipModel = tipModel;
//                NSFetchRequest<Bookmark *> *request = Bookmark.fetchRequest;
//                NSPredicate * pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",key];
//                request.predicate = pre;
//                NSArray<Bookmark *> *array = [self.managedObjectContext executeFetchRequest:request error:NULL];
                //vc.urlString = [BookmarkHandle FetchBookmark:key].urlString;
                //vc.name = key;
                //vc.title = [self.contentsDic objectForKey:key];
                
            }
        }
    }
}

#pragma mark - Fetched results controller
/*
-(NSFetchedResultsController<Bookmark *> *)fechedResultController
{
    if(_fechedResultController != nil){
        return _fechedResultController;
    }
    
    NSFetchRequest<Bookmark *> *fetchedRequest = Bookmark.fetchRequest;
    [fetchedRequest setFetchBatchSize:20];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchedRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *aFetchedRequestController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchedRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"CJL"];
    aFetchedRequestController.delegate = self;
    
    NSError *error = nil;
    if(![aFetchedRequestController performFetch:&error]) {
        abort();
    }
    
    _fechedResultController = aFetchedRequestController;
 
    
        
    return _fechedResultController;
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }

}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            if([anObject isKindOfClass:[Bookmark class]]){
                 Bookmark *bookmark = (Bookmark *)anObject;
                 [tableView cellForRowAtIndexPath:indexPath].textLabel.text = bookmark.name;
            }
            break;
            
        case NSFetchedResultsChangeMove:
            if([anObject isKindOfClass:[Bookmark class]]){
                Bookmark *bookmark = (Bookmark *)anObject;
                [tableView cellForRowAtIndexPath:indexPath].textLabel.text = bookmark.name;
                [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            }
           
            break;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
*/
@end
