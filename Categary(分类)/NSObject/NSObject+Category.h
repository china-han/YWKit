//
//  NSObject+Category.h
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TimerActionBlock)(NSUInteger times);
typedef void (^TimerCompleteBlock)(void);

@interface NSObject (Category)
//关联对象
- (id)associatedBlockForKey:(const char *)key;
- (void)setAssociatedBlock:(id)object forkey:(const char *)key;

//定时器
- (void)stopTimer;
- (void)startTimerDuration:(NSTimeInterval)duration times:(NSInteger)times
                    action:(TimerActionBlock)durationBlock
                  complete:(TimerCompleteBlock)completeBlock;

//通知
- (void)registerNotification:(NSString *)name object:(id)object selector:(SEL)selector;
- (void)removeNotification:(NSString *)name;
- (void)removeAllNotifications;

- (void)postNotification:(NSString *)name;
- (void)postNotification:(NSString *)name object:(NSObject *)object;


//键盘
- (void)observeKeyboard;
- (void)unObserveKeyboard;
- (void)keyboardWillShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;
- (void)keyboardDidShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;
- (void)keyboardWillHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;
- (void)keyboardDidHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve;

/**
 *  `简单`弹出系统自带 确认窗口(两个按钮:确定和取消)或消息通知窗口(一个按钮:取消功能); 兼容iOS7及以上版本,
 iOS7无需另外实现UIAlertViewDelegate的代理方法, 该Catogory会处理..
 *
 *  @param title            提示窗口标题
 *  @param message          提示消息
 *  @param confirmTitle     确定按钮标题 (设置为nil, 即为仅包含1个取消按钮的消息通知窗口)
 *  @param cancelTitle      取消按钮标题 (nil 则为`取消`)
 *  @param confirmHandler   点击确定按钮执行的block, 不需要则设置nil
 *  @param cancelHandler    点击取消按钮执行的block, 不需要则设置nil
 */
- (void)presentConfirmViewWithTitle:(NSString *)title
                            message:(NSString *)message
                 confirmButtonTitle:(NSString *)confirmTitle
                  cancelButtonTitle:(NSString *)cancelTitle
                     confirmHandler:(void (^)(void))confirmHandler
                      cancelHandler:(void (^)(void))cancelHandler;

/**
 *  弹出系统自带 确认窗口(两个按钮:确定和取消)或消息通知窗口(一个按钮:取消功能); 兼容iOS7及以上版本,
 iOS7无需另外实现UIAlertViewDelegate的代理方法, 该Catogory会处理..
 *
 *  @param controller     呈现AlertView的Controller(nil则为:KeyWindow的rootController)
 *  @param title          提示窗口标题
 *  @param message        提示消息
 *  @param confirmTitle   确定按钮标题 (设置为nil, 即为仅包含1个取消按钮的消息通知窗口)
 *  @param cancelTitle    取消按钮标题 (nil 则为`取消`)
 *  @param confirmHandler 点击确定按钮执行的block, 不需要则设置nil
 *  @param cancelHandler  点击取消按钮执行的block, 不需要则设置nil
 */
- (void)presentConfirmViewInController:(id)controller
                          confirmTitle:(NSString *)title
                               message:( NSString *)message
                    confirmButtonTitle:(NSString *)confirmTitle
                     cancelButtonTitle:(NSString *)cancelTitle
                        confirmHandler:(void (^)(void))confirmHandler
                         cancelHandler:(void (^)(void))cancelHandler;

/**
 *  `简单`弹出系统自带 选择表单; 兼容iOS7及以上版本; iOS7无需另外实现UIActionSheetDelegate的代理方法, 该Catogory会处理..
 *
 *  @param title              标题(nil则无标题)
 *  @param cancelTitle        取消按钮标题(nil则为:取消)
 *  @param twoOtherTitleArray 另外两个选择按钮的标题, NSString数组(按先后顺序展示)
 *  @param firstBTHandler  第一个选择按钮触发的Handler Block
 */
- (void)presentSelectSheetWithTitle:(NSString *)title
                  cancelButtonTitle:(NSString *)cancelTitle
          twoOtherButtonTitlesArray:(NSArray *)twoOtherTitleArray
                     firstBTHandler:(void (^)(void))firstBTHandler
                    secondBTHandler:(void (^)(void))firstBTHandler;

/**
 *  弹出系统自带 选择表单, 需指定presentingController; 兼容iOS7及以上版本; iOS7无需另外实现UIActionSheetDelegate的代理方法, 该Catogory会处理..
 *
 *  @param controller         呈现ActionSheet的Controller(nil则为:KeyWindow的rootController)
 *  @param title              标题(nil则无标题)
 *  @param cancelTitle        取消按钮标题(nil则为:取消)
 *  @param twoOtherTitleArray 另外两个选择按钮的标题, NSString数组(按先后顺序展示)
 *  @param firstBTHandler  第一个选择按钮触发的Handler Block
 *  @param secondBTHandler 第二个选择按钮触发的Handler Block
 */
- (void)presentSelectSheetByController:(id)controller
                            sheetTitle:(NSString *)title
                     cancelButtonTitle:(NSString *)cancelTitle
             twoOtherButtonTitlesArray:(NSArray *)twoOtherTitleArray
                        firstBTHandler:(void (^)(void))firstBTHandler
                       secondBTHandler:(void (^)(void))secondBTHandler;


/**
 弹出输入框

 @param title title
 @param text 输入框text
 @param placeholderString 输入框placeholderString
 @param vc  控制器
 @param success 确定回调
 @param cancleBlock 取消回调
 */
-(void)showInputAlertWithTitle:(NSString *)title textFieldText:(NSString *)text   placeholderString:(NSString *)placeholderString byController:(UIViewController *)vc success:(void (^)(NSString *inputString))success cancle:(void (^)(void))cancleBlock;


/**
 展示警告框

 @param title title
 @param msg 信息
 @param vc 控制器
 @param dismissTime 多久自动消失
 */
-(void)showAlertWithTitle:(NSString *)title Message:(NSString *)msg byController:(UIViewController *)vc after:(CGFloat)dismissTime;

/**
 弹出系统自带 选择表单, 需指定presentingController; 兼容iOS7及以上版本; iOS7无需另外实现UIActionSheetDelegate的代理方法, 该Catogory会处理..

 @param title title
 @param msg 信息
 @param vc 控制器
 @param titles 标题数组
 @param block 按钮调用方法
 */
-(void)showActionSheetWithTitle:(NSString *)title Message:(NSString *)msg byController:(UIViewController *)vc  titles:(NSArray *)titles action:(void(^)(NSInteger index))block;


/**
 第一个控制器

 @return UIViewController
 */
- (UIViewController *)topViewController ;

// 版本更新
-(void)checkVersionForVC:(UIViewController *)vc;

//快速生成model属性的方法
- (void)nslogPropertyWithDic:(id)obj;

//工资换算
-(NSString *)makeMoneyWithStart:(NSString *)start end:(NSString*)end;

/**
 是否为空 主要校验NSString，NSData，NSArray，NSMutableArray，NSDictionary是否为空

 @return 校验结果
 */
- (BOOL)isNotEmpty;
/*!
 *  替换两个方法
 *
 *  @param originalSelector 原始方法
 *  @param swizzledSelector 替换的方法
 */
- (void)swizzlingOriginalSelector:(SEL)originalSelector
                    swizzledSelector:(SEL)swizzledSelector;


//图片放大
+(void)showImage:(UIImageView*)imgView;
//图片放大
+(void)showImageWithImage:(UIImage *)img;
@end
