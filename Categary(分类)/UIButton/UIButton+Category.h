//
//  UIButton+Category.h
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YWButtonEdgeInsetsStyle) {
    YWButtonEdgeInsetsStyleTop, // image在上，label在下
    YWButtonEdgeInsetsStyleLeft, // image在左，label在右
    YWButtonEdgeInsetsStyleBottom, // image在下，label在上
    YWButtonEdgeInsetsStyleRight // image在右，label在左
};

typedef void (^UIButtonActionBlock)(UIButton * _Nonnull button);

@interface UIButton (Category)

////设置点击调用方法
@property(nonatomic, copy) UIButtonActionBlock buttonActionBlock;

- (void)ywlayoutButtonWithEdgeInsetsStyle:(YWButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

- (void)setEnlargeEdge:(CGFloat) size;


/**
 创建btn
 
 @param frame frame
 @param title title
 @param selTitle selTitle
 @param titleColor titleColor
 @param seltitleColor seltitleColor
 @param titleFont titleFont 默认：15
 @param imageName imageName
 @param selImageName selImageName
 @param backImageName backImageName
 @param selBackImageName selBackImageName
 @param target target
 @param sel sel
 @return button
 */
+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                       selTitle:(NSString * )selTitle
                     titleColor:(UIColor * )titleColor
                  seltitleColor:(UIColor * )seltitleColor
                      titleFont:(UIFont * )titleFont
                      imageName:(NSString * )imageName
                   selImageName:(NSString * )selImageName
                  backImageName:(NSString * )backImageName
               selBackImageName:(NSString * )selBackImageName
                         target:(id __nullable)target
                       selector:(SEL __nullable)sel;

/**
 创建btn

 @param frame frame
 @param title title
 @param selTitle selTitle
 @param titleColor titleColor
 @param seltitleColor seltitleColor
 @param titleFont titleFont 默认：15
 @param image image
 @param selImage selImage
 @param backImage backImage
 @param selBackImage selBackImage
 @param target target
 @param sel sel
 @return button
 */
+ (instancetype)buttonWithFrame:(CGRect)frame
                          title:(NSString *)title
                       selTitle:(NSString * )selTitle
                     titleColor:(UIColor * )titleColor
                  seltitleColor:(UIColor * )seltitleColor
                      titleFont:(UIFont * )titleFont
                          image:(UIImage * )image
                       selImage:(UIImage * )selImage
                      backImage:(UIImage * )backImage
                   selBackImage:(UIImage * )selBackImage
                         target:(id __nullable)target
                       selector:(SEL __nullable)sel;
@end
