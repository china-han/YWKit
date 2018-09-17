//
//  UIView+Category.h
//  Tyre
//
//  Created by hyw on 2018/1/19.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, YWBorder) {
    YWBorderLeft   = 1 << 0,
    YWBorderRight  = 1 << 1,
    YWBorderTop    = 1 << 2,
    YWBorderBottom = 1 << 3,
    YWBorderAll    = ~0UL
};

typedef NS_ENUM(NSInteger, YWViewRectCornerType) {
    /*!
     *  设置下左角 圆角半径
     */
    YWViewRectCornerTypeBottomLeft = 0,
    /*!
     *  设置下右角 圆角半径
     */
    YWViewRectCornerTypeBottomRight,
    /*!
     *  设置上左角 圆角半径
     */
    YWViewRectCornerTypeTopLeft,
    /*!
     *  设置下右角 圆角半径
     */
    YWViewRectCornerTypeTopRight,
    /*!
     *  设置下左、下右角 圆角半径
     */
    YWViewRectCornerTypeBottomLeftAndBottomRight,
    /*!
     *  设置上左、上右角 圆角半径
     */
    YWViewRectCornerTypeTopLeftAndTopRight,
    /*!
     *  设置下左、上左角 圆角半径
     */
    YWViewRectCornerTypeBottomLeftAndTopLeft,
    /*!
     *  设置下右、上右角 圆角半径
     */
    YWViewRectCornerTypeBottomRightAndTopRight,
    /*!
     *  设置上左、上右、下右角 圆角半径
     */
    YWViewRectCornerTypeBottomRightAndTopRightAndTopLeft,
    /*!
     *  设置下右、上右、下左角 圆角半径
     */
    YWViewRectCornerTypeBottomRightAndTopRightAndBottomLeft,
    /*!
     *  设置全部四个角 圆角半径
     */
    YWViewRectCornerTypeAllCorners
};

@interface UIView (Category)

@property CGPoint ywOrigin ;
@property CGSize ywSize ;

@property(readonly) CGPoint ywBottomLeft ;
@property(readonly) CGPoint ywBottomRight ;
@property(readonly) CGPoint ywTopRight ;
@property(readonly) CGPoint ywTopLeft ;

@property CGFloat ywHeight ;
@property CGFloat ywWidth ;
@property CGFloat ywTop ;
@property CGFloat ywLeft ;
@property CGFloat ywBottom ;
@property CGFloat ywRight ;
@property CGFloat ywCenterX ;
@property CGFloat ywCenterY ;


/**
 *  中心点变化
 *
 *  @param addCenterP 增加的point数值
 */
- (void)centerMoveBy:(CGPoint)addCenterP ;

/**
 *  view的缩放比例
 *
 *  @param scaleValue 比例值（0-1）
 */
- (void)scaleToValue:(CGFloat)scaleValue ;

/**
 *  动画（单位时间内2点之间的移动动画）
 */
- (void)startAnimationForView_time:(CGFloat)time x:(CGFloat)x y:(CGFloat)y ;
/**
 *  取消动画（恢复到起始点）
 */
- (void)endAnimationForView_time:(CGFloat)time ;

/**
 设置虚线边框

 @param lineLength 虚线长度
 @param lineSpacing 虚线间隔
 @param lineColor 虚线颜色
 */
- (void)drawDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

/**
 设置实线边框

 @param Borders 类型
 @param color 边框颜色
 @param width 边框宽度
 */
- (void)setBorders:(YWBorder) Borders borderColor:(UIColor*) color borderWidth:(CGFloat) width;


/**
 * 删除实线边框
 */
- (void)removeBorders;

/**
 根据类型设置圆角

 @param viewRectCornerType 圆角类型
 @param conner 圆角半径
 */
- (void)setYWViewRectCornerType:(YWViewRectCornerType)viewRectCornerType viewCornerRadius:(CGFloat) conner;

/**
 设置全部圆角
 
 @param conner 圆角半径
 */
- (void)setAllCorner:(CGFloat) conner;


/**
 创建阴影

 @param offset 阴影的偏移量
 @param opacity 阴影的透明度
 @param radius 阴影的模糊程度
 */
- (void)setRectShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;


/**
 创建圆角半径阴影

 @param cornerRadius 设置圆角半径
 @param offset 阴影的偏移量
 @param opacity 阴影的透明度
 @param radius 阴影的模糊程度
 */
- (void)setCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

/**
 *删除阴影
 */
- (void)removeShadow;


/**
 给UIView添加点击事件

 @param target target
 @param action action
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 返回view所在控制器

 @return UIViewController
 */
- (UIViewController *)getCurrentViewController;

/**
 摇摆动画

 @param repeatCount 重复次数
 @param duration 间隔时间
 @param autoreverses 是否自动翻转
 */
- (void)yw_shakeViewWithRepeatCount:(CGFloat)repeatCount duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses;

/**
 UIView的类初始化

 @param frame frame
 @param backgroundColor backgroundColor
 @return UIView
 */
+ (UIView *)viewWithFrame:(CGRect)frame  backgroundColor:(UIColor *)backgroundColor;


/**
 UIView的类初始化

 @param backgroundColor backgroundColor
 @return UIView
 */
+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor;
@end
