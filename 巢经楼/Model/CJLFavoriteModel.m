//
//  CJLFavoriteModel.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2018/1/8.
//  Copyright © 2018年 蔡钟鸣. All rights reserved.
//

#import "CJLFavoriteModel.h"

@implementation CJLFavoriteModel

-(instancetype)initWithName:(NSString *)name time:(NSString *)time
{
    if(self = [super init]){
        _name = name;
        _time = time;
    }
    return self;
}

@end
