//
//  UIBarButtonItem+Extension.h
//  kaolafupin
//
//  Created by hyw on 2017/9/26.
//  Copyright © 2017年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(instancetype)itemTitle:(NSString *)title norImage:(NSString *)norImage highImage:(NSString *)highImage targert:(id)targert action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end


