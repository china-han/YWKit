//
//  NSString+Category.m
//  Tyre
//
//  Created by hyw on 2018/1/19.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Time.h"
@implementation NSString (Category)

#pragma mark - 文字大小
/**
 获取文字 size，根据字体大小
 
 @param maxSize 最大的 size
 @param fontSize 字体大小
 @return 文字 size
 */
- (CGSize)yw_stringGetSizeWithMaxSize:(CGSize)maxSize
                             fontSize:(CGFloat)fontSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

/**
 获取文字 size，根据字体
 
 @param maxSize 最大的 size
 @param font 字体
 @return 文字 size
 */
- (CGSize)yw_stringGetSizeWithMaxSize:(CGSize)maxSize
                                 font:(UIFont *)font
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (CGFloat)yw_stringGetHeightWithFont:(UIFont* )font
                                width:(CGFloat)width
{
    
    CGRect bounds = CGRectZero;
    bounds = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceilf(bounds.size.height);
}

- (CGFloat)yw_stringGetWidthWithFont:(UIFont *)font
                              height:(CGFloat)height
{
    CGRect bounds = CGRectZero;
    
    bounds = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return ceilf(bounds.size.width);
}

//解析URL中的参数对
- (NSDictionary *)getURLParameters
{
    NSMutableString *keyValues          = [[NSMutableString alloc] initWithString:self];
    NSMutableDictionary *keyValueDic    = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSRange searchRange = [keyValues rangeOfString:@"?"];
    [keyValues deleteCharactersInRange:NSMakeRange(0, searchRange.location + 1)];
    while (1)
    {
        NSRange wrapRange                   = [keyValues rangeOfString:@"&"];
        if (wrapRange.location != NSNotFound)
        {
            NSString *keyValue = [keyValues substringToIndex:wrapRange.location];
            [keyValues deleteCharactersInRange:NSMakeRange(0, keyValue.length + 1)];
            NSRange equalRange = [keyValue rangeOfString:@"="];
            if (equalRange.location != NSNotFound)
            {
                [keyValueDic setObject:[keyValue substringFromIndex:NSMaxRange(equalRange)]
                                forKey:[keyValue substringToIndex:equalRange.location]];
            }
            
        }
        else
        {
            NSRange equalRange = [keyValues rangeOfString:@"="];
            if (equalRange.location != NSNotFound)
            {
                [keyValueDic setObject:[keyValues substringFromIndex:NSMaxRange(equalRange)]
                                forKey:[keyValues substringToIndex:equalRange.location]];
            }
            break;
        }
    }
    
    keyValues = nil;
    NSDictionary *theDic = [NSDictionary dictionaryWithDictionary:keyValueDic];
    keyValueDic = nil;
    return theDic;
}

#pragma mark - 加密
- (NSString *_Nullable)MD5 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([self UTF8String],
           (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

- (NSString*)HMD5{
    if (![self isNotEmpty]) {
        return nil;
    }
    const char *value = [self UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (unsigned)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

- (NSString *_Nullable)SHA1 {
    if (self == nil || [self length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_SHA1_DIGEST_LENGTH], i;
    CC_SHA1([self UTF8String],
            (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for (i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

/* 创建一个SHA256字符串 */
- (NSString *)yw_stringSHA256
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA256_DIGEST_LENGTH], i;
    CC_SHA256([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA256_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

/* 创建一个SHA512字符串 */
- (NSString *)yw_stringSHA512
{
    if(self == nil || [self length] == 0)
        return nil;
    
    unsigned char digest[CC_SHA512_DIGEST_LENGTH], i;
    CC_SHA512([self UTF8String], (int)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    for(i=0;i<CC_SHA512_DIGEST_LENGTH;i++)
    {
        [ms appendFormat: @"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

+ (NSString *_Nonnull)encodeToBase64:(NSString *_Nonnull)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *_Nonnull)encodeToBase64 {
    return [NSString encodeToBase64:self];
}

+ (NSString *_Nonnull)decodeBase64:(NSString *_Nonnull)string {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *_Nonnull)decodeBase64 {
    return [NSString decodeBase64:self];
}

- (BOOL)isNotEmpty {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (int)getByteNum {
    int strlength = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
         i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}

#pragma mark -- 是否包含空格
- (BOOL)hasSpace{
    
    NSRange spaceRange = [self rangeOfString:@" "];
    if (spaceRange.location != NSNotFound) {
        
        return YES;
    }
    else {
        
        return NO;
    }
}

/**
 从身份证号码里提取 生日，默认：@"yyyy-MM-dd"
 
 @return 生日
 */
- (NSDate *)yw_stringExtractBirthdayFromIDNumber
{
    NSString *result = @"";
    NSDate *date;
    if (self.length == 15)
    {
        result = [NSString stringWithFormat:@"19%@", [self substringWithRange:NSMakeRange(6, 6)]];
    }
    else if (self.length == 18)
    {
        result = [self substringWithRange:NSMakeRange(6, 8)];
    }
    date = [result yw_time_dateWithFormat:@"yyyyMMdd" timezoneName:@"Asia/Shanghai"];
    return date;
}

/**
 从身份证号码里提取 性别
 
 @return 性别
 */
- (NSString *)yw_stringExtractGenderFromIDNumber
{
    if (![NSString yw_regularIsIdCardNumberQualified:self])
    {
        return nil;
    }
    
    if (self.length == 15)
    {
        return [[self substringFromIndex:14] intValue] % 2 > 0 ? @"男" : @"女";
    }
    else if (self.length == 18)
    {
        return [[self substringWithRange:NSMakeRange(16, 1)] intValue] % 2 > 0 ? @"男" : @"女";
    }
    
    return @"";
}

/**
 从身份证号码里提取 年龄
 
 @return 年龄
 */
- (NSUInteger)yw_stringExtractAgeFromIDNumber
{
    if (self.length != 15 && self.length != 18)
    {
        return 0;
    }
    
    NSDate *birthday;
    if (self.length == 15)
    {
        // FIRST GENERATION ID
        birthday = [[NSString stringWithFormat:@"19%@", [self substringWithRange:NSMakeRange(6, 6)]] yw_time_dateWithFormat:@"yyyyMMdd" timezoneName:@"Asia/Shanghai"];
    }
    else if (self.length == 18)
    {
        // SECOND GENERATION ID
        birthday = [[self substringWithRange:NSMakeRange(6, 8)] yw_time_dateWithFormat:@"yyyyMMdd" timezoneName:@"Asia/Shanghai"];
    }
    
    NSDateComponents *cpBirthday = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:birthday];
    NSDateComponents *cpToday = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:[NSDate date]];
    
    NSUInteger age = cpToday.year - cpBirthday.year - 1;
    if ((cpToday.month > cpBirthday.month) || (cpToday.month == cpBirthday.month && cpToday.day >= cpBirthday.day)) {
        age++;
    }
    
    return age;
}

//=================替换字符=======================

-(NSString*)replaceRexString:(NSString*)rexStr withString:(NSString*)str {
    return [self replaceRexString:rexStr withString:str withStratPoint:0];
}

- (NSString*)replaceRexString:(NSString*)rexStr withString:(NSString*)str withStratPoint:(NSInteger)point {
    NSString* retHtml = nil;
    NSError *error;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:rexStr options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:self options:0 range:NSMakeRange(point, [self length] - point)];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            if (NSNotFound != resultRange.location) {
                
                NSString *result = [self substringWithRange:resultRange];
                //                NSLog(@"result[%@]",result);
                if (![result isEqualToString:str]) {
                    retHtml = [self stringByReplacingOccurrencesOfString:result withString:str];
                    retHtml = [retHtml replaceRexString:rexStr withString:str withStratPoint:0];
                } else {
                    point = resultRange.location + resultRange.length;
                    retHtml = [self replaceRexString:rexStr withString:str withStratPoint:point];
                }
            }
        } else {
            retHtml = self;
        }
    }
    
    return retHtml;
    
}

@end


