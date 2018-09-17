//
//  UIButton+Category.m
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "UIButton+Category.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

static char buttonAction;

@implementation UIButton (Category)

//设置点击调用方法
-(void)setButtonActionBlock:(UIButtonActionBlock)buttonActionBlock{
    [self addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setAssociatedBlock:buttonActionBlock forkey:&buttonAction];
}

-(UIButtonActionBlock)buttonActionBlock{
    return  [self associatedBlockForKey:&buttonAction];
}

- (void)handleButtonAction:(UIButton *)sender
{
    if (self.buttonActionBlock)
    {
        self.buttonActionBlock(sender);
    }
}



- (void)ywlayoutButtonWithEdgeInsetsStyle:(YWButtonEdgeInsetsStyle)style
                          imageTitleSpace:(CGFloat)space
{
    //    self.backgroundColor = [UIColor cyanColor];
    
    
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case YWButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case YWButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case YWButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case YWButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



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
                       selector:(SEL __nullable)sel
{
    
   return  [self buttonWithFrame:frame title:title selTitle:selTitle titleColor:titleColor seltitleColor:seltitleColor titleFont:titleFont image:[UIImage imageNamed:imageName] selImage:[UIImage imageNamed:selImageName] backImage:[UIImage imageNamed:backImageName] selBackImage:[UIImage imageNamed:selBackImageName] target:target selector:sel];
    
    
}
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
                       selector:(SEL __nullable)sel
{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    if ([title isNotEmpty]) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if ([selTitle isNotEmpty]) {
        [btn setTitle:selTitle forState:UIControlStateSelected];
    }
    if (titleColor) {
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (seltitleColor) {
        [btn setTitleColor:seltitleColor forState:UIControlStateSelected];
    }
    if (selImage)
    {
        [btn setImage:selImage forState:UIControlStateSelected];
    }
    if (image)
    {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (backImage) {
        [btn setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    if (selBackImage) {
        [btn setBackgroundImage:selBackImage forState:UIControlStateSelected];
    }
    if (target) {
        [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    btn.titleLabel.font = titleFont ? titleFont : [UIFont systemFontOfSize:15.0f];
    return btn;
}



- (void)setEnlargeEdge:(CGFloat) size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*) hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? self : nil;
}


@end
