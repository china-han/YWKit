//
//  UIButton+BanCombo.h
//  GYJob_ Personal
//
//  Created by yzy on 2018/4/18.
//  Copyright © 2018年 BKSX CN. All rights reserved.
//

#import <UIKit/UIKit.h>
#define defaultInterval 0.5//默认时间间隔
@interface UIButton (BanCombo)
@property(nonatomic,assign)NSTimeInterval timeInterval;//用这个给重复点击加间隔
@property(nonatomic,assign)BOOL isIgnoreEvent;//YES不允许点击NO允许点击
@end
