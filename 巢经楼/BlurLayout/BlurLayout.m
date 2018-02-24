//
//  BlurLayout.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "BlurLayout.h"
#import "BlurView.h"

@implementation BlurLayout



-(void)prepareLayout {
    [super prepareLayout];
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self registerClass:[BlurView class] forDecorationViewOfKind:@"Blur"];
}

-(CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    
    
    UICollectionViewLayoutAttributes* attributes =     [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    //attributes.size = CGSizeMake(215/3.0, 303/3.0);
    
    //attributes.center=CGPointMake(80*(path.item+1), 62.5+125*path.section);
    return attributes;
}
//Decoration View的布局。
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes* att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    att.frame=CGRectMake(0, (125*indexPath.section)/2.0, 375, 125);
    att.zIndex=-1;
    
    return att;
    
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray* attributes = [NSMutableArray array];
    //把Decoration View的布局加入可见区域布局。
    for (int y=0; y<8; y++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:3 inSection:y];
        [attributes addObject:[self layoutAttributesForDecorationViewOfKind:@"Blur"atIndexPath:indexPath]];
    }
    
    for (NSInteger i=0 ; i < 8; i++) {
        for (NSInteger t=0; t<3; t++) {
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:t inSection:i];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
        
    }
    
    return attributes;
}
    
@end
