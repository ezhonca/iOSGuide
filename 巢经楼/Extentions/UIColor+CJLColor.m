//
//  UIColor+CJLColor.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/7.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "UIColor+CJLColor.h"
#import "CONSTFile.h"

@implementation UIColor (CJLColor)

+(UIColor *)cjl_defaultBackgroundColor
{
    return [UIColor colorWithRed:253/255.0f green:146/255.0f blue:38/255.0f alpha:1];
}

+(UIColor *)cjl_randomColor
{
    int index = arc4random() % 6;
      return [UIColor colorWithRed:(CGFloat)FAVORITECOLORS[index][0]/255.0f green:(CGFloat)FAVORITECOLORS[index][1]/255.0f blue:(CGFloat)FAVORITECOLORS[index][2]/255.0f alpha:1];
}

+(UIColor *)cjl_colorInPool:(NSInteger)section
{
    NSInteger index =  5 - section % 6;
    return [UIColor colorWithRed:(CGFloat)FAVORITECOLORS[index][0]/255.0f green:(CGFloat)FAVORITECOLORS[index][1]/255.0f blue:(CGFloat)FAVORITECOLORS[index][2]/255.0f alpha:1];
}

@end
