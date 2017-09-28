//
//  KnowledgeViewController.h
//  iOS宝典
//
//  Created by 蔡钟鸣 on 2017/9/20.
//  Copyright © 2017年 蔡钟鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KnowledgeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *grid;
@property (strong, nonatomic) NSDictionary *rootDic;

@end
