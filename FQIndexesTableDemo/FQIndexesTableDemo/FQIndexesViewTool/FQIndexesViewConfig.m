//
//  FQIndexesViewConfig.m
//  FQIndexesTableDemo
//
//  Created by mac on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQIndexesViewConfig.h"

const NSUInteger FQIndexViewInvalidSection = NSUIntegerMax - 1;
const NSInteger FQIndexViewSearchSection = -1;

static inline UIColor *FQGetColor(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha)
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

@interface FQIndexesViewConfig ()

@property (nonatomic, assign) FQIndexViewStyle indexViewStyle;  // 索引元素之间间隔距离

@end

@implementation FQIndexesViewConfig


@synthesize indexViewStyle = _indexViewStyle;

+ (instancetype)configuration
{
    return [self configurationWithIndexViewStyle:FQIndexViewStyleDefault];
}

+ (instancetype)configurationWithIndexViewStyle:(FQIndexViewStyle)indexViewStyle
{
    UIColor *indicatorBackgroundColor, *indicatorTextColor;
    UIFont *indicatorTextFont;
    CGFloat indicatorHeight;
    switch (indexViewStyle) {
        case FQIndexViewStyleDefault:
        {
            indicatorBackgroundColor = FQGetColor(200, 200, 200, 1);
            indicatorTextColor = [UIColor whiteColor];
            indicatorTextFont = [UIFont systemFontOfSize:38];
            indicatorHeight = 50;
        }
            break;
            
        case FQIndexViewStyleCenterToast:
        {
            indicatorBackgroundColor = FQGetColor(200, 200, 200, 0.8);
            indicatorTextColor = [UIColor whiteColor];
            indicatorTextFont = [UIFont systemFontOfSize:60];
            indicatorHeight = 120;
        }
            break;
            
        default:
            return nil;
            break;
    }
    
    return [self configurationWithIndexViewStyle:indexViewStyle
                        indicatorBackgroundColor:indicatorBackgroundColor
                              indicatorTextColor:indicatorTextColor
                               indicatorTextFont:indicatorTextFont
                                 indicatorHeight:indicatorHeight
                            indicatorRightMargin:40
                           indicatorCornerRadius:10
                        indexItemBackgroundColor:[UIColor clearColor]
                              indexItemTextColor:[UIColor darkGrayColor]
                indexItemSelectedBackgroundColor:FQGetColor(40, 170, 40, 1)
                      indexItemSelectedTextColor:[UIColor whiteColor]
                                 indexItemHeight:15
                            indexItemRightMargin:5
                                 indexItemsSpace:0];
}

+ (instancetype)configurationWithIndexViewStyle:(FQIndexViewStyle)indexViewStyle
                       indicatorBackgroundColor:(UIColor *)indicatorBackgroundColor
                             indicatorTextColor:(UIColor *)indicatorTextColor
                              indicatorTextFont:(UIFont *)indicatorTextFont
                                indicatorHeight:(CGFloat)indicatorHeight
                           indicatorRightMargin:(CGFloat)indicatorRightMargin
                          indicatorCornerRadius:(CGFloat)indicatorCornerRadius
                       indexItemBackgroundColor:(UIColor *)indexItemBackgroundColor
                             indexItemTextColor:(UIColor *)indexItemTextColor
               indexItemSelectedBackgroundColor:(UIColor *)indexItemSelectedBackgroundColor
                     indexItemSelectedTextColor:(UIColor *)indexItemSelectedTextColor
                                indexItemHeight:(CGFloat)indexItemHeight
                           indexItemRightMargin:(CGFloat)indexItemRightMargin
                                indexItemsSpace:(CGFloat)indexItemsSpace
{
    FQIndexesViewConfig *configuration = [self new];
    if (!configuration) return nil;
    
    configuration.indexViewStyle = indexViewStyle;
    configuration.indicatorBackgroundColor = indicatorBackgroundColor;
    configuration.indicatorTextColor = indicatorTextColor;
    configuration.indicatorTextFont = indicatorTextFont;
    configuration.indicatorHeight = indicatorHeight;
    configuration.indicatorRightMargin = indicatorRightMargin;
    configuration.indicatorCornerRadius = indicatorCornerRadius;
    
    configuration.indexItemBackgroundColor = indexItemBackgroundColor;
    configuration.indexItemTextColor = indexItemTextColor;
    configuration.indexItemSelectedBackgroundColor = indexItemSelectedBackgroundColor;
    configuration.indexItemSelectedTextColor = indexItemSelectedTextColor;
    configuration.indexItemHeight = indexItemHeight;
    configuration.indexItemRightMargin = indexItemRightMargin;
    configuration.indexItemsSpace = indexItemsSpace;
    
    return configuration;
}







@end
