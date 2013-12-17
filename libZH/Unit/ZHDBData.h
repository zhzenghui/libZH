//
//  ZHDBData.h
//  Dyrs
//
//  Created by mbp  on 13-9-9.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FMDatabase.h"

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }


#define ImageType_Dept                  0
#define ImageType_Case                  1
#define ImageType_Designer_BigAvart     2
#define ImageType_AccessType            3
#define ImageType_Access                4
#define ImageType_Designer_Avart        5


#define Member_Manage     0
#define Member_Designer     1
#define Member_DesignerVIP     2

    

@interface ZHDBData : NSObject
{
    FMDatabase *db;

}

+ (ZHDBData *)share;

- (void)insertDictToDB:(NSDictionary *)dict  tableName:(Tables_name)tableName;
- (void)updataDictToDB:(NSDictionary *)userDict  tableName:(Tables_name)tableName;
- (void)deleteDictToDB:(NSDictionary *)dict  tableName:(Tables_name)tableName;



/*  获得 所有需要更新的文件，  即 状态为3 的image */
- (NSMutableArray *)getAllUpdateImage;
- (NSMutableArray *)getAllUpdateContent;
- (NSMutableArray *)getAllUpdatePicture;



@end
