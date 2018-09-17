//
//  YWKit_OC.h
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



/************************************   NSDictionary     ********/
@interface NSDictionary (NSDictionaryCategory)
/*从任意key取出value*/
- (NSString *)customObjectForKey:(NSString *)key;
/*根据value取key*/
- (NSString *)keyForValue:(NSString *)value;

/** 字典是否为空 */
+ (BOOL)isBlankDictionary:(NSDictionary *)dic;
- (BOOL)isBlank;
@end


/************************************   NSArray     ********/
@interface NSArray (NSArrayCategory)
/*检索数组中包涵某个字符串的对象，组成新的数组*/
+(NSArray *)replaceArray:(NSArray *)dataArray withString:(NSString *)searchString;
/*将一个数组按个数subSize分组拆分*/
+(NSArray *)splitArray: (NSArray *)array withSubSize:(int)subSize;
/** 数组是否为空 */
+ (BOOL)isBlankArr:(NSArray *)arr;
- (BOOL)isBlank;
@end





/************************************   NSMutableDictionary     ********/
/**
 *  可变字典分类
 */
@interface NSMutableDictionary (NSMutableDictionaryCategory)

/**
 创建一个自带pageSize的可变字典
 
 @param pageSize 默认为0
 @return NSMutableDictionary
 */
+(instancetype)dictionaryAndPageSize:(NSUInteger)pageSize;
@end


