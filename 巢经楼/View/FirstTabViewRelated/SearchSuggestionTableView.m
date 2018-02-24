//
//  SearchSuggestionTableView.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/30.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "SearchSuggestionTableView.h"
#import "CONSTFile.h"

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
    
    UIView *tableHeadView = [[UIView alloc] init];
    tableHeadView.width_Adjustable = self.frame.size.width;
//    CGRect frame = tableHeadView.frame;
//    frame.size.width = [UIScreen mainScreen].bounds.size.width;
//    tableHeadView.frame = frame;
    
    UILabel *headTitle = [self setupHotViewTitleLabel:@"热门搜索"];
    [tableHeadView addSubview:headTitle];
    UIView *contentsView = [[UIView alloc] init];
    contentsView.width_Adjustable = self.frame.size.width;
    contentsView.x_Adjustable = headTitle.x_Adjustable + HOTSEARCH_MARGIN;
    contentsView.y_Adjustable = CGRectGetMaxY(headTitle.frame) + HOTSEARCH_MARGIN;
    NSArray<NSString *> *array = @[@"面对对象", @"多线程", @"设计模式", @"Delegate"];
    [self setupHotLabelsInContentsView:contentsView labelsTexts:array];
    //contentsView.height_Adjustable = 50;
    [tableHeadView addSubview:contentsView];
    UILabel *historyTitle = [self setupHotViewTitleLabel:@"搜索历史"];
    historyTitle.y_Adjustable = CGRectGetMaxY(contentsView.frame) + HOTSEARCH_MARGIN * 2;
    [tableHeadView addSubview:historyTitle];
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setImage:[UIImage imageNamed:@"empty"] forState:UIControlStateNormal];
    [clearButton setTitle:@"清空记录" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    clearButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [clearButton addTarget:self action:@selector(clearButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    //clearButton.titleLabel.text = @"清空记录";
    [clearButton sizeToFit];
    clearButton.x_Adjustable = self.frame.size.width - clearButton.width_Adjustable - HOTSEARCH_MARGIN;
    clearButton.y_Adjustable = historyTitle.y_Adjustable;
    [tableHeadView addSubview:clearButton];
    tableHeadView.height_Adjustable = CGRectGetMaxY(tableHeadView.subviews.lastObject.frame) + HOTSEARCH_MARGIN;
    self.tableHeaderView = tableHeadView;
    
    
    
    
    //[self.tableHeaderView addSubview:button];
}

- (void)clearButtonDidClick
{
    self.clearButtonClickBlock();
    
    
}

- (UILabel *)setupHotViewTitleLabel:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 50, 20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.tag = 1;
    titleLabel.textColor = [UIColor orangeColor];
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
    label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
    //label.backgroundColor = [UIColor lightGrayColor];
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.height_Adjustable += 20 ;
    label.width_Adjustable += 14;
    
    return label;
}

- (void)setupHotLabelsInContentsView:(UIView *)contentsView labelsTexts:(NSArray<NSString *> *)textArray
{
    [contentsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat CurrentX = 0.0;
    CGFloat CurrentY = 0.0;
    for(NSString *text in textArray){
        UILabel *label = [self labelWithTitle:text];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotLabelClick:)]];
        if(label.width_Adjustable > contentsView.width_Adjustable)
            label.width_Adjustable = contentsView.width_Adjustable;
        if(label.width_Adjustable + CurrentX <= contentsView.width_Adjustable){
            label.x_Adjustable = CurrentX;
            CurrentX += (label.width_Adjustable + HOTSEARCH_MARGIN);
            label.y_Adjustable = CurrentY;
        }else{
            CurrentX = 0.0;
            label.x_Adjustable = CurrentX;
            CurrentX += label.width_Adjustable + HOTSEARCH_MARGIN;
            CurrentY += (HOTSEARCH_MARGIN + label.height_Adjustable);
            label.y_Adjustable = CurrentY;
        }
        [contentsView addSubview:label];
    }
    contentsView.height_Adjustable = CGRectGetMaxY([contentsView.subviews lastObject].frame);
    
    
    
    
    
    
    
}

- (void)hotLabelClick:(UIGestureRecognizer *)gr
{
    UILabel *label = (UILabel *)gr.view;
    self.hotLabelDidClickBlock(label.text);
}







@end
