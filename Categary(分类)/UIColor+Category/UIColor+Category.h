//
//  UIColor+Category.h
//  Tyre
//
//  Created by hyw on 2018/1/19.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)
//随机颜色
+ (UIColor *)randomColor;

/* 从十六进制字符串获取颜色 */
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;

/* 从十六进制字符串获取颜色 */
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


- (UIColor *)colorByDarkeningColorWithValue:(CGFloat)value;
@end
