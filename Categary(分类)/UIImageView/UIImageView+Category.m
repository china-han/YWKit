//
//  UIImageView+Category.m
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "UIImageView+Category.h"

@implementation UIImageView (Category)
#define kCoverViewTag           1234
#define kImageViewTag           1235
#define kAnimationDuration      0.3f
#pragma mark ---- 点击图片放大
- (void)hiddenView
{
    UIView *coverView = (UIView *)[[self window] viewWithTag:kCoverViewTag];
    [coverView removeFromSuperview];
}

- (void)hiddenViewAnimation
{
    UIImageView *imageView = (UIImageView *)[[self window] viewWithTag:kImageViewTag];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration]; //动画时长
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    imageView.frame = rect;
    [UIView commitAnimations];
    [self performSelector:@selector(hiddenView) withObject:nil afterDelay:kAnimationDuration];
    
}

//自动按原UIImageView等比例调整目标rect
- (CGRect)autoFitFrame
{
    //调整为固定宽，高等比例动态变化
    float width = [UIScreen mainScreen].bounds.size.width;
    float targeHeight = (width*self.frame.size.height)/self.frame.size.width;
    UIView *coverView = (UIView *)[[self window] viewWithTag:kCoverViewTag];
    CGRect targeRect = CGRectMake(coverView.frame.size.width/2 - width/2, coverView.frame.size.height/2 - targeHeight/2, width, targeHeight);
    return targeRect;
}

- (void)imageTap
{
    UIView *coverView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.tag = kCoverViewTag;
    UITapGestureRecognizer *hiddenViewGecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenViewAnimation)];
    [coverView addGestureRecognizer:hiddenViewGecognizer];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.tag = kImageViewTag;
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = self.contentMode;
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    imageView.frame = rect;
    
    [coverView addSubview:imageView];
    [[self window] addSubview:coverView];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    imageView.frame = [self autoFitFrame];
    [UIView commitAnimations];
    
}

- (void)addDetailShow
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [self addGestureRecognizer:tapGestureRecognizer];
}



+ (NSMutableArray *)animatedWithGifData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    NSMutableArray *images = [NSMutableArray array];
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
        [images addObject:animatedImage];
    }
    else {
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
    }
    CFRelease(source);
    return images;
}


@end
