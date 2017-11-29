//
//  CJLPopMenuView.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/11/29.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DisappearBlock)(void);
typedef CGPoint (^CenterForCenterPopItemBlock)(void);

@protocol CJLPopMenuViewDelegate <NSObject>
-(CGPoint)centerForCenterButton;
-(void)popMenuDisappearCompletionHandle;

@end


@interface CJLPopMenuView : UIView
-(void)appear;
@property (nonatomic, weak) id<CJLPopMenuViewDelegate> popItemDelegate;
@property (nonatomic, strong) DisappearBlock disappearBlock;
@property (nonatomic, strong) CenterForCenterPopItemBlock centerForCenterPopItemBlock;
@property (nonatomic, assign) CGPoint centerForCenterPopItem;
-(void)setupAllPopItems;
@end
