//
//  KnowledgeViewController.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "CustomCollectionViewCell.h"
#import "KnowledgeDetailTableViewController.h"
#import "SearchResultTableViewController.h"
#import "WebViewController.h"
#import "CONSTFile.h"
#import "CJLWaterfallLayout.h"
#import "DBAccess.h"
#import "DBAccess.h"
#import "CJLTipModel.h"

@interface KnowledgeViewController ()
@property (strong, nonatomic) NSMutableArray *subjectArray;
@property (strong, nonatomic) SearchResultTableViewController *resultVC;
@property (nonatomic, strong) NSMutableDictionary *dateDic;
@property (nonatomic, strong) NSMutableDictionary *searchResultDic;
@property (nonatomic, strong) NSMutableDictionary<NSString *, UIColor *> *subjectColorDic;
@property (nonatomic, strong) NSArray *allSubjectsFromDB;
@property (nonatomic, strong) NSArray<NSString *> *allTipsNameArray;
@end

@implementation KnowledgeViewController


-(NSArray *)allSubjectsFromDB
{
    return [DBAccess getAllSubjects];
}

-(NSMutableDictionary<NSString *, UIColor *> *)subjectColorDic{
    if(!_subjectColorDic){
        _subjectColorDic = [[NSMutableDictionary<NSString *, UIColor *> alloc] init];
        [self.subjectArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIColor *color = [UIColor colorWithRed:(CGFloat)FAVORITECOLORS[idx][0]/255.0f green:(CGFloat)FAVORITECOLORS[idx][1]/255.0f blue:(CGFloat)FAVORITECOLORS[idx][2]/255.0f alpha:1];
            [_subjectColorDic setObject:color forKey:obj];
           
            
        }];
       
    }
    return _subjectColorDic;
}

-(NSMutableArray *)subjectArray
{
    if(!_subjectArray){
        //_subjectArray = [[NSMutableArray alloc] init];
        _subjectArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:SUBJECTSPATH]];
        if(!_subjectArray.count){
            //_subjectArray = [NSMutableArray arrayWithArray:[self.rootDic allKeys]];
            _subjectArray = [NSMutableArray arrayWithArray:self.allSubjectsFromDB];
            [NSKeyedArchiver archiveRootObject:_subjectArray toFile:SUBJECTSPATH];
        }
    }
    
    
    return _subjectArray;
}

-(NSMutableDictionary *)searchResultDic
{
    if(!_searchResultDic){
        _searchResultDic = [[NSMutableDictionary alloc] init];
    }
    return _searchResultDic;
}

-(NSMutableDictionary *)dateDic
{
    if(!_dateDic){
        _dateDic = [[NSMutableDictionary alloc] init];
    }
    return _dateDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    // Do any additional setup after loading the view.
    self.grid.dataSource = self;
    self.grid.delegate = self;
    //self.grid.collectionViewLayout = [[CJLWaterfallLayout alloc] init];
    //self.grid.backgroundColor = [UIColor grayColor];
    [self setupMovementGesture];
    self.title = @"知识";
    NSString *rootPath = [[NSBundle mainBundle] pathForResource:@"pathData" ofType:@"plist"];
    self.rootDic = [[NSDictionary alloc] initWithContentsOfFile:rootPath];
    //self.dateDic = [[NSMutableDictionary alloc] init];
    //[self setDateDicWithRootDic:self.rootDic];
    self.allTipsNameArray = [DBAccess getAllTipsName];
    self.resultVC = [[SearchResultTableViewController alloc] init];
//    [self.resultVC setDateDicWithRootDic:self.rootDic];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.searchController];
//    [nav setNavigationBarHidden:YES animated:NO];
    self.searchController = [[SearchSuggestionViewController alloc] initWithSearchResultsController:self.resultVC];
    //self.searchController = [[SearchSuggestionViewController alloc] initWithSearchResultsController:nav];
    //[self.searchController setDateDicWithRootDic:self.rootDic];
    __weak KnowledgeViewController *weakSelf = self;
    self.resultVC.tableViewDidScrollBlock = ^{
        //if(weakSelf.searchController.searbarDidSelected)
          [weakSelf.searchController.searchBar resignFirstResponder];
    };
    self.resultVC.tableViewDidSelectedBlock = ^(NSString *name){
        if(![weakSelf.searchController.historyArray containsObject:weakSelf.searchController.searchBar.text]){
            [weakSelf.searchController.historyArray insertObject:weakSelf.searchController.searchBar.text atIndex:0];
            if(weakSelf.searchController.historyArray.count > SEARCHHISTORY_COUNT){
                [weakSelf.searchController.historyArray removeLastObject];
            }
            [NSKeyedArchiver archiveRootObject:weakSelf.searchController.historyArray toFile:SEARCHHISTORY_CACHEPATH];
            [weakSelf.searchController.tableView reloadData];
            
        }
        CJLTipModel *tipModel = [DBAccess getTipModelWithTipName:name];
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.tipModel = tipModel;
        //webVC.bookmark = [BookmarkHandle FetchBookmark:name];
//        webVC.name = name;
//        webVC.urlString = urlString;
        //[weakSelf.navigationController presentViewController:webVC animated:YES completion:nil];
        [weakSelf.navigationController pushViewController:webVC animated:YES];
        //[weakSelf.navigationController showViewController:webVC sender:nil];
    };
    
    //[self.searchBarView addSubview:self.searchController.searchBar];
    
    //SearchSuggestionViewController *s = (SearchSuggestionViewController *)nav.topViewController;
    [self.searchBarView addSubview:self.searchController.searchBar];
    self.searchController.searchResultsUpdater = self;
   
  
}

- (void)setDateDicWithRootDic:(NSDictionary *)rootDic
{
    for(id key in rootDic){
        if([rootDic[key] isKindOfClass:[NSDictionary class]]){
            [self setDateDicWithRootDic:rootDic[key]];
        }else{
            [self.dateDic setValue:rootDic[key] forKey:key];
        }
    }
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
//                NSIndexPath *indexPath = [self.grid indexPathForCell:cell];
//                NSString *key = [self.subjectArray objectAtIndex:indexPath.row];
                NSString *cellName = cell.bookName.text;
                knowledgeDetailVC.title = cellName;
                knowledgeDetailVC.knowledgeDetailDic = [self.rootDic objectForKey:@"Objective-C"];
                knowledgeDetailVC.firstCatalogArray = [DBAccess getFirstCatalogsWithSubjectName:cellName];
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
    cell.bookName.text = [self.subjectArray objectAtIndex:indexPath.row];
    //[cell.bookName sizeToFit];
    cell.bookName.textAlignment = NSTextAlignmentCenter;
    //cell.bookName.center = cell.center;
    cell.layer.cornerRadius = 9;
    cell.backgroundColor = [self.subjectColorDic valueForKey:cell.bookName.text];
    //[cell.bookName sizeToFit];
    //cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book"]];
    return cell;
}

#pragma mark - drag collectionViewcCell
//设置手势
-(void)setupMovementGesture
{
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.grid addGestureRecognizer:longPressGesture];
}
//手势action
-(void)longPress:(UIGestureRecognizer *)gesture
{
    //通过手势的location获取indexpath
    NSIndexPath *cellIndexPath = [self.grid indexPathForItemAtPoint:[gesture locationInView:self.grid]];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            [self.grid beginInteractiveMovementForItemAtIndexPath:cellIndexPath];
//            CGRect CellBounds = [self.grid cellForItemAtIndexPath:cellIndexPath].bounds;
//            CellBounds.size.width = [self.grid cellForItemAtIndexPath:cellIndexPath].bounds.size.width + 10;
//            CellBounds.size.height = [self.grid cellForItemAtIndexPath:cellIndexPath].bounds.size.height + 10;
//            [self.grid cellForItemAtIndexPath:cellIndexPath].bounds = CellBounds;
            break;
        case UIGestureRecognizerStateChanged:
            [self.grid updateInteractiveMovementTargetPosition:[gesture locationInView:self.grid]];
            break;
        case UIGestureRecognizerStateEnded:
            [self.grid endInteractiveMovement];
            //NSIndexPath *cellIndexPath = [self.grid indexPathForItemAtPoint:[gesture locationInView:self.grid]];
//            CellBounds.size.width = [self.grid cellForItemAtIndexPath:cellIndexPath].bounds.size.width - 10;
//            CellBounds.size.height = [self.grid cellForItemAtIndexPath:cellIndexPath].bounds.size.height - 10;
//            [self.grid cellForItemAtIndexPath:cellIndexPath].bounds = CellBounds;
            break;
        default:
            [self.grid cancelInteractiveMovement];
            break;
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //替换subjectArray内的数据
    NSString *temp = [self.subjectArray objectAtIndex:sourceIndexPath.row];
    [self.subjectArray removeObjectAtIndex:sourceIndexPath.row];
    [self.subjectArray insertObject:temp atIndex:destinationIndexPath.row];
    [NSKeyedArchiver archiveRootObject:self.subjectArray toFile:SUBJECTSPATH];
}




#pragma mark - UISearchResultsUpdatingDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //if([searchController isKindOfClass:[SearchSuggestionViewController class]]){
       // SearchSuggestionViewController *customSearchVC = (SearchSuggestionViewController *)searchController;
        if(self.searchController.searchBar.text.length){
            self.searchController.tableView.hidden = YES;
            NSString *searchString = [self.searchController.searchBar text];
            NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
            
//            if (self.searchResultDic!= nil) {
//                [self.searchResultDic removeAllObjects];
//            }
            
            //NSMutableArray *searchResultArray = [NSMutableArray arrayWithArray:[[self.dateDic allKeys] filteredArrayUsingPredicate:preicate]];
            NSMutableArray *searchResultArray = [NSMutableArray arrayWithArray:[self.allTipsNameArray filteredArrayUsingPredicate:preicate]];
            self.resultVC.resultTipsArray = searchResultArray;
            //过滤数据
//            for(NSString *key in searchResultArray){
//                [self.searchResultDic setValue:self.dateDic[key] forKey:key];
//            }
            //SearchResultTableViewController *resultVC = (SearchResultTableViewController *)self.searchResultsController;
            //self.resultVC.dateDic = self.searchResultDic;
            self.resultVC.searchString = searchString;
            //刷新表格
            [self.resultVC.tableView reloadData];
        }else{
            self.searchController.tableView.hidden = NO;
        }
    
   // }
}

@end
