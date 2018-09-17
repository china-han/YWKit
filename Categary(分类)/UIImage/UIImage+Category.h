//
//  UIImage+Category.h
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/* 生成纯颜色图片 */
+(UIImage *)imageWithColor:(UIColor *)color;

/*!
 *  生成纯颜色图片
 *
 *  @param color Color value
 *  @param size size
 *
 *  @return Return an UIImage instance
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*! 加载最原始的图片，没有渲染 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

/*!
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+ (UIImage *)ba_IMGCompressed:(UIImage *)sourceImg targetWidth:(CGFloat)defineWidth;

/*!
 *  icon        要裁剪的图片
 *  borderWith  头像边框的宽度
 *  borderColor 边框的颜色
 */
+ (instancetype)ba_image:(UIImage *)image
              borderWith:(CGFloat)borderWith
             borderColor:(UIColor *)borderColor;

//对图片尺寸进行压缩--
-(UIImage*)imageScaledToNewSize:(CGSize)newSize;

/*!
 *  从本地取图片
 */
+ (UIImage *)ba_getImageFromFileWithFileName:(NSString *)fileName;

@end
