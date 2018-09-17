//
//  UIFont+Category.h
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Category)


/**
 返回字体 会做一个简单的适配

 @param fontSize 字体大小
 @return UIFont
 */
+ (UIFont *)fontWithfontSize:(NSInteger)fontSize;


/**
 返回字体 会做一个简单的适配

 @param fontName 字体名称
 @param fontSize 字体大小
 @return UIFont
 */
+ (UIFont *)fontWithFontName:(NSString *)fontName fontSize:(NSInteger)fontSize;
@end
