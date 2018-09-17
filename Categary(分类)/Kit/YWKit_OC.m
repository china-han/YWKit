//
//  YWKit_OC.m
//  Tyre
//
//  Created by hyw on 2018/9/12.
//  Copyright © 2018年 hyw. All rights reserved.
//

@implementation NSDictionary (NSDictionaryCategory)
- (NSString *)customObjectForKey:(NSString *)key
{
    NSString *keyStr = [self objectForKey:key];
    
    BOOL fiv = [keyStr isKindOfClass:[NSNull class]] ? YES : NO ;
    BOOL one = [keyStr isEqualToString:@"<null>"] ? YES : NO ;
    BOOL two = [keyStr isEqualToString:@"(NULL)"] ? YES : NO ;
    BOOL thr = [keyStr isEqualToString:@"(nil)"] ? YES : NO ;
    BOOL fou = [keyStr isEqualToString:@"<nil>"] ? YES : NO ;
    BOOL six = !keyStr  ?   YES    :   NO ;
    BOOL sev = ![keyStr isKindOfClass:[NSString class]] ? YES : NO ;
    
    if (one || two || thr || fou || fiv || six || sev ) {
        return @"";
    }
    return keyStr ;
}

-(NSString *)keyForValue:(NSString *)value{
    
    for (NSInteger i = 0; i<self.allKeys.count; i++) {
        if ([self.allValues[i] isEqualToString:value]) {
            return self.allKeys[i];
        }
    }
    return nil;
}

/**
 *  输出字典
 */

// NSLog输出
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" = "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

// 输出台po命令输出
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" = "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

/**
 
 判断字典为空
 
 
 
 @param  dic 数组
 
 @return YES 空 NO
 
 */
+ (BOOL)isBlankDictionary:(NSDictionary *)dic {
    
    if (!dic) {
        
        return YES;
        
    }
    
    if ([dic isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if (!dic.count) {
        
        return YES;
        
    }
    
    if (dic == nil) {
        
        return YES;
        
    }
    
    if (dic == NULL) {
        
        return YES;
        
    }
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        
        return YES;
        
    }
    
    return NO;
    
}

- (BOOL)isBlank{
   return  [NSDictionary isBlankDictionary:self];
}

@end

#pragma mark ----- NSArray
@implementation NSArray (NSArrayCategory)
/*检索数组中包涵某个字符串的对象，组成新的数组*/
+(NSArray *)replaceArray:(NSArray *)dataArray withString:(NSString *)searchString {
    
    NSString *string = [NSString stringWithFormat:@"SELF LIKE[c] '%@*'", searchString] ;
    NSPredicate *pred = [NSPredicate predicateWithFormat:string ] ;
    NSArray *newArray = [dataArray filteredArrayUsingPredicate:pred] ;
    return newArray;
}
/*将一个数组按个数subSize分组拆分*/
+(NSArray *)splitArray: (NSArray *)array withSubSize:(int)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        int index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    return [arr copy];
}

/**
 *  输出数组
 */

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *string = [NSMutableString string];
    
    // 开头有个[
    [string appendString:@"[\n"];
    
    // 遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendFormat:@"\t%@,\n", obj];
    }];
    
    // 结尾有个]
    [string appendString:@"]"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}

/**
 
 判断数组为空
 
 
 
 @param arr 数组
 
 @return YES 空 NO
 
 */

+ (BOOL)isBlankArr:(NSArray *)arr {
    
    if (!arr) {
        
        return YES;
        
    }
    
    if ([arr isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if (!arr.count) {
        
        return YES;
        
    }
    
    if (arr == nil) {
        
        return YES;
        
    }
    
    if (arr == NULL) {
        
        return YES;
        
    }
    
    if (![arr isKindOfClass:[NSArray class]]) {
        
        return YES;
        
    }
    
    return NO;
    
}

- (BOOL)isBlank{
  return  [NSArray isBlankArr:self];
}

@end

@implementation NSMutableDictionary (NSMutableDictionaryCategory)
+(instancetype)dictionaryAndPageSize:(NSUInteger)pageSize{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:NSNumberWithInteger(pageSize) forKey:@"pageSize"];
    return dict;
}
@end

