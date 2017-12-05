//
//  CJLTipModel.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/6.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "CJLTipModel.h"

@implementation CJLTipModel

-(instancetype)initWithName:(NSString *)name andType:(CJLTipViewType)type andURL:(NSString *)URL
{
    if(self = [super init]){
        _name = name;
        _type = type;
        _URL = URL;
    }
    return self;
}

@end
