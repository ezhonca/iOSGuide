//
//  UITableView+CJLAnimation.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/7.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CJLTableViewAnimationType) {
    CJLTableViewAnimationTypeSectionHeaderTranslationXSpring,
    CJLTableViewAnimationTypecellShrinkToTop,
    CJLTableViewAnimationAlpha,
};

@interface UITableView (CJLAnimation)
-(void)startAnimationWithType:(CJLTableViewAnimationType)type;

@end
