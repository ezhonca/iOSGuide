//
//  KnowledgeDetailTableViewController.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/21.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "KnowledgeDetailTableViewController.h"
#import "ExpandableTableViewHeader.h"
#import "ContentsTableViewController.h"
#import "DBAccess.h"

@interface KnowledgeDetailTableViewController ()
@property (nonatomic, strong) NSMutableArray<NSString *> *expandStateArray;
@end

@implementation KnowledgeDetailTableViewController

-(NSMutableArray *)ExpandableModelArray
{
    if(!_expandStateArray){
        _expandStateArray = [[NSMutableArray<NSString *> alloc] init];
    }
    return _expandStateArray;
}

-(void)loadSecondCatalogsArray
{
    NSMutableArray *secondCatalogsArray = [[NSMutableArray<NSArray *> alloc] init];
    for(NSString *firstCatalog in self.firstCatalogArray){
        NSArray *secondCatalogs = [DBAccess getSecondCatalogsWithFirstCatalogName:firstCatalog];
        [secondCatalogsArray addObject:secondCatalogs];
        [self.ExpandableModelArray addObject:@"0"];
        
    }
    self.secondCatalogsArray = secondCatalogsArray;
}

- (void)loadDate:(NSDictionary *)dic {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for(NSString *key in dic){
        ExpandableTableViewHeaderModel *model = [[ExpandableTableViewHeaderModel alloc] initWithDictionary:dic[key] andSectionName:key];
        [mutableArray addObject:model];
    }
    self.ExpandableModelArray = mutableArray;
}

- (void)changeExpandStateInSection:(NSInteger)section {
//    ExpandableTableViewHeaderModel *model = self.ExpandableModelArray[section];
//    model.isExpanded = !model.isExpanded;
//
//    [self.ExpandableModelArray replaceObjectAtIndex:section withObject:model];
    BOOL tmp = ![self.expandStateArray[section] boolValue];
    [self.expandStateArray replaceObjectAtIndex:section withObject:[NSString stringWithFormat:@"%d", tmp]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadSecondCatalogsArray];
    [self loadDate:self.knowledgeDetailDic];
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
    return self.firstCatalogArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    ExpandableTableViewHeaderModel *model = self.ExpandableModelArray[section];
//    if(model.canExpand && model.isExpanded){
//        return model.cellsDic.count;
//    }else{
//        return 0;
//    }
    if([self.expandStateArray[section] boolValue]){
        return self.secondCatalogsArray[section].count;
    }else{
        return 0;
    }


}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"knowledgeDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    //ExpandableTableViewHeaderModel *model = self.ExpandableModelArray[indexPath.section];
    
    //cell.textLabel.text = [@"  " stringByAppendingString:[[model.cellsDic allKeys] objectAtIndex:indexPath.row]];
    cell.textLabel.text = self.secondCatalogsArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.firstCatalogArray[section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *HeaderIdentifier = @"header";
    ExpandableTableViewHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(!header){
        header = [[ExpandableTableViewHeader alloc] initWithReuseIdentifier:HeaderIdentifier];
        
    }
    
    //ExpandableTableViewHeaderModel *model = self.ExpandableModelArray[section];
    //header.headerModel = model;
//    [UIView animateWithDuration:0.5 animations:^{
////        if(!model.isExpanded){
////            header.accessoryView.transform = CGAffineTransformIdentity;
////        }else{
////            header.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
////        }
//        if(![self.expandStateArray[section] boolValue]){
//            header.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
//        }else{
//            header.accessoryView.transform = CGAffineTransformIdentity;
//            //header.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
//        }
//
//
//
//    }];
            if([self.expandStateArray[section] boolValue]){
                    header.accessoryView.transform = CGAffineTransformIdentity;
                    //weakHeader.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            }else{
             
                    //weakHeader.accessoryView.transform = CGAffineTransformIdentity;
                    header.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
            }
    //header.textLabel.text = [self.knowledgeDetailDic.allKeys objectAtIndex:section];
    header.textLabel.text = self.firstCatalogArray[section];
    
//    header.headerClickBackBlock = ^{
//        if(model.canExpand){
//        [self changeExpandStateInSection:section];
//        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
//            [tableView reloadSections:indexSet  withRowAnimation:UITableViewRowAnimationAutomatic];
//        }else{
//            [self performSegueWithIdentifier:@"ShowContents" sender:weakHeader];
//        }
    __weak ExpandableTableViewHeader *weakHeader = header;
    __weak KnowledgeDetailTableViewController *weakSelf = self;
    
    

    header.headerClickBackBlock = ^{
        [weakSelf changeExpandStateInSection:section];
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
        [UIView animateWithDuration:0.25
                animations: ^{
                            if(![weakSelf.expandStateArray[section] boolValue]){
                                weakHeader.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
                            }else{
                                weakHeader.accessoryView.transform = CGAffineTransformIdentity;
                                //header.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
                            }
                    //weakHeader.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
               }completion:^(BOOL finished) {
                     [tableView reloadSections:indexSet  withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
       
    };
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ShowContents" sender:cell];
    
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
  
    if([segue.identifier isEqualToString:@"ShowContents"]){
        if([segue.destinationViewController isKindOfClass:[ContentsTableViewController class]]){
            ContentsTableViewController *vc = segue.destinationViewController;
//            if([sender isKindOfClass:[ExpandableTableViewHeader class]]){
//                ExpandableTableViewHeader *header = sender;
//                vc.title = header.textLabel.text;
//                vc.contentsDic = [self.knowledgeDetailDic objectForKey:header.textLabel.text];
//            }else if([sender isKindOfClass:[UITableViewCell class]]){
            if([sender isKindOfClass:[UITableViewCell class]]){
                UITableViewCell *cell = sender;
//                NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//                ExpandableTableViewHeaderModel *model = self.ExpandableModelArray[indexPath.section];
//                vc.title = [[model.cellsDic allKeys] objectAtIndex:indexPath.row];
//                vc.contentsDic = [model.cellsDic objectForKey:[[model.cellsDic allKeys] objectAtIndex:indexPath.row]];
                vc.title = cell.textLabel.text;
                //vc.contentsDic
            }
        }
    }
}


@end
