//
//  CJLFavoriteModel.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2018/1/8.
//  Copyright © 2018年 蔡钟鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJLFavoriteModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *time;

-(instancetype)initWithName:(NSString *)name time:(NSString *)time;

@end
