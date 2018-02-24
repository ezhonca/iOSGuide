//
//  ExpandableTableViewHeaderModel.h
//  巢经楼
//
//  Created by 蔡钟鸣 on 2017/9/26.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpandableTableViewHeaderModel : NSObject

@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, assign, readonly) BOOL canExpand;
@property (nonatomic, strong) NSString *sectionsTitle;
@property (nonatomic, copy) NSDictionary *cellsDic;
//@property (nonatomic, copy) NSArray *sectionsArray;
//@property (nonatomic, copy) NSArray *cellsArray;
- (instancetype)initWithDictionary:(NSDictionary *)dic andSectionName:(NSString *)sectionName;

@end
