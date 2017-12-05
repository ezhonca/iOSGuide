//
//  CJLTipModel.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/6.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CJLTipViewType) {
    CJLTipViewTypeWeb = 1,
    CJLTipViewTypeImage,
    CJLTipViewTypeText,
    
};

@interface CJLTipModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CJLTipViewType type;
@property (nonatomic, strong) NSString *URL;
-(instancetype)initWithName:(NSString *)name andType:(CJLTipViewType)type andURL:(NSString *)URL;

@end
