//
//  SearchSuggestionViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "SearchSuggestionViewController.h"

@interface SearchSuggestionViewController ()

@end

@implementation SearchSuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    cell.textLabel.text = @"111";
    return cell;
    
    
    
}

- (instancetype) initWithSearchResultsController:(UIViewController *)searchResultsController {
    if(self = [super initWithSearchResultsController:searchResultsController]){
        SearchSuggestionTableView *table = [[SearchSuggestionTableView alloc] initWithFrame:CGRectMake(0, 100, 375, 500)];
        
        table.delegate = self;
        table.dataSource = self;
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
        [self.view addSubview:table];
        
    }
    
    
    
    return self;
}
@end
