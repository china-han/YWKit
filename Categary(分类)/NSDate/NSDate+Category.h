//
//  NSDate+Category.h
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

typedef NS_ENUM(NSInteger,compareTimeType) {
    compareTimeTypeYear,  //比较相差几年
    compareTimeTypeMonth,  //比较相差几个月
    compareTimeTypeDay,  //比较相差几天
    compareTimeTypeHours,  //比较相差几小时
    compareTimeTypeMinutes,  //比较相差几分钟
    compareTimeTypeSecond,  //比较相差几秒
};

@interface NSDate (Category)
/**
 *  生成yyyy-MM-dd HH:mm:ss zzz格式的字符串
 *
 *  @return 输入的日期字符串形如“2015-01-27 09:47:51 GMT+8”
 */
- (NSString *) stringFormDate;

/**
 *  生成自定义格式的日期字符串
 *
 *  @param format 自定义格式如@"yyyyMMdd"
 *
 *  @return 输入的日期字符串形如“20150127”
 */
- (NSString *) stringFormDateWithFormat:(NSString *)format;

/**
 *  将日期字符串转化为NSDate对象
 *
 *  @param string 需要转化的日期字符串
 *  @param format 与日期字符串相匹配的格式
 *
 *  @return 生成的日期对象
 */
+ (NSDate *) dateFromString:(NSString *)dateString withFormat:(NSString *)format;

/**
 *  给定一个时间，给一个数，正数是后n个月以，负数是前n个月
 *
 *  @param date  给定的日期对象
 *  @param month 返回日期的月份差
 *
 *  @return 返回n个月之前或之后对应的日期
 */
+ (NSDate *) getPreviousOrLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month;

/**
 *  获取n个月之前或之后的某天所在的月的第一天
 *
 *  @param date  给定的日期
 *  @param month 月份差值
 *
 *  @return n个月之前或之后的某天所在的月的第一天的日期对象
 */
+ (NSDate *) theFirstDayFromDate:(NSDate *)date withMonth:(NSInteger)month;

/**
 *  获取n个月之前或之后的某天所在的月的最后一天
 *
 *  @param date  给定的日期
 *  @param month 月份差值
 *
 *  @return n个月之前或之后的某天所在的月的最后一天的日期对象
 */
+ (NSDate *) theLastDayFromDate:(NSDate *)date withMonth:(NSInteger)month;

/**
 *  判断当前时间是否是晚上
 *
 *  @param aDate 给定的时间
 *
 *  @return 下午6点到晚上24点，上午0点至6点返回YES
 */
+ (BOOL)isNight:(NSDate *)aDate;

/**
 *  获取星期几
 *
 *  @return 返回日期字符串形如@“Tuesday January 27, 2015”
 */
- (NSString *)getWeekDay;


// 当前日期的相对日期
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// 比较日期
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isInFuture;
- (BOOL) isInPast;
+ (NSString *)timeDifferenceInSeconds:(NSInteger)seconds; //将秒数转成时间差（xx天xx小时xx分xx秒）

// 日期角色
//是否是工作日
- (BOOL) isTypicallyWorkday;
//是否是周末
- (BOOL) isTypicallyWeekend;


// 调整日期
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// 检索区间
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger) distanceInDaysToDate:(NSDate *)anotherDate;

// 分解日期
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;
//星期几
@property (readonly) NSString *yw_weekDay;
//PRC 中国 返回1，2，3，4，5，6，7 其中周日为1
@property (nonatomic, readonly) NSInteger weekdayPRC;
//1-7号为第1个7天，8-14号为第2个7天...） 当月的第几个七天 相当于当月第几个周，但是天数为准
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
//当月第几个周 不以天数为准，如：当月1号是周日，那2号就是当月第二个周
@property (nonatomic, readonly) NSInteger weekOfMonth;
//当年第几个周。和weekOfMonth差不多
@property (nonatomic, readonly) NSInteger weekOfYear;
//暂未深究，暂时看了返的是年份
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
//刻钟
@property (nonatomic, readonly) NSInteger quarter;

/**
 确定每个月是否为闰月
 */
@property (nonatomic, readonly) BOOL isLeapMonth;

/**
 确定是否为闰年
 */
@property (nonatomic, readonly) BOOL isLeapYear;

/**
 *  是否为在相同的周
 */
- (BOOL) yw_isSameWeekWithAnotherDate: (NSDate *)anotherDate;

/**
 //获取当年最后一个月，就是12月
 @return 时间
 */
- (NSDate *)finalMonth;

/**
 //获取当年最后一个月，就是12月
 
 @param format 时间格式
 @return 时间字符串
 */
- (NSString *)finalMonthWithFormat:(NSString *)format;

/**
 比较两个时间差距
 
 @param beginDate 开始时间
 @param lastDate 截止时间
 @param compareType 比较差距类型（如相差几个月，几天）
 @return 返回相差数据
 */
+ (NSInteger )compareMonthWithBeginTime:(NSDate *)beginDate  lastTime:(NSDate *)lastDate compareType:(compareTimeType)compareType;

/**
 比较两个时间差距
 
 @param startDateStr 开始时间
 @param finalDateStr 截止时间
 @param format 时间类型
 @param compareType 比较差距类型（如相差几个月，几天）
 @return 返回相差数据
 */
+ (NSInteger )compareMonthWithStartTime:(NSString *)startDateStr  finalTime:(NSString *)finalDateStr forrmat:(NSString *)format compareType:(compareTimeType)compareType;

/**
 时间字符串格式转换
 
 @param timeString 要转换的时间字符串
 @param timeFormat 要转换的时间字符串格式
 @param format 要转换的时间字符串输出格式
 @return 转换后的字符串
 */
+ (NSString *)stringChangeFormDateWithTimeString:(NSString *)timeString withTimeFormat:(NSString *)timeFormat  Format:(NSString *)format;


@end
