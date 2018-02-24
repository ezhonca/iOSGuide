//
//  DBAccess.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/1.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CJLTipModel;
@class CJLFavoriteModel;

@interface DBAccess : NSObject
+(NSArray *)getAllSubjects;
+(NSArray *)getFirstCatalogsWithSubjectName:(NSString *)subjectName;
+(NSArray *)getSecondCatalogsWithFirstCatalogName:(NSString *)firstCatalogName;
+(NSArray *)getTipsWithSecondCatalogName:(NSString *)secondCatalogName;
+(CJLTipModel *)getTipModelWithTipName:(NSString *)tipName;
+(NSArray<NSString *> *)getAllTipsName;
+(BOOL)insertIntoFavorite:(CJLTipModel *)tipModel;
+(BOOL)getFavoriteWithName:(CJLTipModel *)tipModel;
+(BOOL)deleteFavoriteWithName:(NSString *)name;
+(NSMutableArray<CJLFavoriteModel *> *)getAllFavorites;
@end
