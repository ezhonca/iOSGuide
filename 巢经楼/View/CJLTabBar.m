//
//  CJLTabBar.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/11/24.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "CJLTabBar.h"
#import "UIView+FrameExtension.h"
#import "CJLPopMenuView.h"

@interface CJLTabBar()<CJLPopMenuViewDelegate>

@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) CJLPopMenuView *popMenu;


@end

@implementation CJLTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - CJLPopMenuViewDelegate

-(CGPoint)centerForCenterButton
{
    return self.centerButton.center;

}

-(void)popMenuDisappearCompletionHandle
{
    self.centerButton.transform = CGAffineTransformIdentity;
}



-(CJLPopMenuView *)popMenu
{
    if(!_popMenu){
        
        _popMenu = [[CJLPopMenuView alloc] init];
        _popMenu.centerForCenterPopItem = [self convertPoint:self.centerButton.center toView:self.superview];
        _popMenu.popItemDelegate = self;
        __weak CJLTabBar *weakSelf = self;
        //_popMenu.alpha = 0;
        _popMenu.disappearBlock = ^{
            weakSelf.centerButton.transform = CGAffineTransformIdentity;
            //[waekself.centerButton removeFromSuperview];
        };
        [_popMenu setupAllPopItems];
//        _popMenu.centerForCenterPopItemBlock = ^CGPoint{
//            return weakSelf.centerButton.center;
//        };
    }
    return _popMenu;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btn sizeToFit];
    
    //btn.bounds = CGRectMake(0, 0, 64, 64);
    self.centerButton = btn;
    //取消点击效果
    [self.centerButton addTarget:self action:@selector(buttonClickTest:) forControlEvents:UIControlEventTouchUpInside];
    self.centerButton.adjustsImageWhenHighlighted = NO;
    [self addSubview:self.centerButton];
    //self.popMenu.popItemDelegate = self;
   
    //  设置tabbar
    
    //[tabBarController.tabBar setBackgroundImage:i];
    self.barStyle = UIBarStyleBlack;
    //[self setBackgroundImage:[[UIImage alloc] init]];
    //[self setShadowImage:[[UIImage alloc] init]];
}
-(void)buttonClickTest:(id)sender
{
    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击了中间按钮" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//
//    [alert show];
    UIWindow *mainWin = [UIApplication sharedApplication].keyWindow;
    
    self.popMenu.alpha = 1;
    [mainWin addSubview:self.popMenu];
    
    [UIView animateWithDuration:0.1
            animations:^{
                
                self.centerButton.transform = CGAffineTransformMakeRotation(M_PI_2);
                [self.popMenu appear];
               
                         }
                     completion:^(BOOL finished) {
                       //self.centerButton.transform = CGAffineTransformIdentity;
                         
                     }];
   
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.centerButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.3);
    //self.centerButton.size_Adjustable = self.centerButton.currentImage.size;
    //self.centerButton.size_Adjustable = CGSizeMake(50, 50);
    
    int tabBarButtonWidth = self.bounds.size.width / (self.items.count + 1);
    int index = 0;
    for(UIView *subView in self.subviews){
      
        
        if([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            subView.frame = CGRectMake(index * tabBarButtonWidth, self.bounds.origin.y, tabBarButtonWidth, self.bounds.size.height - 5);
            index ++;
            if(index == self.items.count / 2){
                index ++;
            }
        }
        
    }
    [self bringSubviewToFront:self.centerButton];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if(!self.hidden){
        CGPoint newPoint = [self convertPoint:point toView:self.centerButton];
        if([self.centerButton pointInside:newPoint withEvent:event]){
            return self.centerButton;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
    
}

@end
