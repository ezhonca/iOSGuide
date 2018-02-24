//
//  CJLFavoriteTableViewCell.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2018/1/8.
//  Copyright © 2018年 蔡钟鸣. All rights reserved.
//

#import "CJLFavoriteTableViewCell.h"
#import "UIView+FrameExtension.h"
#import "UIColor+CJLColor.h"

@implementation CJLFavoriteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [[NSBundle mainBundle] loadNibNamed:@"CJLFavoriteTableViewCell" owner:self options:nil];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.x_Adjustable + 5, self.y_Adjustable + 5, self.width_Adjustable - 10, self.height_Adjustable - 5)];
    bgView.backgroundColor = [UIColor cjl_defaultBackgroundColor];
    bgView.layer.cornerRadius = 10;
    [self.contentView addSubview:bgView];
    
    [self.addTimeLabel sizeToFit];
    //[self.contentView addSubview:self.addTimeLabel];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
