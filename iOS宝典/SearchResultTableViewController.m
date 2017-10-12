//
//  SearchResultTableViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "WebViewController.h"

@interface SearchResultTableViewController ()

@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    //[navigationController setNavigationBarHidden:YES animated:NO];
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        
    }
    cell.textLabel.text = @"111";
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.tableViewDidScrollBlock();
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableViewDidSelectedBlock();
//    WebViewController *webVC = [[WebViewController alloc] init];
//    webVC.urlString = @"https://www.apple.com";
//    [self.navigationController pushViewController:webVC animated:YES];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"SearchResultToWebView"]){
        if([segue.destinationViewController isKindOfClass:[WebViewController class]]){
            WebViewController *knowledgeDetailVC = segue.destinationViewController;
            knowledgeDetailVC.urlString = @"https://www.apple.com";
//            if([sender isKindOfClass:[CustomCollectionViewCell class]]){
//                CustomCollectionViewCell *cell = sender;
//                NSIndexPath *indexPath = [self.grid indexPathForCell:cell];
//                NSString *key = [self.rootDic.allKeys objectAtIndex:indexPath.row];
//                knowledgeDetailVC.title = key;
//                knowledgeDetailVC.knowledgeDetailDic = [self.rootDic objectForKey:key];
//            }
            
        }
    }
}


@end
