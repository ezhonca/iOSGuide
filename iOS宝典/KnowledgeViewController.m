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

@interface KnowledgeViewController ()

@end

@implementation KnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.grid.dataSource = self;
    self.grid.delegate = self;
    self.title = @"iOS宝典";
    NSString *rootPath = [[NSBundle mainBundle] pathForResource:@"pathData" ofType:@"plist"];
    self.rootDic = [[NSDictionary alloc] initWithContentsOfFile:rootPath];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:[[SearchResultTableViewController alloc] init]];
    self.searchBar = self.searchController.searchBar;
  
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




@end
