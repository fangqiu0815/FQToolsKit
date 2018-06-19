//
//  FQDBModel.h
//  FQDBManageDemo
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"
#define PrimaryKey  @"primary key"

#define primaryId   @"pk"

@interface FQDBModel : NSObject
/** 主键 id */
@property (nonatomic, assign) int  pk;
/** 列名 */
@property (retain, readonly, nonatomic) NSMutableArray  *columeNames;
/** 列类型 */
@property (retain, readonly, nonatomic) NSMutableArray  *columeTypes;

/**
 *  获取该类的所有属性
 */
+ (NSDictionary *)fq_getPropertys;

/** 获取所有属性，包括主键 */
+ (NSDictionary *)fq_getAllProperties;

/** 数据库中是否存在表 */
+ (BOOL)fq_isExistInTable;

/** 表中的字段*/
+ (NSArray *)fq_getColumns;

/** 保存或更新
 * 如果不存在主键，保存，
 * 有主键，则更新
 */
- (BOOL)fq_saveOrUpdate;
/** 保存或更新
 * 如果根据特定的列数据可以获取记录，则更新，
 * 没有记录，则保存
 */
- (BOOL)fq_saveOrUpdateByColumnName:(NSString*)columnName AndColumnValue:(NSString*)columnValue;
/** 保存单个数据 */
- (BOOL)fq_save;
/** 批量保存数据 */
+ (BOOL)fq_saveObjects:(NSArray *)array;
/** 更新单个数据 */
- (BOOL)fq_update;
/** 批量更新数据*/
+ (BOOL)fq_updateObjects:(NSArray *)array;
/** 删除单个数据 */
- (BOOL)fq_deleteObject;
/** 批量删除数据 */
+ (BOOL)fq_deleteObjects:(NSArray *)array;
/** 通过条件删除数据 */
+ (BOOL)fq_deleteObjectsByCriteria:(NSString *)criteria;
/** 通过条件删除 (多参数）--2 */
+ (BOOL)fq_deleteObjectsWithFormat:(NSString *)format, ...;
/** 清空表 */
+ (BOOL)fq_clearTable;

/** 查询全部数据 */
+ (NSArray *)fq_findAll;

/** 通过主键查询 */
+ (instancetype)fq_findByPK:(int)inPk;
/** 条件查找某条数据 */
+ (instancetype)fq_findFirstWithFormat:(NSString *)format, ...;

/** 查找某条数据 */
+ (instancetype)fq_findFirstByCriteria:(NSString *)criteria;

+ (NSArray *)fq_findWithFormat:(NSString *)format, ...;

/** 通过条件查找数据
 * 这样可以进行分页查询 @" WHERE pk > 5 limit 10"
 */
+ (NSArray *)fq_findByCriteria:(NSString *)criteria;
/**
 * 创建表
 * 如果已经创建，返回YES
 */
+ (BOOL)fq_createTable;

#pragma mark - must be override method
/** 如果子类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写
 */
+ (NSArray *)fq_transients;


@end
