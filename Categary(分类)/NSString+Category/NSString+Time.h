//
//  NSString+Time.h
//  Tyre
//
//  Created by hyw on 2018/9/11.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YWKit_FormatString_YMD       @"yyyy-MM-dd"
#define YWKit_FormatString_YMDHM     @"yyyy-MM-dd HH:mm"
#define YWKit_FormatString_YMDHMS    @"yyyy-MM-dd HH:mm:ss"
#define YWKit_FormatString_YMDEHMS   @"yyyy-MM-dd, EEE, HH:mm:ss"
#define YWKit_FormatString_YM        @"yyyy-MM"
#define YWKit_FormatString_MDHM      @"MM-dd HH:mm"

#define YWKit_FormatString_YMD2      @"yyyy/MM/dd"
#define YWKit_FormatString_YMDHM2    @"yyyy/MM/dd HH:mm"
#define YWKit_FormatString_YMDHMS2   @"yyyy/MM/dd HH:mm:ss"
#define YWKit_FormatString_YMDEHMS2  @"yyyy/MM/dd, EEE, HH:mm:ss"
#define YWKit_FormatString_YM2       @"yyyy/MM"

#define YWKit_FormatString_YMD3      @"yyyy年MM月dd日"

#define YWKit_FormatString_Y         @"yyyy"
#define YWKit_FormatString_M         @"MM"
#define YWKit_FormatString_D         @"dd"
#define YWKit_FormatString_HM        @"HH:mm"
#define YWKit_FormatString_HMS       @"HH:mm:ss"

@interface NSString (Time)
#pragma mark - 获取系统当前日期和时间
/**
 *  获取系统当前日期和时间【YYYY-MM-dd HH:mm:ss】
 *
 *  @return 系统当前日期和时间
 */
+ (NSString *)yw_time_getSystermCurrentDateYMDHMS;

/**
 获取系统当前日期和时间 【自定义 formatString】
 
 @param formatString formatString
 @return 系统当前日期和时间
 */
+ (NSString *)yw_time_getSystermCurrentDateWithFormatString:(NSString *)formatString;

#pragma mark - 时间戳转换时间
#pragma mark 时间戳转换时间【YYYY-MM-dd HH:mm:ss】
/**
 *  时间戳转换时间【YYYY-MM-dd HH:mm:ss】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd HH:mm:ss】
 */
+ (NSString *)yw_time_getDateWithTimeStampYMDHMS:(NSString *)timeStamp;

#pragma mark 时间戳转换【YYYY-MM-dd】
/**
 *  时间戳转换时间【YYYY-MM-dd】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd】
 */
+ (NSString *)yw_time_getDateWithTimeStampYMD:(NSString *)timeStamp;

#pragma mark 时间戳转换【HH:mm】
/**
 *  时间戳转换时间【HH:mm】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【HH:mm】
 */
+ (NSString *)yw_time_getDateWithTimeStampHM:(NSString *)timeStamp;

/**
 时间戳转换时间【自定义 formatString】
 
 @param timeStamp 时间戳
 @param formatString formatString
 @return 时间
 */
+ (NSString *)yw_time_getDateWithTimeStamp:(NSString *)timeStamp
                              formatString:(NSString *)formatString;

#pragma mark - 当前时间转换成时间戳
/**
 *  当前时间【YYYY-MM-dd HH:mm:ss】转换成时间戳【10位数，如：1492672164】
 *
 *  @return 时间戳【10位数，如：1492672164】
 */
+ (NSString *)yw_time_getCurrentDateTransformTimeStampYMDHMS;

#pragma mark 根据日期提取当前 星期几【返回 周一...周日】
/*!
 *  根据日期提取当前 星期几【返回 周一...周日】
 *
 *  @param date 需要提取的日期
 *
 *  @return 返回 周一...周日
 */
+ (NSString *)yw_time_getWeekdayWithDate:(NSDate *)date;

#pragma mark 计算 指定日期 与 当前时间 的时间差
/**
 计算 指定日期 与 当前时间 的时间差
 
 @param date 指定日期
 @return 时间差
 */
+ (NSString *)yw_time_getIntervalSinceNowWithDate:(NSDate *)date;

/**
 判断当前时间是否在 fromHour 和 toHour 之间。如。fromHour=8，toHour=23时。即为推断当前时间是否在8:00-23:00之间【一般应用程序设置这一组的存在，比如夜间模式，如果你。从8：00-23：00。在这个当前的时间是如何推断出期间。主要的困难在于如何使用NSDate生成8：00时间和23：00时间。然后用当前时间，也许有足够的时间，以使控制。】
 
 @param fromHour 开始时间
 @param toHour 结束时间
 @return YES，NO
 */
- (BOOL)yw_time_isBetweenFromHour:(NSInteger)fromHour
                           toHour:(NSInteger)toHour;

/*!
 * 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比較）
 *
 * @param hour 如hour为“8”。就是上午8:00（本地时间）
 */
- (NSDate *)yw_time_getCustomDateWithHour:(NSInteger)hour;

/*!
 *  计算上报时间差: 几分钟前，几天前，传入时间戳，自动解析，注意：具体情况在 NSDate+YWKit.h 中也有详细说明
 *
 *  @return 计算上报时间差: 几分钟前，几天前
 */
+ (NSString *)yw_time_formatWithTimeStamp:(NSString *)timeStamp;

/**
 字符串时间转 NSDate
 
 @param formatString 转换格式
 @return NSDate
 */
- (NSDate *)yw_time_dateWithFormatString:(NSString *)formatString;

/**
 字符串转换时间对象
 
 @param formatString 转换格式
 @param timezoneName 时区标识符
 @return 时间对象结果
 */
- (NSDate *)yw_time_dateWithFormat:(NSString *)formatString
                      timezoneName:(NSString *)timezoneName;

- (NSDate *)yw_time_dateWithFormat:(NSString *)formatString
                         dateStyle:(NSDateFormatterStyle)dateStyle;
@end
