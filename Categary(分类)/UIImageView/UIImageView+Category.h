//
//  UIImageView+Category.h
//  Tyre
//
//  Created by hyw on 2018/9/13.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Category)

/* 点击图片放大 */
- (void)addDetailShow;

+ (NSMutableArray *)animatedWithGifData:(NSData *)data ;

@end
