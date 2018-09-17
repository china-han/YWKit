//
//  UILabel+Category.m
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

+ (UILabel *)initWithFont:(UIFont *)titleFont           // 字体
                 titColor:(UIColor *)titColor          // 颜色
{
    return [self initWithFont:titleFont titColor:titColor lines:0];
}

+ (UILabel *)initWithFont:(UIFont *)titleFont           // 字体
                 titColor:(UIColor *)titColor           // 颜色
                    lines:(NSInteger)lines             // 行数
{
    return [self initWithFont:titleFont titColor:titColor alignment:NSTextAlignmentLeft lines:lines];
}

+ (UILabel *)initWithFont:(UIFont *)titleFont           // 字体
                 titColor:(UIColor *)titColor        // 颜色
                alignment:(NSTextAlignment)alignment   // 对齐方式
                    lines:(NSInteger)lines           // 行数
{
   return [self initWithFrame:CGRectZero text:nil font:titleFont titColor:titColor backColor:nil alignment:alignment lines:lines];
}


/* 初始化UILael */
+ (UILabel *)initWithFrame:(CGRect)frame                // 结构
                      text:(NSString *)text             // 标题
                      font:(UIFont *)titleFont           // 字体
                  titColor:(UIColor *)titColor        // 颜色
                 backColor:(UIColor *)backColor           // 颜色
                 alignment:(NSTextAlignment)alignment   // 对齐方式
                     lines:(NSInteger)lines             // 行数
{
    return [UILabel initWithFrame:frame
                             text:text
                             font:titleFont
                         titColor:(UIColor *)titColor       
                        backColor:(UIColor *)backColor
                        alignment:alignment
                            lines:lines
                      shadowColor:[UIColor clearColor]];
}

/* 初始化UILael */
+ (UILabel *)initWithFrame:(CGRect)frame                // 结构
                      text:(NSString *)text             // 标题
                      font:(UIFont *)titleFont           // 字体
                     titColor:(UIColor *)titColor        // 字体颜色
                      backColor:(UIColor *)backColor     //背景颜色
                 alignment:(NSTextAlignment)alignment   // 对齐方式
                     lines:(NSInteger)lines             // 行数
               shadowColor:(UIColor *)colorShadow       // 阴影颜色
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.font = titleFont ? titleFont : [UIFont systemFontOfSize:15.0f];
    if (text) {
          [label setText:text];
    }
    if (titColor) {
        [label setTextColor:titColor];
    }
    if (backColor) {
        [label setBackgroundColor:backColor];
    }
    if (colorShadow) {
         [label setShadowColor:colorShadow];
    }
    [label setTextAlignment:alignment];
    [label setNumberOfLines:lines];
    
    return label;
}

@end
