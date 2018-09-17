//
//  NSString+Category.h
//  Tyre
//
//  Created by hyw on 2018/1/19.
//  Copyright © 2018年 hyw. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface NSString (Category)

/**
 获取文字 size，根据字体大小
 
 @param maxSize 最大的 size
 @param fontSize 字体大小
 @return 文字 size
 */
- (CGSize)yw_stringGetSizeWithMaxSize:(CGSize)maxSize
                             fontSize:(CGFloat)fontSize;

/**
 获取文字 size，根据字体
 
 @param maxSize 最大的 size
 @param font 字体
 @return 文字 size
 */
- (CGSize)yw_stringGetSizeWithMaxSize:(CGSize)maxSize
                                 font:(UIFont *)font;

/**
 计算一个字符串的 height，【限定 font、width】
 
 @param font font
 @param width width
 @return 字符串的 height
 */
- (CGFloat)yw_stringGetHeightWithFont:(UIFont* )font width:(CGFloat)width;

/**
 计算一个字符串的 width，【限定 font、height】
 
 @param font font
 @param height height
 @return 字符串的 width
 */
- (CGFloat)yw_stringGetWidthWithFont:(UIFont *)font height:(CGFloat)height;

//解析URL中的参数对
- (NSDictionary *)getURLParameters;

/**
 *  MD5
 */
- (NSString * _Nullable)MD5;
- (NSString * _Nullable)HMD5;

/**
 * SHA1
 */
- (NSString * _Nullable)SHA1;

/**
 *  创建一个SHA256字符串
 */
- (NSString *)yw_stringSHA256;

/**
 *  创建一个SHA512字符串
 */
- (NSString *)yw_stringSHA512;

/**
 * Base64加密
 */
+ (NSString * _Nonnull)encodeToBase64:(NSString * _Nonnull)string;

/**
 * Base64加密
 */
- (NSString * _Nonnull)encodeToBase64;

/**
 * Base64解密
 */
+ (NSString * _Nonnull)decodeBase64:(NSString * _Nonnull)string;

/**
 * Base64解密
 */
- (NSString * _Nonnull)decodeBase64;



/**
 *  判段字符串是否为空
 *
 *  @return 字符串是否为空
 */
- (BOOL)isNotEmpty;

/**
 *  获取字符串字节数
 *
 *
 *  @return 字符串字节数
 */
- (int)getByteNum;

/**
 *  是否包含空格
 *
 *
 *  @return 是否包含空格
 */
- (BOOL)hasSpace;

/**
 从身份证号码里提取 生日，默认：@"yyyy-MM-dd"
 
 @return 生日
 */
- (NSDate *)yw_stringExtractBirthdayFromIDNumber;

/**
 从身份证号码里提取 性别
 
 @return 性别
 */
- (NSString *)yw_stringExtractGenderFromIDNumber;

/**
 从身份证号码里提取 年龄
 
 @return 年龄
 */
- (NSUInteger)yw_stringExtractAgeFromIDNumber;

/**
 *  检索字符串替换
 *
 *  @param rexStr 要检索的部分，替换前的字符串
 *  @param str    替换后的字符串
 *
 *  @return 替换后的整体
 */
-(NSString*)replaceRexString:(NSString*)rexStr withString:(NSString*)str;

@end
