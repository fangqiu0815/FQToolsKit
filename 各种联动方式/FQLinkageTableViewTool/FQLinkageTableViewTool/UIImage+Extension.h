//
//  UIImage+Extension.h
//  OrderMeal
//
//  Created by 沧海小鱼 on 15/4/20.
//  Copyright (c) 2015年 FuJu Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

    // 返回圆形图片
- (UIImage *)circleImage;
    
    /**
     *  加载显示播放gif
     */
    
+ (instancetype)animatedGIFNamed:(NSString *)name;
    /**
     *  按比例来压缩,固定宽度，高度自动缩放
     */
+ (instancetype) compressAndProportionWithImageName:(UIImage *)sourceImage AndWidth:(CGFloat)defineWidth;
    
    /**
     *  加载存在根目录下的图片（以路径的形式）此方法不适用于加载Images.xcassets中的资源
     */
+ (instancetype)jq_imageWithName:(NSString *)name;
    /**
     *截取当前视图
     **/
+ (UIImage *) captureScreen;
    /**
     *  将UIColor变换为UIImage
     */
+ (instancetype)jq_imageWithColor:(UIColor *)color;
    /**
     *  将UIColor变换为UIImage
     */
+ (instancetype)jq_imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;
    /**
     *  返回一张自由拉伸的图片
     */
+ (instancetype)resizedImageWithName:(NSString *)name;
+ (instancetype)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  返回一张自由设置尺寸的图片
 */
+ (instancetype)resizedImage:(UIImage*)image toSize:(CGSize)size;
    
    /**
     *  返回一张自由设置尺寸的图片
     */
- (UIImage *)imageForSize:(CGSize)size;

    /**
     *  返回一张圆角的图片
     */
- (UIImage*)imageWithCornerRadius:(CGFloat)radius;
    
    /**
     *  返回一张圆角的图片
     */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
    
    /**
     *  裁剪图片
     */
- (UIImage *)croppedImageWithFrame:(CGRect)frame;
    
    /**
     *  给UIImage 添加一个蒙版
     */
+ (UIImage*) maskImage:(UIImage *)image alpha:(CGFloat)alpha;
    /**
     *  给UIImage 添加一个蒙版 自定义蒙版图片
     */
    
+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
    
    /**
     *  返回一张变暗的图片
     */
- (UIImage *)darkenImageWithAlpha:(CGFloat)alpha;



/**
 *  设置图片拉伸模式 默认四角拉伸
 */
+ (UIImage *)resizableImageWithImageNamed:(NSString*)imageNamed;
/**
 *  设置图片拉伸模式 默认四角拉伸
 */
+ (UIImage *)resizableImageWithImage:(UIImage *)imageNamed;
/**
 *  设置图片拉伸模式
 */
+ (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)edgeInsets image:(UIImage *)image;

/**
 *  设置图片拉伸模式
 */
+ (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)edgeInsets imageNamed:(NSString*)imageNamed;

// 传递一个图片的名称进来，返回一个不渲染的图片
+ (UIImage *)imageNamedWithRenderOriginal:(NSString *)imageName;

/**
 *  根据image 返回放大或缩小之后的图片
 *
 *  @param image    原始图片
 *  @param multiple 放大倍数 0 ~ 2 之间
 *
 *  @return 新的image
 */
+ (UIImage *) createNewImageWithColor:(UIImage *)image multiple:(CGFloat)multiple;

/**
 根据颜色和尺寸生成图片
 
 @param color 颜色
 @param size 输出图片大小
 @return 图片大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)createImageWithColor:(UIColor *)color ;


/**
 根据颜色和尺寸生成渐变色图片
 
 @param colors 颜色数组
 @param frame 输出图片尺寸
 @return 图片
 */
+ (UIImage *)BgImageFromColors:(NSArray*)colors withFrame: (CGRect)frame;


/**
 * 加图片水印@param logoImage 需要加水印的logo图片@param watemarkImage 水印图片@returns 加好水印的图片
 */
+ (UIImage *)addWatemarkImageWithLogoImage:(UIImage *)logoImage watemarkImage:(UIImage *)watemarkImage logoImageRect:(CGRect)logoImageRect watemarkImageRect:(CGRect)watemarkImageRect;



@end
