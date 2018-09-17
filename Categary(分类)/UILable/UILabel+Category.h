//
//  UILabel+Category.h
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

/**
 *  初始化UILael
 */

+ (UILabel *)initWithFont:(UIFont *)titleFont           // 字体
                 titColor:(UIColor *)titColor;          // 颜色

/**
 *  初始化UILael
 */

+ (UILabel *)initWithFont:(UIFont *)titleFont           // 字体
                 titColor:(UIColor *)titColor           // 颜色
                    lines:(NSInteger)lines;             // 行数

/**
 *  初始化UILael
 */

+ (UILabel *)initWithFont:(UIFont *)titleFont           // 字体
                  titColor:(UIColor *)titColor        // 颜色
                 alignment:(NSTextAlignment)alignment   // 对齐方式
                     lines:(NSInteger)lines;             // 行数

/**
 *  初始化UILael
 */
+ (UILabel *)initWithFrame:(CGRect)frame                // 结构
                      text:(NSString *)text             // 标题
                      font:(UIFont *)titleFont           // 字体
                  titColor:(UIColor *)titColor        // 颜色
                 backColor:(UIColor *)backColor           // 颜色
                 alignment:(NSTextAlignment)alignment   // 对齐方式
                     lines:(NSInteger)lines;             // 行数

/**
 *  初始化UILael
 */
/* 初始化UILael */
+ (UILabel *)initWithFrame:(CGRect)frame                // 结构
                      text:(NSString *)text             // 标题
                      font:(UIFont *)titleFont           // 字体
                  titColor:(UIColor *)titColor        // 字体颜色
                 backColor:(UIColor *)backColor     //背景颜色
                 alignment:(NSTextAlignment)alignment   // 对齐方式
                     lines:(NSInteger)lines             // 行数
               shadowColor:(UIColor *)colorShadow;      // 阴影颜色

@end
