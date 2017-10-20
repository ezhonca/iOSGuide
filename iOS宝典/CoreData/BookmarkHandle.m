//
//  BookmarkHandle.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/10/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "BookmarkHandle.h"

@implementation BookmarkHandle

+ (void)InsertBookmark:(NSString *)bookmarkName WithBookmarkUrl:(NSString *)bookmarkurl
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = app.persistentContainer.viewContext;
    if(![app.favoriteMutableSet containsObject:bookmarkName]){
        [app.favoriteMutableSet addObject:bookmarkName];
        Bookmark *bookmark = [[Bookmark alloc] initWithContext:managedObjectContext];
        bookmark.name = bookmarkName;
        bookmark.urlString = bookmarkurl;
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
 
}

+ (void)DeleteBookmark:(id)object
{
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;;
    [context deleteObject:object];
    
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



@end
