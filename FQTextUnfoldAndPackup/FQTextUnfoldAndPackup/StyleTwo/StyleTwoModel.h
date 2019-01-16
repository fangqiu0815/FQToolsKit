//
//  StyleTwoModel.h
//  FQTextUnfoldAndPackup
//
//  Created by mac on 2018/7/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StyleTwoModel : NSObject

@property (nonatomic, strong) NSString *workInfo;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) BOOL isBeyond;

- (CGFloat)heightForRowWithisShow:(BOOL)isShow;

- (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)str;


@end
