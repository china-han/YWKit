//
//  NSObject+Category.m
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "NSObject+Category.h"

#define SysVersionBiggerThaniOS7 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0

#define RunBlock_Safe(block) {\
if (block) {\
block();\
}\
}\

//appstore ID
#define APPSTOREID @""

static CGRect oldframe; //旧图大小

@implementation NSObject (Category)
//关联对象
- (id)associatedBlockForKey:(const char *)key{
    return objc_getAssociatedObject(self, key);
}
- (void)setAssociatedBlock:(id)object forkey:(const char *)key{
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


//定时器
- (void)stopTimer{
    NSTimer *timer = objc_getAssociatedObject(self, "timerKey");
    if (timer) {
        [timer invalidate];
    }
    
    objc_setAssociatedObject(self, "timerKey", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, "timesKey", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, "timerActionBlockKey", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, "timerCompleteBlockKey", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)startTimerDuration:(NSTimeInterval)duration times:(NSInteger)times
                    action:(TimerActionBlock)actionBlock
                  complete:(TimerCompleteBlock)completeBlock{
    [self stopTimer];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:duration
                                             target:self
                                           selector:@selector(timerRepeatAction:)
                                           userInfo:nil
                                            repeats:YES];
    NSNumber *timers = [NSNumber numberWithUnsignedInteger:times];
    
    objc_setAssociatedObject(self, "timerKey", timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, "timesKey", timers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, "timerActionBlockKey", actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, "timerCompleteBlockKey", completeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerRepeatAction:(NSTimer *)timer{
    NSNumber *timesNumber = objc_getAssociatedObject(self, "timesKey");
    NSUInteger timers = [timesNumber unsignedIntegerValue];
    
    timers--;
    if (timers>0) {
        timesNumber = [NSNumber numberWithUnsignedInteger:timers];
        objc_setAssociatedObject(self, "timesKey", timesNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        TimerActionBlock actionBlock = objc_getAssociatedObject(self, "timerActionBlockKey");
        if (actionBlock) {
            actionBlock(timers);
        }
    } else {
        
        TimerCompleteBlock completeBlock = objc_getAssociatedObject(self, "timerCompleteBlockKey");
        if (completeBlock) {
            completeBlock();
        }
        [self stopTimer];
    }
}


//通知
- (void)registerNotification:(NSString *)name object:(id)object selector:(SEL)selector{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:name object:object];
}
- (void)removeNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}
- (void)removeAllNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)postNotification:(NSString *)name{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil];
}
- (void)postNotification:(NSString *)name object:(NSObject *)object{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}


//键盘
- (void)observeKeyboard{
    NSNotificationCenter *keyboardNoti = [NSNotificationCenter defaultCenter];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardDidShowNotification object:nil];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    [keyboardNoti addObserver:self selector:@selector(handleKeyboardNotification:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)unObserveKeyboard{
    NSNotificationCenter *keyboardNoti = [NSNotificationCenter defaultCenter];
    [keyboardNoti removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [keyboardNoti removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [keyboardNoti removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [keyboardNoti removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

//处理键盘通知
- (void)handleKeyboardNotification:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    
    //    CGRect beginFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSUInteger curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        [self keyboardWillShow:endFrame duration:duration curve:curve];
    }else if ([notification.name isEqualToString:UIKeyboardDidShowNotification]) {
        [self keyboardDidShow:endFrame duration:duration curve:curve];
    }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        [self keyboardWillHide:endFrame duration:duration curve:curve];
    }else if ([notification.name isEqualToString:UIKeyboardDidHideNotification]) {
        [self keyboardDidHide:endFrame duration:duration curve:curve];
    }
}

- (void)keyboardWillShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}
- (void)keyboardDidShow:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}
- (void)keyboardWillHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}
- (void)keyboardDidHide:(CGRect)frame duration:(NSTimeInterval)duration curve:(NSUInteger)curve{
}


/**
 *  返回一个view存在于视图阶层上的controller(如无特殊情况, 一般返回最顶层root Controller), 用于呈现AlertViewController, 兼容iOS7以上版本
 (主要是为了兼容iOS9..)
 */
- (UIViewController *)controllerInViewHierarchy {
    UIViewController *mostTopController = [UIApplication sharedApplication].keyWindow.rootViewController;
    // presentedViewController: The view controller that is presented by this view controller, one of its ancestors in the view controller hierarchy
    while (mostTopController.presentedViewController) {
        mostTopController = mostTopController.presentedViewController;
    }
    
    return mostTopController;
}

#pragma mark - Public
#pragma mark ConfirmView

- (void)presentConfirmViewWithTitle:(NSString *)title
                            message:( NSString *)message
                 confirmButtonTitle:(NSString *)confirmTitle
                  cancelButtonTitle:(NSString *)cancelTitle
                     confirmHandler:(void (^)(void))confirmHandler
                      cancelHandler:(void (^)(void))cancelHandler {
    
    [self presentConfirmViewInController:nil
                            confirmTitle:title
                                 message:message
                      confirmButtonTitle:confirmTitle
                       cancelButtonTitle:cancelTitle
                          confirmHandler:confirmHandler
                           cancelHandler:cancelHandler];
}

- (void)presentConfirmViewInController:(id)controller
                          confirmTitle:(NSString *)title
                               message:( NSString *)message
                    confirmButtonTitle:(NSString *)confirmTitle
                     cancelButtonTitle:(NSString *)cancelTitle
                        confirmHandler:(void (^)(void))confirmHandler
                         cancelHandler:(void (^)(void))cancelHandler {
    
    NSString *cancelTitleStr = cancelTitle?:@"取消";
    
    UIViewController *viewController = controller?:[self controllerInViewHierarchy];
    
    if (SysVersionBiggerThaniOS7) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        // Create the action.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitleStr style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            RunBlock_Safe(cancelHandler);
        }];
        // Add the action.
        [alertController addAction:cancelAction];
        
        if (confirmTitle) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                RunBlock_Safe(confirmHandler)
            }];
            [alertController addAction:otherAction];
        }
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}



#pragma mark SelectActionSheet

- (void)presentSelectSheetWithTitle:(NSString *)title
                  cancelButtonTitle:(NSString *)cancelTitle
          twoOtherButtonTitlesArray:(NSArray *)twoOtherTitleArray
                     firstBTHandler:(void (^)(void))firstBTHandler
                    secondBTHandler:(void (^)(void))secondBTHandler {
    
    [self presentSelectSheetByController:nil
                              sheetTitle:title
                       cancelButtonTitle:cancelTitle
               twoOtherButtonTitlesArray:twoOtherTitleArray
                          firstBTHandler:firstBTHandler
                         secondBTHandler:secondBTHandler];
}

- (void)presentSelectSheetByController:(id)controller
                            sheetTitle:(NSString *)title
                     cancelButtonTitle:(NSString *)cancelTitle
             twoOtherButtonTitlesArray:(NSArray *)twoOtherTitleArray
                        firstBTHandler:(void (^)(void))firstBTHandler
                       secondBTHandler:(void (^)(void))secondBTHandler {
    
    NSString *cancelTitleStr = cancelTitle?:@"取消";
    
    UIViewController *viewController = controller?:[self controllerInViewHierarchy];
    
    if (SysVersionBiggerThaniOS7) {// iOS8
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // Create the action.
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitleStr style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *firstOtherAction = [UIAlertAction actionWithTitle:twoOtherTitleArray[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            RunBlock_Safe(firstBTHandler);
        }];
        
        UIAlertAction *secondOtherAction = [UIAlertAction actionWithTitle:twoOtherTitleArray[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            RunBlock_Safe(secondBTHandler);
        }];
        
        // Add the action.
        [alertController addAction:cancelAction];
        [alertController addAction:firstOtherAction];
        [alertController addAction:secondOtherAction];
        
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}

// 展示输入框
-(void)showInputAlertWithTitle:(NSString *)title textFieldText:(NSString *)text  placeholderString:(NSString *)placeholderString byController:(UIViewController *)vc success:(void (^)(NSString *inputString))success cancle:(void (^)(void))cancleBlock {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    //增加取消按钮；
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancleBlock) {
            cancleBlock();
        }
    }];
#warning  修改字体颜色,属于私有Api 慎用
    [cancelAction setValue:UIColorFromRGB(0x333333) forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    //增加确定按钮；
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        if (success) {
            success(userNameTextField.text);
        }
        
    }]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = placeholderString;
        textField.text = text;
    }];
    
    [vc presentViewController:alertController animated:true completion:nil];
    
}
// 展示警告框
-(void)showAlertWithTitle:(NSString *)title Message:(NSString *)msg byController:(UIViewController *)vc after:(CGFloat)dismissTime{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [vc presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dismissTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

-(void)showActionSheetWithTitle:(NSString *)title Message:(NSString *)msg byController:(UIViewController *)vc  titles:(NSArray *)titles action:(void(^)(NSInteger index))block{
    UIAlertController  *alertController  = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    for (NSInteger i=0; i<titles.count; i++) {
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block(i);
        }];
        [alertController addAction:albumAction];
    }
    
    [alertController addAction:cancleAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

#pragma mark ---  第一个控制器
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark --- 版本更新
- (void)checkVersionForVC:(UIViewController *)vc
{
    NSString *newVersion;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",APPSTOREID]];//这个URL地址是该app在iTunes connect里面的相关配置信息。其中id是该app在app store唯一的ID编号。
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"通过appStore获取的数据信息：%@",jsonResponseString);
    
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    
    //    解析json数据
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *array = json[@"results"];
    
    for (NSDictionary *dic in array) {
        newVersion = [dic valueForKey:@"version"];
    }
    
    NSLog(@"通过appStore获取的版本号是：%@",newVersion);
    
    //获取本地软件的版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString *msg = [NSString stringWithFormat:@"你当前的版本是V%@，发现新版本V%@，请下载新版本？",localVersion,newVersion];
    
    //对比发现的新版本和本地的版本
    if ([newVersion floatValue] > [localVersion floatValue])
    {
        
        [vc presentConfirmViewWithTitle:@"升级提示" message:msg confirmButtonTitle:@"现在升级" cancelButtonTitle:@"下次再说" confirmHandler:^{
            
            if (iOS10Later) {
                NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/yi-ka-tongbic-ban/id%@?l=en&mt=8",APPSTOREID]];
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                } else {
                    // Fallback on earlier versions
                }
            }else{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/yi-ka-tongbic-ban/id%@?l=en&mt=8",APPSTOREID]]];//这里写的URL地址是该app在app store里面的下载链接地址，其中ID是该app在app store对应的唯一的ID编号。
            }
        } cancelHandler:^{
        }];
    }
}


//快速生成model属性的方法
- (void)nslogPropertyWithDic:(id)obj{
    
#if DEBUG
    
    NSDictionary *dic = [NSDictionary new];
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = [(NSDictionary *)obj mutableCopy];
        dic = tempDic;
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *tempArr = [(NSArray *)obj mutableCopy];
        if (tempArr.count > 0) {
            dic = tempArr[0];
        } else {
            NSLog(@"无法解析为model属性，因为数组为空");
            return;
        }
    } else {
        NSLog(@"无法解析为model属性，因为并非数组或字典");
        return;
    }
    
    if (dic.count == 0) {
        NSLog(@"无法解析为model属性，因为该字典为空");
        return;
    }
    
    
    NSMutableString *strM = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        NSString *className = NSStringFromClass([obj class]) ;
        NSLog(@"className:%@/n", className);
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"] |
                  [className isEqualToString:@"__NSArray0"] |
                  [className isEqualToString:@"__NSArrayI"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSDictionary *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic, assign) BOOL   %@;\n",key];
        }else if ([className isEqualToString:@"NSDecimalNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        else if ([className isEqualToString:@"NSNull"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }else if ([className isEqualToString:@"__NSArrayM"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSMutableArray *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        
    }];
    NSLog(@"\n%@\n",strM);
    
#endif
    
}

+(NSString *)makeMoneyWithStart:(NSString *)start end:(NSString*)end{
    NSString * moneyString ;
    if (start && ![start isNotEmpty]) {
        CGFloat a = [[NSString stringWithFormat:@"%.1f",[start integerValue]/1000.0] floatValue];
        BOOL aIsZhengShu = a == (NSInteger)([start integerValue]/1000);
        if (end && ![end isNotEmpty]) {
            CGFloat b = [[NSString stringWithFormat:@"%.1f",[end integerValue]/1000.0] floatValue];
            BOOL bIsZhengShu = b == (NSInteger)([end integerValue]/1000);
            if (aIsZhengShu && bIsZhengShu) {
                moneyString = [NSString stringWithFormat:@"%.1fk-%.1fk",[start integerValue]/1000.0,[end integerValue]/1000.0];
            }else if (aIsZhengShu && !bIsZhengShu){
                moneyString = [NSString stringWithFormat:@"%.1fk-%.1fk",[start integerValue]/1000.0,[end integerValue]/1000.0];
            }else if (!aIsZhengShu && bIsZhengShu){
                moneyString = [NSString stringWithFormat:@"%.1fk-%.1fk",[start integerValue]/1000.0,[end integerValue]/1000.0];
            }else if (!aIsZhengShu && !bIsZhengShu){
                moneyString = [NSString stringWithFormat:@"%.1fk-%.1fk",[start integerValue]/1000.0,[end integerValue]/1000.0];
            }
            
        }else{
            if (aIsZhengShu) {
                moneyString = [NSString stringWithFormat:@"%.1fk以上",[start integerValue]/1000.0];
            }else{
                moneyString = [NSString stringWithFormat:@"%.1fk以上",[start integerValue]/1000.0];
            }
            
        }
    }else{
        if (end && ![end isNotEmpty]) {
            CGFloat c = [[NSString stringWithFormat:@"%.1f",[end integerValue]/1000.0] floatValue];
            BOOL cIsZhengShu = c == (NSInteger)([end integerValue]/1000);
            if (cIsZhengShu) {
                moneyString = [NSString stringWithFormat:@"%.0fk",[end integerValue]/1000.0];
            }else{
                moneyString = [NSString stringWithFormat:@"%.1fk",[end integerValue]/1000.0];
            }
        }else{
            moneyString = @"0k";
        }
    }
    return moneyString;
    
}

//是否为空
- (BOOL)isNotEmpty
{
    if ([self isKindOfClass:[NSNull class]]) {
        return NO;
    }else if ([self isKindOfClass:[NSString class]]){
        return [(NSString *)self length]>0;
    }else if ([self isKindOfClass:[NSData class]]){
        return [(NSData *)self length] > 0;
    }else if ([self isKindOfClass:[NSArray class]]){
        return [(NSArray *)self count]>0;
    }else if ([self isKindOfClass:[NSMutableArray class]]){
        return [(NSMutableArray *)self count]>0;
    }else if ([self isKindOfClass:[NSDictionary class]]){
        return [(NSDictionary *)self count]>0;
    }
    return YES;
}
/*!
 *  替换两个方法
 *
 *  @param originalSelector 原始方法
 *  @param swizzledSelector 替换的方法
 */
- (void)swizzlingOriginalSelector:(SEL)originalSelector
                    swizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod)
    {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


+(void)showImageWithImage:(UIImage *)img{
    
    
    //UIImage *image=imgView.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    oldframe= CGRectMake(0, AutoSize(526), AutoSize(620), AutoSize(414));
    
    backgroundView.backgroundColor=[UIColor blackColor];
    
    backgroundView.alpha=0;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    
    imageView.image=img;
    
    imageView.tag=1;
    
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=CGRectMake(0,(kScreenHeight-img.size.height*kScreenWidth/img.size.width)/2, kScreenWidth, img.size.height*kScreenWidth/img.size.width);
        
        backgroundView.alpha=1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
+(void)showImage:(UIImageView *)imgView{
    
    
    UIImage *image=imgView.image;
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    oldframe=[imgView convertRect:imgView.bounds toView:window];
    
    
    //(origin = (x = -5.5, y = 263.5), size = (width = 310, height = 207))
    backgroundView.backgroundColor=[UIColor blackColor];
    
    backgroundView.alpha=0;
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    
    imageView.image=image;
    
    imageView.tag=1;
    
    [backgroundView addSubview:imageView];
    
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=CGRectMake(0,(kScreenHeight-image.size.height*kScreenWidth/image.size.width)/2, kScreenWidth, image.size.height*kScreenWidth/image.size.width);
        
        backgroundView.alpha=1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}
+(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame=oldframe;
        
        backgroundView.alpha=0;
        
    } completion:^(BOOL finished) {
        
        [backgroundView removeFromSuperview];
        
    }];
    
}
@end
