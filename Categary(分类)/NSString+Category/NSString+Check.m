//
//  NSString+Check.m
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)

#pragma mark - ***** 验证身份证号（15位或18位数字）【最全的身份证校验，带校验位】
+ (BOOL)yw_regularIsIdCardNumberQualified:(NSString *)idCardNumberStr
{
    idCardNumberStr = [idCardNumberStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length = 0;
    if (!idCardNumberStr)
    {
        return NO;
    }
    else
    {
        length = idCardNumberStr.length;
        if (length != 15 && length !=18)
        {
            return NO;
        }
    }
    /*! 省份代码 */
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [idCardNumberStr substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray)
    {
        if ([areaCode isEqualToString:valueStart2])
        {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag)
    {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    NSInteger year = 0;
    switch (length)
    {
        case 15:
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                return YES;
            }
            else
            {
                return NO;
            }
            break;
        case 18:
            
            year = [idCardNumberStr substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0))
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            else
            {
                /*! 测试出生日期的合法性 */
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumberStr
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, idCardNumberStr.length)];
            
            if(numberofMatch > 0)
            {
                NSInteger S = ([idCardNumberStr substringWithRange:NSMakeRange(0,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([idCardNumberStr substringWithRange:NSMakeRange(1,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([idCardNumberStr substringWithRange:NSMakeRange(2,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([idCardNumberStr substringWithRange:NSMakeRange(3,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([idCardNumberStr substringWithRange:NSMakeRange(4,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([idCardNumberStr substringWithRange:NSMakeRange(5,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([idCardNumberStr substringWithRange:NSMakeRange(6,1)].intValue + [idCardNumberStr substringWithRange:NSMakeRange(16,1)].intValue) *2 + [idCardNumberStr substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumberStr substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCardNumberStr substringWithRange:NSMakeRange(9,1)].intValue *3;
                NSInteger Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                /*! 判断校验位 */
                M = [JYM substringWithRange:NSMakeRange(Y,1)];
                if ([M isEqualToString:[idCardNumberStr substringWithRange:NSMakeRange(17,1)]])
                {
                    /*! 检测ID的校验位 */
                    return YES;
                }
                else
                {
                    return NO;
                }
                
            }
            else
            {
                return NO;
            }
            break;
        default:
            return NO;
            break;
    }
}
#pragma mark -- 正则判断电话号码
- (BOOL)isPhoneNumber
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = Regex_Mobilephone;
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

#pragma mark - ***** 是否为电话号码【复杂写法】
+ (BOOL)yw_regularIsMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,172,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = Regex_Mobilephone;
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    NSString *CM = Regex_CMCCPhone;
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,172,175,176,185,186
     */
    NSString *CU = Regex_CUCCPhone;
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = Regex_CTCCPhone;
    /**
     * 座机号码
     */
    NSString *ZJ = Regex_Telephone;
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestZJ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ZJ];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)
        || ([regextestZJ evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - ***** 判断具体是哪个运营商的手机号
+ (NSString *)yw_getPhoneNumType:(NSString *)phoneNum
{
    return [NSString textStr:phoneNum conformToPredicate:Regex_CMCCPhone]? @"中国移动": ([NSString textStr:phoneNum conformToPredicate:Regex_CUCCPhone]? @"中国联通":([NSString textStr:phoneNum conformToPredicate:Regex_CTCCPhone]? @"中国电信": @"未知号码"));
}

#pragma mark -- 正则判断邮箱
- (BOOL)isEmail {
    return [NSString isEmail:self];
}

+ (BOOL)isEmail:(NSString *_Nonnull)email {
    NSString *emailRegEx = Regex_Email;
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[email lowercaseString]];
}

#pragma mark - ***** 检测用户输入密码是否以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
+ (BOOL)yw_regularIsPasswordQualified:(NSString *)passwordStr
{
    NSString *passWordRegex = @"^[a-zA-Z]\\w.{5,17}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passwordStr];
}

#pragma mark - ***** 验证IP地址（15位或18位数字）
+ (BOOL)yw_regularIsIPAddress:(NSString *)iPAddressStr
{
    NSString *pattern = @"((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:iPAddressStr options:0 range:NSMakeRange(0, iPAddressStr.length)];
    return results.count > 0;
}

/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
#pragma mark - ***** 银行卡号有效性问题Luhn算法
+ (BOOL)yw_regularIsBankCardlNumCheck:(NSString *)bankCardlNum
{
    NSString *lastNum = [[bankCardlNum substringFromIndex:(bankCardlNum.length-1)] copy];//取出最后一位
    NSString *forwardNum = [[bankCardlNum substringToIndex:(bankCardlNum.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++)
    {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--)
    {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++)
    {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2)
        {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }
        else
        {//奇数位
            if (num * 2 < 9)
            {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }
            else
            {
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0)?YES:NO;
}

// 判断正则
+ (BOOL)textStr:(NSString *)text conformToPredicate:(NSString *)predicateStr{
    
    NSPredicate * firstpred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateStr];
    if ([firstpred evaluateWithObject:text]){
        return YES;
    }else{
        return NO;
    }
}



@end
