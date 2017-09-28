//
//  ExpandableTableViewHeader.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/26.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "ExpandableTableViewHeader.h"

#define ScreemWidth [UIScreen mainScreen].bounds.size.width

@interface ExpandableTableViewHeader()



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
        [self setupItems];
    }
    
    
    return self;
}

- (void)setupItems{
    UIButton *backgroundButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreemWidth, 44)];
    backgroundButton.backgroundColor = [UIColor clearColor];
    [backgroundButton addTarget:self action:@selector(backgroundButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:backgroundButton];
    
    UIImage *image = [UIImage imageNamed:@"brand_expand"];
    self.accessoryView = [[UIImageView alloc] initWithImage:image];
    self.accessoryView.frame = CGRectMake(ScreemWidth - 30, (44-8)/2, 15, 8);
    //self.accessoryView.image = [UIImage imageNamed:@"brand_expand"];
    [self.contentView addSubview:self.accessoryView];
    
    
    
    
}

- (void) backgroundButtonClicked{
    //self.isExpanded = !self.isExpanded;
    
       
    self.headerClickBackBlock();
}


@end
