//
//  SearchSuggestionTableView.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/30.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "SearchSuggestionTableView.h"
#import "UIView+FrameExtension.h"

@implementation SearchSuggestionTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupView];
    }
    return self;
}

- (instancetype)init {
    if(self = [super init]){
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}


- (void)setupView {
    //UIView *tableHeadView = [[UIView alloc] init];
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 100)];
//    CGRect frame = tableHeadView.frame;
//    frame.size.width = [UIScreen mainScreen].bounds.size.width;
//    tableHeadView.frame = frame;
    
    UILabel *headTitle = [self setupHotViewTitleLabel:@"热门搜索"];
    [tableHeadView addSubview:headTitle];
    
   
    self.tableHeaderView = tableHeadView;
    
    
    
    
    //[self.tableHeaderView addSubview:button];
}

- (UILabel *)setupHotViewTitleLabel:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 50, 20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.tag = 1;
    titleLabel.textColor = [UIColor grayColor];
    [titleLabel sizeToFit];

    return titleLabel;
}

- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:12];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor lightGrayColor];
    label.layer.cornerRadius = 3;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.height_Adjustable += 20 ;
    label.width_Adjustable += 14;
    
    return label;
}
@end
