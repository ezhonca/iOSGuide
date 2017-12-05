//
//  DBAccess.m
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/12/1.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "DBAccess.h"
#import "FMDB.h"
#import "CJLTipModel.h"

@interface DBAccess ()
//@property(nonatomic, strong) static FMDatabase *database;

@end

@implementation DBAccess

//-(FMDatabase *)database
//{
//    if(!_database){
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"CJL" ofType:@"db"];
//        _database = [FMDatabase databaseWithPath:path];
//    }
//    return _database;
//}
+(FMDatabase *)getDatabase
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CJL" ofType:@"db"];
    return [FMDatabase databaseWithPath:path];
}

+(NSArray *)getAllSubjects
{
    NSMutableArray *subjectArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    [database open];
    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('id' integer primary key autoincrement not null,'name' text unique not null)",@"subject"];//如果表不存在，则创建表
    [database executeUpdate:sqlCreateTable];
    
    if([database open]){
        NSString * sql = @"SELECT * FROM subject";//SQL语句无条件查询
        FMResultSet * rs = [database executeQuery:sql];
        while([rs next]){
            [subjectArray addObject:[rs stringForColumn:@"name"]];
        }
        [database close];
    }
    return subjectArray;
}

+(NSArray *)getFirstCatalogsWithSubjectName:(NSString *)subjectName
{
    NSMutableArray *firstCatalogArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    if([database open]){
        NSString *sql = [NSString stringWithFormat:@"select firstCatalog.name from firstCatalog where subjectID = (select id from subject where name = '%@')", subjectName];
        FMResultSet *rs = [database executeQuery:sql];
        while([rs next]){
            [firstCatalogArray addObject:[rs stringForColumn:@"name"]];
        }
        [database close];
    }
    return firstCatalogArray;
}

+(NSArray *)getSecondCatalogsWithFirstCatalogName:(NSString *)firstCatalogName
{
    NSMutableArray *secondCatalogArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    if([database open]){
        NSString *sql = [NSString stringWithFormat:@"select secondCatalog.name from secondCatalog where firstCatalogID = (select id from firstCatalog where name = '%@')", firstCatalogName];
        FMResultSet *rs = [database executeQuery:sql];
        while([rs next]){
            [secondCatalogArray addObject:[rs stringForColumn:@"name"]];
        }
        [database close];
    }
    return secondCatalogArray;
}

+(NSArray *)getTipsWithSecondCatalogName:(NSString *)secondCatalogName
{
    NSMutableArray *tipsArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    if([database open]){
        NSString *sql = [NSString stringWithFormat:@"select name from tip where secondCatalogID = (select id from secondCatalog where name = '%@')", secondCatalogName];
        FMResultSet *rs = [database executeQuery:sql];
        while([rs next]){
            [tipsArray addObject:[rs stringForColumn:@"name"]];
        }
        [database close];
    }
    return tipsArray;
}

+(CJLTipModel *)getTipModelWithTipName:(NSString *)tipName
{
    //NSMutableArray *tipsArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    CJLTipModel *tipModel;
    if([database open]){
        NSString *sql = [NSString stringWithFormat:@"select sourceType,URL from tip where name = '%@'", tipName];
        FMResultSet *rs = [database executeQuery:sql];
        
        while([rs next]){
            CJLTipViewType type = [rs intForColumn:@"sourceType"];
            NSString *URL = [rs stringForColumn:@"URL"];
            tipModel = [[CJLTipModel alloc] initWithName:tipName andType:type andURL:URL];
        }
        [database close];
    }
    return tipModel;
}

@end
