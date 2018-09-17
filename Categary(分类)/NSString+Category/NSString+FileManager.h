//
//  NSString+FileManager.h
//  Tyre
//
//  Created by hyw on 2018/9/11.
//  Copyright © 2018年 hyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FileManager)
/*! 获取软件沙盒路径 程序目录，不能存任何东西 */  
+ (nullable NSString *)ba_path_getApplicationSupportPath;

/*! 获取软件沙盒Documents路径 文档目录，需要ITUNES同步备份的数据存这里*/
+ (nullable NSString *)ba_path_getDocumentsPath;

/*! 获取软件沙盒cache路径 缓存目录，系统永远不会删除这里的文件，ITUNES会删除*/
+ (nullable NSString *)ba_path_getCachePath;

/*! 获取软件沙盒cachesDic路径 缓存目录，APP退出后，系统可能会删除这里的内容 */
+ (nullable NSString *)ba_path_getTemPath;

/*! 在软件沙盒指定的路径创建一个目录 */
+ (BOOL)ba_path_createDirectory:(nullable NSString *)newDirectory;

/*! 在软件沙盒指定的路径删除一个目录 */
+ (BOOL)ba_path_deleteFilesysItem:(nullable NSString*)strItem;

/*! 在软件沙盒路径移动一个目录到另一个目录中 */
+ (BOOL)ba_path_moveFilesysItem:(nullable NSString *)srcPath toPath:(nullable NSString *)dstPath;

/*! 在软件沙盒路径中查看有没有这个路径 */
+ (BOOL)ba_path_fileExist:(nullable NSString*)strPath;

/*! 在软件沙盒路径中获取指定userPath路径 */
- (nullable NSString *)ba_path_getUserInfoStorePath:(nullable NSString *)userPath;
@end
