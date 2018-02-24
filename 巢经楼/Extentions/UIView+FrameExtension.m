//
//  UIView+FrameExtension.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/30.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "UIView+FrameExtension.h"

@implementation UIView (FrameExtension)

-(void)setX_Adjustable:(CGFloat)x_Adjustable {
    CGRect frame = self.frame;
    frame.origin.x = x_Adjustable;
    self.frame = frame;
}

-(CGFloat)x_Adjustable {
    return self.frame.origin.x;
}

-(void)setY_Adjustable:(CGFloat)y_Adjustable {
    CGRect frame = self.frame;
    frame.origin.y = y_Adjustable;
    self.frame = frame;
}

-(CGFloat)y_Adjustable {
    return self.frame.origin.y;
}

-(CGFloat)centerX_Adjustable {
    return self.center.x;
}

-(void)setCenterX_Adjustable:(CGFloat)centerX_Adjustable {
    CGPoint center = self.center;
    center.x = centerX_Adjustable;
    self.center = center;
}

-(CGFloat)centerY_Adjustable {
    return self.center.y;
}

-(void)setCenterY_Adjustable:(CGFloat)centerY_Adjustable {
    CGPoint center = self.center;
    center.y = centerY_Adjustable;
    self.center = center;
}

-(void)setHeight_Adjustable:(CGFloat)height_Adjustable {
    CGRect frame = self.frame;
    frame.size.height = height_Adjustable;
    self.frame = frame;
}

-(CGFloat)height_Adjustable {
    return self.frame.size.height;
}

-(void)setWidth_Adjustable:(CGFloat)width_Adjustable {
    CGRect frame = self.frame;
    frame.size.width = width_Adjustable;
    self.frame = frame;
}

-(CGFloat)width_Adjustable {
    return self.frame.size.width;
}

-(void)setOrigin_Adjustable:(CGPoint)origin_Adjustable {
    CGRect frame = self.frame;
    frame.origin = origin_Adjustable;
    self.frame = frame;
    
}

-(CGPoint)origin_Adjustable {
    return self.frame.origin;
}

-(CGSize)size_Adjustable {
    return self.frame.size;
}

-(void)setSize_Adjustable:(CGSize)size_Adjustable {
    CGRect frame = self.frame;
    frame.size = size_Adjustable;
    self.frame = frame;
}










@end
