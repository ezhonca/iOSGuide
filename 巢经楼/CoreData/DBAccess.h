//
//  DBAccess.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/1.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJLTipModel;

@interface DBAccess : NSObject
+(NSArray *)getAllSubjects;
+(NSArray *)getFirstCatalogsWithSubjectName:(NSString *)subjectName;
+(NSArray *)getSecondCatalogsWithFirstCatalogName:(NSString *)firstCatalogName;
+(NSArray *)getTipsWithSecondCatalogName:(NSString *)secondCatalogName;
+(CJLTipModel *)getTipModelWithTipName:(NSString *)tipName;
@end
