//
//  CJLPopMenuView.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/11/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "CJLPopMenuView.h"
@interface CJLPopMenuView()
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *centerPopItem;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *popItemArray;
@end

int const popItemNum = 3;

@implementation CJLPopMenuView



-(NSMutableArray<UIImageView *> *)popItemArray
{
    if(!_popItemArray){
        _popItemArray = [[NSMutableArray alloc] init];
        for(int i = 0; i < popItemNum; i++){
            NSString *itemName = [NSString stringWithFormat:@"popItem_%d", i];
            UIImageView *popItem = [[UIImageView alloc] initWithImage:[UIImage imageNamed:itemName]];
           
            [_popItemArray addObject:popItem];
        }
    }
    
    return _popItemArray;
}

-(UIImageView *)centerPopItem
{
    if(!_centerPopItem){
        _centerPopItem = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"centerPopItem"]];
       
    }
    
    return _centerPopItem;
}

-(void) setupCenterPopItem
{
    self.centerPopItem.contentMode = UIViewContentModeScaleAspectFit;
    self.centerPopItem.center = self.centerForCenterPopItem;
    [self addSubview:self.centerPopItem];
}
-(void)setupPopItems
{
    [self.popItemArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.center = self.centerForCenterPopItem;
        obj.contentMode = UIViewContentModeScaleAspectFit;
        obj.alpha = 0;
        [self addSubview:obj];
        
    }];
}

-(void)setupAllPopItems
{
    [self setupCenterPopItem];
    [self setupPopItems];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    UIWindow *mainWin = [UIApplication sharedApplication].keyWindow;
    return [self initWithFrame:mainWin.frame];
 
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        //self.backgroundColor = [UIColor redColor];
        
        //self.frame = frame;
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        blurView.frame = self.frame;
        [self addSubview:blurView];
        UIView *maskView = [[UIView alloc] initWithFrame:blurView.frame];
        maskView.backgroundColor = [[UIColor orangeColor]colorWithAlphaComponent:0.6];
        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [blurView.contentView addSubview:maskView];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        lab.text = @"111";
        [self addSubview:lab];
        //self.opaque = YES;
        //添加点击手势关闭view
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGesture];
        
        _image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my"]];
        _image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book"]];
        _image1.contentMode = UIViewContentModeScaleAspectFit;
        _image2.contentMode = UIViewContentModeScaleAspectFit;
        _image1.center = self.center;
        _image2.center = self.center;
        //[self addSubview:_image1];
        //[self addSubview:_image2];
        
        //[self setupCenterPopItem];
        
        
    }
    
    return self;
}

-(void)tap:(UIGestureRecognizer *)gesture
{
    [self disappear];
}

-(void)disappear
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        _image2.transform = CGAffineTransformIdentity;
        _image1.transform = CGAffineTransformIdentity;
        _centerPopItem.transform = CGAffineTransformIdentity;
        [self.popItemArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.transform = CGAffineTransformIdentity;
            obj.alpha = 0;
        }];
        [UIView animateWithDuration:0.2 animations:^{
            _disappearBlock();
            [self.popItemDelegate popMenuDisappearCompletionHandle];
        } completion:^(BOOL finished) {


        }];
    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.1 animations:^{
//            _disappearBlock();
//            [self.popItemDelegate popMenuDisappearCompletionHandle];
//        } completion:^(BOOL finished) {
//            [self removeFromSuperview];
//            self.transform = CGAffineTransformIdentity;
//
//        }];
        [self removeFromSuperview];
       self.transform = CGAffineTransformIdentity;
        
    }];
    
  
}

-(void)appear
{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = 0.15;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:0.8f];
    [self.layer addAnimation:animation forKey:@"fadeIn"];
    
    [UIView animateWithDuration:0.35 animations:^{
        //self.alpha = 0;
        _centerPopItem.transform = CGAffineTransformMakeRotation(M_PI_2);
        //_image2.transform = CGAffineTransformMakeRotation(M_PI_2);
        [self.popItemArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.transform = CGAffineTransformConcat(CGAffineTransformMakeTranslation(cosf(M_PI/(popItemNum+1)*(idx+1)) * 100, -sinf(M_PI/(popItemNum+1)*(idx+1)) * 100), CGAffineTransformMakeScale(1.5, 1.5));
            obj.alpha = 1;
        }];
        //_image1.transform = CGAffineTransformMakeTranslation(100, 100);
    } completion:^(BOOL finished) {
        //completionHandle();
    }];
}

@end
