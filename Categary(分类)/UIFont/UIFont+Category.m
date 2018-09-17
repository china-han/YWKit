//
//  UIFont+Category.m
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "UIFont+Category.h"

@implementation UIFont (Category)

+ (UIFont *)fontWithfontSize:(NSInteger)fontSize{
    return [UIFont systemFontOfSize:[self fitFont:fontSize]];
}

+ (UIFont *)fontWithFontName:(NSString *)fontName fontSize:(NSInteger)fontSize{
    return [UIFont fontWithFontName:fontName fontSize:[self fitFont:fontSize]];
}

/**
 简单做一个字体适配 宽度大于375，字体大小加1 宽度小于375，字体大小减一1  宽度等于375不变

 @param fontSize 字体大小
 @return 返回校验后的字体大小
 */
+ (NSInteger)fitFont:(NSInteger)fontSize{
    NSInteger b = 0 ;
    
    if (kScreenWidth<375) {
        b = fontSize-1 ;
    }
    if(kScreenWidth==375) {
        b = fontSize  ;
    }
    if(kScreenWidth>375){
        b = fontSize + 1 ;
    }
    return b;
}
@end
