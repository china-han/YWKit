//
//  UIView+Category.m
//  Tyre
//
//  Created by hyw on 2018/1/19.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "UIView+Category.h"

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;
@implementation UIView (Category)

#pragma mark - frame
-(CGPoint)ywOrigin{
    return self.frame.origin;
}
-(void)setYwOrigin:(CGPoint)ywOrigin{
    CGRect newframe = self.frame;
    newframe.origin = ywOrigin;
    self.frame = newframe;
}
- (CGSize)ywSize
{
    return self.frame.size;
}
- (void)setYwSize:(CGSize)ywSize
{
    CGRect newframe = self.frame;
    newframe.size = ywSize;
    self.frame = newframe;
}

- (CGPoint)ywBottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)ywBottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)ywTopRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}
- (CGPoint)ywTopLeft
{
    CGFloat x = self.frame.origin.x ;//+ self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

- (CGFloat)ywHeight
{
    return self.frame.size.height;
}
- (void)setYwHeight:(CGFloat)ywHeight
{
    CGRect newframe = self.frame;
    newframe.size.height = ywHeight;
    self.frame = newframe;
}

- (CGFloat)ywWidth
{
    return self.frame.size.width;
}

- (void)setYwWidth:(CGFloat)ywWidth
{
    CGRect newframe = self.frame;
    newframe.size.width = ywWidth;
    self.frame = newframe;
}

- (CGFloat)ywTop
{
    return self.frame.origin.y;
}

- (void)setYwTop:(CGFloat)ywTop
{
    CGRect newframe = self.frame;
    newframe.origin.y = ywTop;
    self.frame = newframe;
}

- (CGFloat)ywLeft
{
    return self.frame.origin.x;
}

- (void)setYwLeft:(CGFloat)ywLeft
{
    CGRect newframe = self.frame;
    newframe.origin.x = ywLeft;
    self.frame = newframe;
}

- (CGFloat)ywCenterX
{
    return self.center.x;
}

- (void)setYwCenterX:(CGFloat)ywCenterX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = ywCenterX- newFrame.size.width/2 ;
    self.frame = newFrame;
}

- (CGFloat)ywCenterY
{
    return self.center.y ;
}

- (void)setYwCenterY:(CGFloat)ywCenterY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = ywCenterY - newFrame.size.height/2 ;
    self.frame = newFrame;
}

- (CGFloat)ywBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYwBottom:(CGFloat)ywBottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = ywBottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)ywRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYwRight:(CGFloat)ywRight
{
    CGFloat delta = ywRight - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

#pragma mark -  中心点变化
- (void)centerMoveBy:(CGPoint)addCenterP ;
{
    CGPoint newcenter = self.center;
    newcenter.x += addCenterP.x;
    newcenter.y += addCenterP.y;
    self.center = newcenter;
}

#pragma mark -  view的缩放比例
- (void)scaleToValue:(CGFloat)scaleValue ;
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleValue;
    newframe.size.height *= scaleValue;
    self.frame = newframe;
}

#pragma mark - 动画
 //  动画（单位时间内2点之间的移动动画）
- (void)startAnimationForView_time:(CGFloat)time x:(CGFloat)x y:(CGFloat)y
{
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformMakeTranslation(x , y ) ;
    }];
}

//  取消动画（恢复到起始点）
- (void)endAnimationForView_time:(CGFloat)time
{
    [UIView animateWithDuration:time animations:^{
        self.transform = CGAffineTransformIdentity ;
    }] ;
}

#pragma mark - 边框
// 设置虚线边框
- (void)drawDashLineWithLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = lineColor.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    border.frame = self.bounds;
    border.lineWidth = 1;
    border.lineDashPattern = @[@(lineLength), @(lineSpacing)];
    [self.layer addSublayer:border];
}

// 设置实线边框
- (void)setBorders:(YWBorder) Borders borderColor:(UIColor*) color borderWidth:(CGFloat) width{
    UIView *borderView = [[UIView alloc]init];
    if((Borders & YWBorderLeft) == YWBorderLeft)
    {
        borderView.frame = CGRectMake(0, 0, width, self.frame.size.height);
        borderView.backgroundColor = color;
        [self addSubview:borderView];
    }
    if((Borders & YWBorderRight) == YWBorderRight)
    {
        borderView.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        borderView.backgroundColor = color;
        [self addSubview:borderView];
    }
    if((Borders & YWBorderTop) == YWBorderTop)
    {
        borderView.frame = CGRectMake(0, 0, self.frame.size.width, width);
        borderView.backgroundColor = color;
        [self addSubview:borderView];
    }
    if((Borders & YWBorderBottom) == YWBorderBottom)
    {
        borderView.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        borderView.backgroundColor = color;
        [self addSubview:borderView];
    }
    borderView.tag = @"borderView".hash + 999999999;
}

//删除实线边框
- (void)removeBorders{
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 0;
    self.layer.borderColor = nil;
    UIView *borderView = [self viewWithTag:@"borderView".hash + 999999999];
    if (borderView) {
        [borderView removeFromSuperview];
    }
}

#pragma mark -   阴影
// 创建阴影
- (void)setRectShadowWithOffset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    // 设置阴影的颜色
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的透明度
    self.layer.shadowOpacity = opacity;
    // 设置阴影的偏移量
    self.layer.shadowOffset = offset;
    // 设置阴影的模糊程度
    self.layer.shadowRadius = radius;
    // 设置边界是否遮盖
    self.layer.masksToBounds = NO;
}

//创建圆角半径阴影 
- (void)setCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    // 设置阴影的颜色
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的透明度
    self.layer.shadowOpacity = opacity;
    // 设置阴影的偏移量
    self.layer.shadowOffset = offset;
    // 设置阴影的模糊程度
    self.layer.shadowRadius = radius;
    // 设置是否栅格化
    self.layer.shouldRasterize = YES;
    // 设置圆角半径
    self.layer.cornerRadius = cornerRadius;
    // 设置阴影的路径
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds]
                                                        cornerRadius:cornerRadius] CGPath];
    // 设置边界是否遮盖
    self.layer.masksToBounds = NO;
}

//删除阴影
- (void)removeShadow{
    [self.layer setShadowColor:[[UIColor clearColor] CGColor]];
    [self.layer setShadowOpacity:0.0f];
    [self.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
}

#pragma mark -   圆角
//根据类型设置圆角
- (void)setYWViewRectCornerType:(YWViewRectCornerType)viewRectCornerType viewCornerRadius:(CGFloat) conner{
     UIRectCorner corners;
    switch (viewRectCornerType)
    {
        case YWViewRectCornerTypeBottomLeft:
        {
            corners = UIRectCornerBottomLeft;
        }
            break;
        case YWViewRectCornerTypeBottomRight:
        {
            corners = UIRectCornerBottomRight;
        }
            break;
        case YWViewRectCornerTypeTopLeft:
        {
            corners = UIRectCornerTopLeft;
        }
            break;
        case YWViewRectCornerTypeTopRight:
        {
            corners = UIRectCornerTopRight;
        }
            break;
        case YWViewRectCornerTypeBottomLeftAndBottomRight:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
            break;
        case YWViewRectCornerTypeTopLeftAndTopRight:
        {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
            break;
        case YWViewRectCornerTypeBottomLeftAndTopLeft:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
        }
            break;
        case YWViewRectCornerTypeBottomRightAndTopRight:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
        }
            break;
        case YWViewRectCornerTypeBottomRightAndTopRightAndTopLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
        }
            break;
        case YWViewRectCornerTypeBottomRightAndTopRightAndBottomLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
        }
            break;
        case YWViewRectCornerTypeAllCorners:
        {
            corners = UIRectCornerAllCorners;
        }
            break;
            
        default:
            break;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(conner, conner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

// 设置全部圆角
- (void)setAllCorner:(CGFloat) conner{
    self.layer.cornerRadius = conner;
    self.layer.masksToBounds = YES;
}

#pragma mark - 给UIView添加点击事件
- (void)addTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

#pragma mark - 返回view所在控制器
- (UIViewController *)getCurrentViewController
{
    UIResponder *nextVC = self.nextResponder ;
    
    while (nextVC) {
        if ([nextVC isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextVC ;
        }
        nextVC = nextVC.nextResponder ;
    }
    return nil ;
}

#pragma mark - 动画
//摇摆动画
- (void)yw_shakeViewWithRepeatCount:(CGFloat)repeatCount duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses{
    // 创建关键帧动画类
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    // 设置每个关键帧的值对象的数组
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)],
                     [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    // 设置是否自动翻转
    shake.autoreverses = autoreverses;
    // 设置重复次数
    shake.repeatCount = repeatCount;
    // 设置间隔时间
    shake.duration = duration;
    // 添加动画
    [self.layer addAnimation:shake
                      forKey:@"Shake"];
}


#pragma mark - UIView的类初始化
+ (UIView *)viewWithFrame:(CGRect)frame  backgroundColor:(UIColor *)backgroundColor{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    return view;
}

+ (UIView *)viewWithBackgroundColor:(UIColor *)backgroundColor;{
   return  [self viewWithFrame:CGRectZero backgroundColor:backgroundColor];
}

@end
