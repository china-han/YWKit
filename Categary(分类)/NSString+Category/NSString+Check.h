//
//  NSString+Check.h
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Regex_Null          @"/s"                       // 空字符
#define Regex_NotNull       @"/S"                       // 非空字符

#define Regex_Sign          @"^\\p{Punct}$"             // 符号字符
#define Regex_AllSign       @"^\\p{Punct}+$"            // 全部符号

#define Regex_Number        @"^\\d{1}$"                 // 数字字符
#define Regex_AllNumber     @"^\\d+$"                   // 全部数字

#define Regex_Char          @"^[A-Za-z]$"               // 字母字符
#define Regex_AllChar       @"^[A-Za-z]+$"              // 全部字母

#define Regex_China         @"^[\\u4E00-\\u9FA5]$"      // 中文字符
#define Regex_AllChina      @"^[\\u4E00-\\u9FA5]+$"     // 全部字符

// 用户账号
#define Regex_UserName      @"^[A-Za-z0-9]{6,32}$"

// 用户密码
#define Regex_Password      @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$"

// 用户卡号
#define Regex_CardNO        @"^[A-Za-z0-9]+$"

// 港澳能行证
#define Regex_GanAoCard     @"^(H|M)\\d{10}$"

// 台胞证
#define Regex_TaiWanCard    @"^\\d{10}(\\([A-Za-z]{1}\\))|(\\(\\d{2}\\))$"

// 身份证号
#define Regex_18IDCard      @"^[1-9]\\d{5}[1-9]\\d{3}((0[1-9])|(1[0-2]))((0[1-9])|([1-2]\\d)|3[0-1])\\d{3}(\\d|X|x)$"
#define Regex_15IDCard      @"^[1-9]\\d{5}[1-9]\\d((0[1-9])|(1[0-2]))((0[1-9])|([1-2]\\d)|3[0-1])\\d{3}$"
#define Regex_IDCard        @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)*"

// 网址地址
#define Regex_Url           @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"

// 电子邮件
#define Regex_Email         @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

// 座机号码
#define Regex_Telephone     @"(\\(\\d{3,4}\\)|\\d{3,4}-|\\s)?\\d{6,14}"

// 手机号码
#define Regex_Mobilephone   @"^((17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$"

// 移动号码段（134、135、136、137、138、139、147、150、151、152、157、158、159、182、183、187、188）
/** 带+86 */
//#define Regex_CMCCPhone     @"^((\\+86)|(\\+86 )|(86)|(86 ))?1(3[4-9]|47|5[012789]|8[2378])\\d{8}$"
/** 不带+86 */
#define Regex_CMCCPhone     @"(^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$"

// 联通号码段（130、131、132、155、156、185、186）
/** 带+86 */
//#define Regex_CUCCPhone     @"^((\\+86)|(\\+86 )|(86)|(86 ))?1(3[0-2]|5[56]|8[56])\\d{8}$"
/** 不带+86 */
#define Regex_CUCCPhone       @"(^1(3[0-2]|4[5]|5[56]|701256||8[56])\\d{8}$"


// 电信号码段（133、153、180、189）
/** 带+86 */
//#define Regex_CTCCPhone     @"^((\\+86)|(\\+86 )|(86)|(86 ))?1(33|53|8[09])\\d{8}$"
/** 不带+86 */
#define Regex_CTCCPhone       @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$"

// 验证码 (是否是6位)
#define Regex_MobilephoneCoede   @"^\\d{6}$"

@interface NSString (Check)

/*!
 *  验证身份证号（15位或18位数字）【最全的身份证校验，带校验位】
 *  @param idCardNumberStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)yw_regularIsIdCardNumberQualified:(NSString *)idCardNumberStr;

/**
 *  判断手机号是否合法
 *
 *
 *  @return 判断手机号是否合法
 */
- (BOOL)isPhoneNumber;

/*!
 *  是否为电话号码【复杂写法】
 *
 *  @param mobileNum 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)yw_regularIsMobileNumber:(NSString *)mobileNum;

/*!
 *  判断具体是哪个运营商的手机号
 *
 *  @param phoneNum 传入需要检测的字符串
 *
 *  @return 返回：中国移动、中国联通、中国电信、未知
 */
+ (NSString *)yw_getPhoneNumType:(NSString *)phoneNum;

/**
 *  邮箱校验
 */
- (BOOL)isEmail;

/**
 *  邮箱校验
 */
+ (BOOL)isEmail:(NSString * _Nonnull)email;

/*!
 *  检测用户输入密码是否以字母开头，长度在6-18之间，只能包含字符、数字和下划线。
 *
 *  @param passwordStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)yw_regularIsPasswordQualified:(NSString *)passwordStr;

/*!
 *  验证IP地址（15位或18位数字）
 *  @param iPAddressStr 传入需要检测的字符串
 *
 *  @return 返回检测结果 是或者不是
 */
+ (BOOL)yw_regularIsIPAddress:(NSString *)iPAddressStr;

/*!
 *  银行卡的有效性验证
 */
+ (BOOL)yw_regularIsBankCardlNumCheck:(NSString *)bankCardlNum;

/**
 判断正则

 @param text 要校验的字符串
 @param predicateStr 正则表达式
 @return 校验结果
 */
+ (BOOL)textStr:(NSString *)text conformToPredicate:(NSString *)predicateStr;

/*！
 *  正则表达式简单说明
 *  语法：
 .       匹配除换行符以外的任意字符
 \w      匹配字母或数字或下划线或汉字
 \s      匹配任意的空白符
 \d      匹配数字
 \b      匹配单词的开始或结束
 ^       匹配字符串的开始
 $       匹配字符串的结束
 *       重复零次或更多次
 +       重复一次或更多次
 ?       重复零次或一次
 {n}     重复n次
 {n,}     重复n次或更多次
 {n,m}     重复n到m次
 \W      匹配任意不是字母，数字，下划线，汉字的字符
 \S      匹配任意不是空白符的字符
 \D      匹配任意非数字的字符
 \B      匹配不是单词开头或结束的位置
 [^x]     匹配除了x以外的任意字符
 [^aeiou]匹配除了aeiou这几个字母以外的任意字符
 *?      重复任意次，但尽可能少重复
 +?      重复1次或更多次，但尽可能少重复
 ??      重复0次或1次，但尽可能少重复
 {n,m}?     重复n到m次，但尽可能少重复
 {n,}?     重复n次以上，但尽可能少重复
 \a      报警字符(打印它的效果是电脑嘀一声)
 \b      通常是单词分界位置，但如果在字符类里使用代表退格
 \t      制表符，Tab
 \r      回车
 \v      竖向制表符
 \f      换页符
 \n      换行符
 \e      Escape
 \0nn     ASCII代码中八进制代码为nn的字符
 \xnn     ASCII代码中十六进制代码为nn的字符
 \unnnn     Unicode代码中十六进制代码为nnnn的字符
 \cN     ASCII控制字符。比如\cC代表Ctrl+C
 \A      字符串开头(类似^，但不受处理多行选项的影响)
 \Z      字符串结尾或行尾(不受处理多行选项的影响)
 \z      字符串结尾(类似$，但不受处理多行选项的影响)
 \G      当前搜索的开头
 \p{name}     Unicode中命名为name的字符类，例如\p{IsGreek}
 (?>exp)     贪婪子表达式
 (?<x>-<y>exp)     平衡组
 (?im-nsx:exp)     在子表达式exp中改变处理选项
 (?im-nsx)       为表达式后面的部分改变处理选项
 (?(exp)yes|no)     把exp当作零宽正向先行断言，如果在这个位置能匹配，使用yes作为此组的表达式；否则使用no
 (?(exp)yes)     同上，只是使用空表达式作为no
 (?(name)yes|no) 如果命名为name的组捕获到了内容，使用yes作为表达式；否则使用no
 (?(name)yes)     同上，只是使用空表达式作为no
 
 捕获
 (exp)               匹配exp,并捕获文本到自动命名的组里
 (?<name>exp)        匹配exp,并捕获文本到名称为name的组里，也可以写成(?'name'exp)
 (?:exp)             匹配exp,不捕获匹配的文本，也不给此分组分配组号
 零宽断言
 (?=exp)             匹配exp前面的位置
 (?<=exp)            匹配exp后面的位置
 (?!exp)             匹配后面跟的不是exp的位置
 (?<!exp)            匹配前面不是exp的位置
 注释
 (?#comment)         这种类型的分组不对正则表达式的处理产生任何影响，用于提供注释让人阅读
 
 *  表达式：\(?0\d{2}[) -]?\d{8}
 *  这个表达式可以匹配几种格式的电话号码，像(010)88886666，或022-22334455，或02912345678等。
 *  我们对它进行一些分析吧：
 *  首先是一个转义字符\(,它能出现0次或1次(?),然后是一个0，后面跟着2个数字(\d{2})，然后是)或-或空格中的一个，它出现1次或不出现(?)，
 *  最后是8个数字(\d{8})
 */

@end
