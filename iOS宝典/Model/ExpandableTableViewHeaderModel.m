//
//  ExpandableTableViewHeaderModel.m
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/26.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import "ExpandableTableViewHeaderModel.h"

@implementation ExpandableTableViewHeaderModel

- (instancetype)initWithDictionary:(NSDictionary *)dic andSectionName:(NSString *)sectionName {
    if(self = [super init]){
        self.isExpanded = NO;
        self.sectionsTitle = sectionName;
        self.cellsDic = dic;
        //self.cellsArray = [dic allValues];
        
        NSArray *array = [self.cellsDic allValues];
         _canExpand = NO;
        for(id item in array){
            NSLog(@"%@",item);
            if(item && [item isKindOfClass:[NSDictionary class]]){
                _canExpand = YES;
            }
        }
      
        
        
        
        
        
    }
    
    
    return self;
}

@end
