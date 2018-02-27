//
//  MemoryCollectionViewController.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2018/2/25.
//  Copyright © 2018年 蔡钟鸣. All rights reserved.
//

#import "MemoryCollectionViewController.h"
#import "CJLWaterfallLayout.h"
#import "UIColor+CJLColor.h"
#import "CJLTipModel.h"
#import "DBAccess.h"
#import "WebViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MemoryCollectionViewController ()
@property (nonatomic, assign, readonly) NSInteger numOfCells;
@property (nonatomic, strong) NSArray<CJLTipModel *> *tipsArray;
//@property (weak, nonatomic) IBOutlet UILabel *cellName;
@end

@implementation MemoryCollectionViewController

static NSString * const reuseIdentifier = @"MemoryCell";
static NSString * const footerId = @"footer";

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];

    // Do any additional setup after loading the view.
    
    
    self.collectionView.backgroundColor = [UIColor orangeColor];
    self.collectionView.alwaysBounceVertical = YES;
    self.title = @"我的回忆";
    [self pSetupMemoryItem];
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    
    
}

-(void)pSetupMemoryItem{
    self.tipsArray = [DBAccess getRandomTips:[NSString stringWithFormat:@"%ld", self.numOfCells]];
    self.collectionView.collectionViewLayout = [[CJLWaterfallLayout alloc] initWithCellHeightArray:[self pGetCellsHeightArrayFromTipsArray:self.tipsArray]];
    
}

-(NSArray<NSNumber *> *)pGetCellsHeightArrayFromTipsArray:(NSArray<CJLTipModel *> *)tipsArray
{
    NSMutableArray<NSNumber *> *cellsHeightArray = [[NSMutableArray alloc] init];
    for (CJLTipModel *tip in tipsArray) {
        NSInteger lines = [tip.name lengthOfBytesUsingEncoding:NSUTF8StringEncoding] * 0.05;
        [cellsHeightArray addObject:[NSNumber numberWithInteger:lines * 50 + 10]];
    }
    return cellsHeightArray;
}

-(NSInteger)numOfCells
{
    return 5;
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
    if([segue.identifier isEqualToString:@"ShowKnowledgePageFromMemory"]){
        if([segue.destinationViewController isKindOfClass:[WebViewController class]]){
            WebViewController *vc = segue.destinationViewController;
            if([sender isKindOfClass:[UICollectionViewCell class]]){
                NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
                vc.tipModel = self.tipsArray[indexPath.row];
            }
        }
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.numOfCells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cjl_randomColor];
    cell.layer.cornerRadius = 9;
    for(UIView *view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    UILabel *cellName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, cell.frame.size.width - 20, cell.frame.size.height)];
    cellName.font = [UIFont systemFontOfSize:20 weight:UIFontWeightThin];
    cellName.numberOfLines = 0;
    cellName.text = self.tipsArray[indexPath.row].name;
    [cell.contentView addSubview:cellName];
    // Configure the cell
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowKnowledgePageFromMemory" sender:[self.collectionView cellForItemAtIndexPath:indexPath]];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - ShakeToEdit 摇动手机之后的回调方法

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"检测到摇动开始");
    }
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动取消
    NSLog(@"摇动取消");
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //摇动结束
    if (event.subtype == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"摇动结束");
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动效果 需要#import <AudioToolbox/AudioToolbox.h>
        [self pSetupMemoryItem];
        [self.collectionView reloadData];
    }
    
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    if(indexPath.section != 0){
//        return nil;
//    }
//    
//    if([kind isEqualToString:UICollectionElementKindSectionFooter])
//    {
//        UICollectionReusableView *footerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
//        if(footerView == nil)
//        {
//            footerView = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        }
//        footerView.backgroundColor = [UIColor lightGrayColor];
//        
//        return footerView;
//    }
//    
//    return nil;
//    
//    
//}




@end
