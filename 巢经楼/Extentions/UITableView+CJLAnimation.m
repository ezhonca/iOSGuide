//
//  UITableView+CJLAnimation.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/7.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "UITableView+CJLAnimation.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@implementation UITableView (CJLAnimation)

-(void)startAnimationWithType:(CJLTableViewAnimationType)type
{
    switch (type) {
        case CJLTableViewAnimationTypeSectionHeaderTranslationXSpring:
            [self sectionHeaderTranslationXSpring];
            break;
        case CJLTableViewAnimationTypecellShrinkToTop:
            [self cellShrinkToTop];
            break;
        case CJLTableViewAnimationAlpha:
            [self alphaAnimation];
            break;

    }
}

-(void)sectionHeaderTranslationXSpring
{
    CGFloat totalTime = 0.6;
    for(int i = 0; i < self.numberOfSections; i++){
        //[self reloadSections:[[NSIndexSet alloc] initWithIndex:i] withRowAnimation:UITableViewRowAnimationAutomatic];
        UITableViewHeaderFooterView *head = [self headerViewForSection:i];
        head.transform = CGAffineTransformMakeTranslation(-500, 0);
        [UIView animateWithDuration:totalTime delay:i*(totalTime/self.numberOfSections) usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
            head.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)cellShrinkToTop
{
    CGFloat totalTime = 0.6;
    NSArray<UITableViewCell *> *cellsArray = self.visibleCells;
    [cellsArray enumerateObjectsUsingBlock:^(UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint startPoint = [cell convertPoint:cell.bounds.origin toView:self];
        cell.transform = CGAffineTransformMakeTranslation(0, startPoint.y);
        [UIView animateWithDuration:totalTime animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    
}

- (void)alphaAnimation {
    
    NSArray<UITableViewCell *> *cellsArray = self.visibleCells;
    for (int i = 0; i < cellsArray.count; i++) {
        UITableViewCell *cell = [self.visibleCells objectAtIndex:i];
        cell.alpha = 0.0;
        [UIView animateWithDuration:0.3 delay:i*0.05 options:0 animations:^{
            cell.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
