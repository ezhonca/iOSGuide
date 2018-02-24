//
//  BookmarkHandle.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/10/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookmarkModel+CoreDataModel.h"
#import "AppDelegate.h"

@interface BookmarkHandle : NSObject


+ (void)InsertBookmark:(NSString *)bookmarkName WithBookmarkUrl:(NSString *)bookmarkurl;

+ (void)DeleteBookmark:(id)object;

+ (Bookmark *)FetchBookmark:(NSString *)name;

+ (NSMutableSet *)FetchAllBookmark;

@end
