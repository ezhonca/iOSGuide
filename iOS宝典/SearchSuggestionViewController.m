//
//  SearchSuggestionViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "SearchSuggestionViewController.h"
#import "CONSTFile.h"

@interface SearchSuggestionViewController ()

@end

@implementation SearchSuggestionViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.searbarDidSelected = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    [self setupSearchbar];
//    self.historyArray = [[NSMutableArray alloc] initWithCapacity:SEARCHHISTORY_COUNT];
//    [self.historyArray addObject:@"aa"];
//    [self.historyArray addObject:@"bb"];
    if(!self.historyArray)
        self.historyArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:SEARCHHISTORY_CACHEPATH]];
    //[self.searchBar becomeFirstResponder];
     //[self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0.2];

 
}

- (void)showKeyboard {
    
    [self.searchBar becomeFirstResponder];
    
}

- (void)setupSearchbar
{
    self.searchBar.placeholder = @"搜索";
//    self.searchBar.showsCancelButton = YES;
//    UIButton *cancelButton = [self.searchBar valueForKey:@"cancelButton"];
//    if(cancelButton){
//        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    }
//    [self.searchBar becomeFirstResponder];
   
    //self.searchBar.showsCancelButton = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.active = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegate
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor clearColor];
        
        UIButton *closetButton = [[UIButton alloc] init];
        closetButton.size_Adjustable = CGSizeMake(cell.height_Adjustable, cell.height_Adjustable);
        [closetButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closetButton addTarget:self action:@selector(historyCloseButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = closetButton;
        cell.imageView.image = [UIImage imageNamed:@"search_history"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self.historyArray objectAtIndex:indexPath.row];
    //cell.selectedBackgroundView = nil;
    return cell;
    
    
    
}

-(void)historyCloseButtonDidClick:(UIButton *)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    [self.historyArray removeObject:cell.textLabel.text];
    [NSKeyedArchiver archiveRootObject:self.historyArray toFile:SEARCHHISTORY_CACHEPATH];
    [self.tableView reloadData];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.searbarDidSelected)
        [self.searchBar resignFirstResponder];
    self.searbarDidSelected = YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.searchBar.text = self.historyArray[indexPath.row];
    
    
}

#pragma mark - searchbar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if(![self.historyArray containsObject:searchBar.text]){
        [self.historyArray insertObject:searchBar.text atIndex:0];
        if(self.historyArray.count > SEARCHHISTORY_COUNT){
            [self.historyArray removeLastObject];
        }
        [NSKeyedArchiver archiveRootObject:self.historyArray toFile:SEARCHHISTORY_CACHEPATH];
        [self.tableView reloadData];
        
    }
    
    
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchBar.showsCancelButton = YES;
    UIButton *cancelButton = [self.searchBar valueForKey:@"cancelButton"];
    if(cancelButton){
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    [self.searchBar becomeFirstResponder];
}

#pragma mark - init View
- (instancetype) initWithSearchResultsController:(UIViewController *)searchResultsController {
    if(self = [super initWithSearchResultsController:searchResultsController]){
        self.tableView = [[SearchSuggestionTableView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.size.height + HOTSEARCH_MARGIN, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height)];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        __weak SearchSuggestionViewController *weakSelf = self;
        self.tableView.hotLabelDidClickBlock = ^(NSString *labelText){
            weakSelf.searchBar.text = labelText;
            [weakSelf.searchBar becomeFirstResponder];
        };
        __weak SearchSuggestionTableView *weakTable = self.tableView;
        self.tableView.clearButtonClickBlock = ^{
            [weakSelf.historyArray removeAllObjects];
            [NSKeyedArchiver archiveRootObject:weakSelf.historyArray toFile:SEARCHHISTORY_CACHEPATH];
            [weakTable reloadData];
            
        };
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.frame = CGRectMake(0, 0, 50, 50);
//        button.titleLabel.text = @"haha";
//        button.backgroundColor = [UIColor redColor];
//        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        v.backgroundColor = [UIColor yellowColor];
//        //table.tableHeaderView.frame = CGRectMake(0, 0, 300, 50);
//        table.tableHeaderView = v;
//        [table.tableHeaderView addSubview:button];
        //table.tableHeaderView.backgroundColor = [UIColor redColor];
        
//        self.tableView.tableHeaderView.hidden = NO;
//        self.tableView.tableHeaderView.backgroundColor = [UIColor redColor];
//        self.tableView.delegate = self;
//        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        
    }
    
    
    
    return self;
}




@end
