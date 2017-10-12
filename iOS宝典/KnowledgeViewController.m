//
//  KnowledgeViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "CustomCollectionViewCell.h"
#import "KnowledgeDetailTableViewController.h"
#import "SearchResultTableViewController.h"
#import "WebViewController.h"

@interface KnowledgeViewController ()
@property(strong, nonatomic) SearchResultTableViewController *resultVC;
@end

@implementation KnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    // Do any additional setup after loading the view.
    self.grid.dataSource = self;
    self.grid.delegate = self;
    self.title = @"iOS宝典";
    NSString *rootPath = [[NSBundle mainBundle] pathForResource:@"pathData" ofType:@"plist"];
    self.rootDic = [[NSDictionary alloc] initWithContentsOfFile:rootPath];
    self.resultVC = [[SearchResultTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.searchController];
    [nav setNavigationBarHidden:YES animated:NO];
    self.searchController = [[SearchSuggestionViewController alloc] initWithSearchResultsController:self.resultVC];
    //self.searchController = [[SearchSuggestionViewController alloc] initWithSearchResultsController:nav];
    __weak KnowledgeViewController *weakSelf = self;
    self.resultVC.tableViewDidScrollBlock = ^{
        if(weakSelf.searchController.searbarDidSelected)
          [weakSelf.searchController.searchBar resignFirstResponder];
    };
    self.resultVC.tableViewDidSelectedBlock = ^{
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.urlString = @"https://www.apple.com";
        //[weakSelf.navigationController presentViewController:webVC animated:YES completion:nil];
        [weakSelf.navigationController pushViewController:webVC animated:YES];
        //[weakSelf.navigationController showViewController:webVC sender:nil];
    };
    //[self.searchBarView addSubview:self.searchController.searchBar];
    
    //SearchSuggestionViewController *s = (SearchSuggestionViewController *)nav.topViewController;
    [self.searchBarView addSubview:self.searchController.searchBar];
    self.searchController.searchResultsUpdater = self;
   
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
    
    if([segue.identifier isEqualToString:@"ShowKnowledgeDetail"]){
        if([segue.destinationViewController isKindOfClass:[KnowledgeDetailTableViewController class]]){
            KnowledgeDetailTableViewController *knowledgeDetailVC = segue.destinationViewController;
            
            if([sender isKindOfClass:[CustomCollectionViewCell class]]){
                CustomCollectionViewCell *cell = sender;
                NSIndexPath *indexPath = [self.grid indexPathForCell:cell];
                NSString *key = [self.rootDic.allKeys objectAtIndex:indexPath.row];
                knowledgeDetailVC.title = key;
                knowledgeDetailVC.knowledgeDetailDic = [self.rootDic objectForKey:key];
            }
            
        }
    }
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rootDic.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"bookCell";
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.bookName.text = [self.rootDic.allKeys objectAtIndex:indexPath.row];
    
    cell.bookName.textAlignment = NSTextAlignmentCenter;
    //[cell.bookName sizeToFit];
    //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book"]];
    return cell;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //if([searchController isKindOfClass:[SearchSuggestionViewController class]]){
       // SearchSuggestionViewController *customSearchVC = (SearchSuggestionViewController *)searchController;
        if(self.searchController.searchBar.text.length){
            self.searchController.tableView.hidden = YES;
        }else{
            self.searchController.tableView.hidden = NO;
        }
   // }
}

@end
