//
//  ExpandableTableViewHeader.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/26.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "ExpandableTableViewHeader.h"
#import "UIColor+CJLColor.h"

#define ScreemWidth [UIScreen mainScreen].bounds.size.width

@interface ExpandableTableViewHeader()

@property(nonatomic, strong) UIButton *backgroundButton;

@end

@implementation ExpandableTableViewHeader



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
      //  self.isExpanded = NO;
        //self.backgroundColor = [UIColor grayColor];
        [self setupItems];
       
    }
    
    
    return self;
}

- (void)setupItems{
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.frame];
    backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = backgroundView;
    
    [self.contentView addSubview:self.backgroundButton];
    
    UIImage *image = [UIImage imageNamed:@"brand_expand"];
    self.accessoryView = [[UIImageView alloc] initWithImage:image];
    self.accessoryView.frame = CGRectMake(ScreemWidth - 30, (80-8)/2, 15, 8);
    //self.accessoryView.image = [UIImage imageNamed:@"brand_expand"];
    [self.contentView addSubview:self.accessoryView];

}

- (void) backgroundButtonClicked{
    self.headerClickBackBlock();
}

-(UIButton *)backgroundButton
{
    if(!_backgroundButton){
        _backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, ScreemWidth-10, 70)];
        //backgroundButton.backgroundColor = [UIColor cjl_randomColor];
        [_backgroundButton addTarget:self action:@selector(backgroundButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _backgroundButton.layer.cornerRadius = 10;
    }
    return _backgroundButton;
}

-(void)setHeaderColor:(UIColor *)headerColor
{
    self.backgroundButton.backgroundColor = headerColor;
}

@end
