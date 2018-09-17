//
//  UIBarButtonItem+Extension.m
//  kaolafupin
//
//  Created by hyw on 2017/9/26.
//  Copyright © 2017年 hyw. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(instancetype)itemTitle:(NSString *)title norImage:(NSString *)norImage highImage:(NSString *)highImage targert:(id)targert action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    
    if (norImage != nil && ![norImage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:norImage] forState:UIControlStateNormal];
    }
    if (highImage != nil && ![highImage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    
    if (title != nil && ![title isEqualToString:@""]) {
        
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    [btn sizeToFit];
    
    [btn addTarget:targert action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button sizeToFit];
    button.frame = (CGRect){CGPointZero, button.frame.size.width, button.frame.size.height};
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
