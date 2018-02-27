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
#import "CJLFavoriteModel.h"

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
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docPath stringByAppendingPathComponent:@"CJL.db"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:filename]){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CJL" ofType:@"db"];
        NSError *error;
        if ([fileManager copyItemAtPath:path toPath:filename error:&error]) {
            NSLog(@"数据库移动成功");
        } else {
            NSLog(@"数据库移动失败");
        }
        //[fileManager copyItemAtPath:path toPath:filename error:error];
    }
    
    
    
    return [FMDatabase databaseWithPath:filename];
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

+(NSArray<NSString *> *)getAllTipsName
{
    NSMutableArray<NSString *> *allTipsNameArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    if([database open]){
        NSString *sql = [NSString stringWithFormat:@"select name from tip"];
        FMResultSet *rs = [database executeQuery:sql];
        while([rs next]){
            [allTipsNameArray addObject:[rs stringForColumn:@"name"]];
        }
        [database close];
    }
    return allTipsNameArray;
}

+(NSArray<CJLTipModel *> *)getTipsWithSecondCatalogName:(NSString *)secondCatalogName
{
    NSMutableArray<CJLTipModel *> *tipsArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    if([database open]){
        NSString *sql = [NSString stringWithFormat:@"select name,sourceType,URL from tip where secondCatalogID = (select id from secondCatalog where name = '%@')", secondCatalogName];
        FMResultSet *rs = [database executeQuery:sql];
        while([rs next]){
            NSString *name = [rs stringForColumn:@"name"];
            CJLTipViewType type = [rs intForColumn:@"sourceType"];
            NSString *URL = [rs stringForColumn:@"URL"];
             CJLTipModel *tipModel = [[CJLTipModel alloc] initWithName:name andType:type andURL:URL];
            [tipsArray addObject:tipModel];
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

+(BOOL)insertIntoFavorite:(CJLTipModel *)tipModel
{
    FMDatabase *database = [self getDatabase];
    if([database open]){
        NSDate *date = [NSDate date];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSString *time = [df stringFromDate:date];
        BOOL isSuccess = [database executeUpdate:@"insert into favorite (name, time) values (?,?)", tipModel.name, time];
//        FMResultSet *rs = [database executeQuery:@"select * from favorite"];
//        if([rs next]){
//            NSString *a =  [rs stringForColumnIndex:1];
//            NSString *b =  [rs stringForColumnIndex:0];
//        }
        [database close];
        return isSuccess;
    }
    return NO;
    
}

+(BOOL)getFavoriteWithName:(CJLTipModel *)tipModel
{
    FMDatabase *database = [self getDatabase];
    if([database open]){
        FMResultSet *rs = [database executeQuery:@"select count(*) from favorite where name = ?", tipModel.name];
        if([rs next]){
            BOOL isfavorite =  [rs intForColumnIndex:0];
            [database close];
            return isfavorite;
        }
    }
    
    return  NO;
}

+(BOOL)deleteFavoriteWithName:(NSString *)name
{
    FMDatabase *database = [self getDatabase];
    if([database open]){
        BOOL isSuccess = [database executeUpdate:@"delete from favorite where name = ?", name];
        [database close];
        return isSuccess;
    }
    
    return NO;
}

+(NSMutableArray<CJLFavoriteModel *> *)getAllFavorites
{
    NSMutableArray<CJLFavoriteModel *> *allFavoriteArray = [[NSMutableArray<CJLFavoriteModel *> alloc] init];
    FMDatabase *database = [self getDatabase];
    if([database open]){
        NSString *sql = [NSString stringWithFormat:@"select name,time from favorite"];
        FMResultSet *rs = [database executeQuery:sql];
        while([rs next]){
            NSString *name = [rs stringForColumn:@"name"];
            NSString *time = [rs stringForColumn:@"time"];
            CJLFavoriteModel *favorite = [[CJLFavoriteModel alloc] initWithName:name time:time];
            [allFavoriteArray addObject:favorite];
        }
        [database close];
    }
    return allFavoriteArray;
}

+(NSArray<CJLTipModel *> *)getRandomTips:(NSString *)numOfCells
{
    NSMutableArray<CJLTipModel *> *tipsArray = [[NSMutableArray alloc] init];
    FMDatabase *database = [self getDatabase];
    if([database open]){
        //NSString *sql = [NSString stringWithFormat:@"select name,sourceType,URL from tip order by random() limit ?", numOfCells];
        FMResultSet *rs = [database executeQuery:@"select name,sourceType,URL from tip order by random() limit ?", numOfCells];
        while([rs next]){
            NSString *name = [rs stringForColumn:@"name"];
            CJLTipViewType type = [rs intForColumn:@"sourceType"];
            NSString *URL = [rs stringForColumn:@"URL"];
            CJLTipModel *tipModel = [[CJLTipModel alloc] initWithName:name andType:type andURL:URL];
            [tipsArray addObject:tipModel];
        }
        [database close];
    }
    return tipsArray;
}

@end
