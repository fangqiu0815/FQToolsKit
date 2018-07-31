//
//  WHGradientHelper.h
//  Example
//
//  Created by whbalzac on 3/20/17.
//  Copyright © 2017 whbalzac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultWidth 200
#define kDefaultHeight 200

/** 渐变颜色方向 */
typedef NS_ENUM(NSInteger, WHGradientDirection) {
    WHLinearGradientDirectionHorizontal,                 //AC - BD   水平
    WHLinearGradientDirectionVertical,              //AB - CD   竖直
    WHLinearGradientDirectionUpwardDiagonalLine,    //A - D     上下对角线
    WHLinearGradientDirectionDownDiagonalLine,      //C - B     下上对角线
};
//      A         B
//       _________
//      |         |
//      |         |
//       ---------
//      C         D

@interface WHGradientHelper : NSObject

//   Linear Gradient
/**
 带渐变方向的渐变图片（默认尺寸） 线性渐变

 @param startColor 开始颜色
 @param endColor 终止颜色
 @param directionType 渐变方向类型
 @return 渐变图片
 */
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(WHGradientDirection)directionType;/* CGSizeMake(kDefaultWidth, kDefaultHeight) */

/**
 带渐变方向和尺寸的渐变图片

 @param startColor 开始颜色
 @param endColor 终止颜色
 @param directionType 渐变方向类型
 @param size 渐变图片尺寸
 @return 渐变图片
 */
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(WHGradientDirection)directionType option:(CGSize)size;

//    Radial Gradient
/**
 放射状渐变 图片（尺寸默认）

 @param centerColor 中心颜色
 @param outColor 边界颜色
 @return 放射状渐变图片
 */
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor;/* raduis = kDefaultWidth / 2 */
/**
 放射状渐变 带尺寸 图片

 @param centerColor 中心颜色
 @param outColor 边界颜色
 @param size 渐变图片尺寸
 @return 放射状渐变图片
 */
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor option:(CGSize)size;

//   ChromatoAnimation
/**
 色谱状动画

 @param view 色谱动画视图
 */
+ (void)addGradientChromatoAnimation:(UIView *)view;

//   LableText LinearGradient and ChromatoAnimation
/**
 添加线性渐变文本视图

 @param parentView 父视图
 @param lable 文本
 @param startColor 开始颜色
 @param endColor 终止颜色
 */
+ (void)addLinearGradientForLableText:(UIView *)parentView lable:(UILabel *)lable start:(UIColor *)startColor and:(UIColor *)endColor;  /* don't need call 'addSubview:' for lable */
/**
 添加渐变色谱动画的文本视图

 @param parentView 父视图
 @param lable 文本
 */
+ (void)addGradientChromatoAnimationForLableText:(UIView *)parentView lable:(UILabel *)lable; /* don't need call 'addSubview:' for lable */

@end
