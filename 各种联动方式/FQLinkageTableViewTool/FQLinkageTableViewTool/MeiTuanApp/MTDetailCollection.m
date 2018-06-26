//
//  MTDetailCollection.m
//  FQLinkageTableViewTool
//
//  Created by mac on 2018/6/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "MTDetailCollection.h"

@implementation MTDetailCollection

+(MTDetailCollection*)getMainCollection:(CGFloat)height delegate:(id)delegate
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(WIDTH_SCREEN, height);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return  [[MTDetailCollection alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, height) collectionViewLayout:layout];;
    
}
-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self=[super initWithFrame:frame collectionViewLayout:layout]) {
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces=NO;
        self.backgroundColor=[UIColor redColor];
    }
    
    return self;
}

@end
