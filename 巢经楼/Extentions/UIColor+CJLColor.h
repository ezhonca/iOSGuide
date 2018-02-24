//
//  UIColor+CJLColor.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/7.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CJLColor)
+(UIColor *)cjl_defaultBackgroundColor;
+(UIColor *)cjl_randomColor;
+(UIColor *)cjl_colorInPool:(NSInteger)index;
@end
