//
//  BlurView.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "BlurView.h"

@implementation BlurView

//-(instancetype)init {
//    if(self = [super init]){
//        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
//        [self addSubview:blurView];
//    }
//    
//    
//    
//    return self;
//}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent]];
//        blurView.frame = self.frame;
//        [self addSubview:blurView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    layer.colors=@[(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.frame = self.bounds;
    [self.layer addSublayer:layer];
}

@end
