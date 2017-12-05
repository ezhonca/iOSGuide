//
//  ContentsTableViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/27.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "ContentsTableViewController.h"
#import "WebViewController.h"
#import "AppDelegate.h"


@interface ContentsTableViewController ()

@property(strong, nonatomic) NSString *key;
@property(strong, nonatomic) UIMenuItem *favorate;

@end

@implementation ContentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //return self.contentsDic.count;
    return self.tipsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    NSString *key = [[self.contentsDic allKeys] objectAtIndex:indexPath.row];
//    cell.textLabel.text = key;
    cell.textLabel.text = self.tipsArray[indexPath.row];
  
    // Configure the cell...
    //cell.textLabel.minimumScaleFactor = 0.5;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [cell addGestureRecognizer:longPress];
    return cell;
}

-(void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {

        UITableViewCell *cell = (UITableViewCell *)recognizer.view;
        //bool a = [cell isFirstResponder];
        [self becomeFirstResponder];
        //[cell becomeFirstResponder];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        self.key = [[self.contentsDic allKeys] objectAtIndex:indexPath.row];
        
        //UIMenuItem *favorate = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(addFavorate:)];
        if(self.favorate == nil){
            self.favorate = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(addFavorate:)];
        }
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:self.favorate, nil]];
        [menu setTargetRect:cell.frame inView:cell.superview];
        [menu setMenuVisible:YES animated:YES];
        //[cell resignFirstResponder];
        //[menu setMenuVisible:NO];
//        if (![menu isMenuVisible]) {
//            UIWindow *window = [[UIApplication sharedApplication].delegate window];
//            if ([window isKeyWindow] == NO) {
//                [window becomeKeyWindow];
//                [window makeKeyAndVisible];
//                [menu setMenuVisible:YES animated:YES];
//            }  }
    }
}

-(void)addFavorate:(id)sender
{
    //id view = [sender superview];
    NSLog(@"举报啦");
    if([sender isKindOfClass:[UIMenuController class]]){
        [BookmarkHandle InsertBookmark:self.key WithBookmarkUrl:[self.contentsDic objectForKey:self.key]];
//
//        Bookmark *bookmark = [[Bookmark alloc] init];
//        bookmark.name = self.key;
//        bookmark.urlString = [self.contentsDic objectForKey:self.key];
//        AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        NSManagedObjectContext *managedObjectContext = app.persistentContainer.viewContext;
////        [managedObjectContext insertObject:bookmark];
//
//        Bookmark *bookmark = [[Bookmark alloc] initWithContext:managedObjectContext];
//        bookmark.name = self.key;
//        bookmark.urlString = [self.contentsDic objectForKey:self.key];
//        NSError *error = nil;
//        if (![managedObjectContext save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//            abort();
//        }
       
    
    
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(addFavorate:))
    {
        return YES;
    }
   
    
    return NO;
    

}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    if([segue.identifier isEqualToString:@"ShowWeb"]){
        if([segue.destinationViewController isKindOfClass:[WebViewController class]]){
            WebViewController *vc = segue.destinationViewController;
            if([sender isKindOfClass:[UITableViewCell class]]){
                UITableViewCell *cell = sender;
                NSString *key = cell.textLabel.text;
                //vc.bookmark = [BookmarkHandle FetchBookmark:key];
                vc.name = key;
                //vc.urlString = [self.contentsDic objectForKey:key];
                //vc.title = [self.contentsDic objectForKey:key];
            
            }
        }
    }
    
}


@end
