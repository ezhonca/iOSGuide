//
//  CJLWaterfallLayout.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/11/24.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "CJLWaterfallLayout.h"

static const NSInteger DEFAULTCOLUMNCOUNT = 2;
static const CGFloat DEFAULTCOLUMNMARGIN = 5;
static const CGFloat DEFAULTROWMARGIN = 5;
static const UIEdgeInsets DEFAULTEDGEINSETS = {5, 5, 5, 5};

@interface CJLWaterfallLayout()

@property (strong, nonatomic) NSMutableArray *attriArray;
@property (strong, nonatomic) NSMutableArray *columnHeights;
@property (assign, nonatomic) CGFloat contentHeight;

@end

@implementation CJLWaterfallLayout

-(NSMutableArray *)attriArray
{
    if(!_attriArray){
        _attriArray = [[NSMutableArray alloc] init];
    }
    return _attriArray;
}

-(NSMutableArray *)columnHeights
{
    if(!_columnHeights){
        _columnHeights = [[NSMutableArray alloc] init];
    }
    return _columnHeights;
}

-(void)prepareLayout
{
    [super prepareLayout];
    //self.headerReferenceSize = CGSizeMake(200, 200);
    //self.footerReferenceSize = CGSizeMake(200, 200);
    self.contentHeight = 0;
    //清空column高度数据并初始化
    [self.columnHeights removeAllObjects];
    for(NSInteger i = 0; i < DEFAULTCOLUMNCOUNT; i++){
        [self.columnHeights addObject:@(DEFAULTEDGEINSETS.top)];
    }
    //清空attris数据并初始化
    [self.attriArray removeAllObjects];
    NSInteger cellsNum = [self.collectionView numberOfItemsInSection:0];
    for(NSInteger i = 0; i < cellsNum; i++){
        [self.attriArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return self.attriArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化一个UICollectionViewLayoutAttributes
    UICollectionViewLayoutAttributes * attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //获取item的高度和宽度
    CGFloat itemWidth = (self.collectionView.frame.size.width - DEFAULTEDGEINSETS.left - DEFAULTEDGEINSETS.right - (DEFAULTCOLUMNCOUNT -1)*DEFAULTCOLUMNMARGIN) / DEFAULTCOLUMNCOUNT;
    //CGFloat itemHeight = arc4random()%100 + 100;
    CGFloat itemHeight = [self.cellHeightArray[indexPath.row] doubleValue];
    //找出高度最低的column
    __block NSInteger destColumn = 0;
    __block CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    [self.columnHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([self.columnHeights[idx] doubleValue] < minColumnHeight){
            destColumn = idx;
            minColumnHeight = [self.columnHeights[idx] doubleValue];
        }
    }];
    //设置item的frame
    CGFloat x = DEFAULTEDGEINSETS.left + destColumn*(itemWidth + DEFAULTCOLUMNMARGIN);
    CGFloat y = minColumnHeight;
    if(y != DEFAULTEDGEINSETS.top)
    {
        y += DEFAULTROWMARGIN;
    }
    attri.frame = CGRectMake(x, y, itemWidth, itemHeight);
    //更新加入新的item后的cloumn的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attri.frame));
    //与contentHeight对比，更新contentHeight数据
    if(self.contentHeight < [self.columnHeights[destColumn] doubleValue]){
        self.contentHeight = [self.columnHeights[destColumn] doubleValue];
    }
    
    return attri;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentHeight + DEFAULTEDGEINSETS.bottom);
}

-(instancetype)initWithCellHeightArray:(NSArray<NSNumber *> *)cellHeightArray
{
    if(self = [super init]){
        _cellHeightArray = cellHeightArray;
    }
    return self;
}

@end
