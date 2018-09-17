//
//  UIImage+Category.m
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)
+(UIImage *)imageWithColor:(UIColor *)color {
   return  [self imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

/*!
 *  图片背景颜色
 *
 *  @param color Color value
 *  @param size size
 *
 *  @return Return an UIImage instance
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*! 加载最原始的图片，没有渲染 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+ (UIImage *)ba_IMGCompressed:(UIImage *)sourceImg targetWidth:(CGFloat)defineWidth
{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImg.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImg drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        
        NSAssert(!newImage,@"图片压缩失败");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)ba_image:(UIImage *)image borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor
{
    // 1. 创建一个bitmap图形上下文
    CGSize size = CGSizeMake(image.size.height + borderWith, image.size.height + borderWith);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0); //  YES：不透明 NO:透明
    
    // 2. 获得当前的图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 是否开启反锯齿
    //    CGContextSetShouldAntialias(ctx, YES);
    
    // 3. 绘制大圆
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, size.width, size.height));
    [borderColor set];
    CGContextFillPath(ctx);
    
    // 4. 绘制小圆
    CGFloat smallX = borderWith;
    CGFloat smallY = borderWith;
    CGFloat smallW = size.width - 2 * borderWith;
    CGFloat smallH = size.height - 2 * borderWith;
    
    CGContextAddEllipseInRect(ctx, CGRectMake(smallX, smallY, smallW, smallH));
    //       CGContextFillPath(ctx);
    // 4.1 指定可以绘图的范围, 这个只会影响后面再绘制的图片
    CGContextClip(ctx);
    
    // 5. 绘制图片
    [image drawInRect:CGRectMake(smallX, smallY, smallW, smallH)];
    
    // 6. 取出yuan图片
    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7. 关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 8. 返回
    return lastImage;
}

//对图片尺寸进行压缩--
-(UIImage*)imageScaledToNewSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)ba_getImageFromFileWithFileName:(NSString *)fileName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.data", fileName]];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [UIImage imageWithData:data];
}

@end
