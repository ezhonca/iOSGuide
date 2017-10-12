//
//  SearchResultTableViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "WebViewController.h"
#import "CONSTFile.h"

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
    return self.dateDic.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSString *cellText = [[self.dateDic allKeys] objectAtIndex:indexPath.row];
    //cell.textLabel.text = [[self.dateDic allKeys] objectAtIndex:indexPath.row];
    //cell.textLabel.minimumScaleFactor = 0.5;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cellText];
    NSRange range = [[attributedString string] rangeOfString:self.searchString];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    
    //[attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:] range:range];
    cell.textLabel.attributedText = attributedString;
    cell.imageView.image = [UIImage imageNamed:@"search"];
//    UIImageView *line = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"cell-content-line"]];
//    line.height_Adjustable= 0.5;
//    line.alpha = 0.7;
//    line.x_Adjustable = HOTSEARCH_MARGIN;
//    line.y_Adjustable = CGRectGetMaxY(cell.textLabel.frame) + HOTSEARCH_MARGIN;
//    line.width_Adjustable = self.view.frame.size.width;
//    [cell.contentView addSubview:line];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"搜索结果";
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    self.tableViewDidScrollBlock();
//
//
//}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.tableViewDidScrollBlock();
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.tableViewDidSelectedBlock([self.dateDic valueForKey:[[self.dateDic allKeys] objectAtIndex:indexPath.row]]);
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

-(instancetype)init{
    if(self = [super init]){
        self.dateDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
//{
//    NSString *searchString = [self.searchBar text];
//    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
//    
//    if (self.searchResultDic!= nil) {
//        [self.searchResultDic removeAllObjects];
//    }
//    
//    NSMutableArray *searchResultArray = [NSMutableArray arrayWithArray:[[self.dateDic allKeys] filteredArrayUsingPredicate:preicate]];
//    //过滤数据
//    for(NSString *key in searchResultArray){
//        [self.searchResultDic setValue:self.dateDic[key] forKey:key];
//    }
//    SearchResultTableViewController *resultVC = (SearchResultTableViewController *)self.searchResultsController;
//    resultVC.dateDic = self.searchResultDic;
//    //刷新表格
//    [resultVC.tableView reloadData];
//}
//- (void)setDateDicWithRootDic:(NSDictionary *)rootDic
//{
//    for(id key in rootDic){
//        if([rootDic[key] isKindOfClass:[NSDictionary class]]){
//            [self setDateDicWithRootDic:rootDic[key]];
//        }else{
//            [self.dateDic setValue:rootDic[key] forKey:key];
//        }
//    }
//}
@end
