//
//  ZHDBData.m
//  Dyrs
//
//  Created by mbp  on 13-9-9.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ZHDBData.h"
#import "ZHDBControl.h"


ZHDBData *dbData;


@implementation ZHDBData

+ (ZHDBData *)share
{
    if (dbData == nil)
    {
        dbData = [[ZHDBData alloc] init];
    }
    
    return dbData;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
        if ([[ZHDBControl share] checkDB]) {            
            NSString *dbPath = nil;
            if (KisDyrs) {
                dbPath = [KDocumentDirectory stringByAppendingPathComponent:@"dyrs.db"];
            }
            else {
                dbPath = [KDocumentDirectory stringByAppendingPathComponent:@"haro.db"];
            }
            db = [[FMDatabase alloc]initWithPath:dbPath];
            
        }
    }
    return self;
}

- (void)dealloc
{
    
    if (![db open]) {
        return;
    }
    db = nil;
}


#pragma mark  命令执行

- (void)stringToDBSqlString:(NSString *)sqlString
{
    
    if (!sqlString) {
        return;
    }
    
    if ([db open]) {
        
        bool statue =  [db executeUpdate:
                        sqlString];
        if (statue) {
            
        }
        else {
            DLog(@"statue:%i error: %@", statue, sqlString);
        }
        
    }
    else {
        DLog(@"db Not  open");
    }
}

- (void)dictToDB:(NSDictionary *)dict sqlString:(NSString *)sqlString
{
    if (!sqlString) {
        return;
    }
    
    if ([db open]) {

        bool statue =  [db executeUpdate:
                        sqlString withParameterDictionary:dict];
        
        if (statue) {
        }
        else {
            DLog(@"statue:%i error: %@,  \n lasterror:%@", statue, sqlString, db.lastError);
        }
    }
}

#pragma mark - insert  update  delete

- (void)deleteDictToDB:(NSDictionary *)dict  tableName:(Tables_name)tableName
{
    NSString *sqlString = nil;
    
    switch (tableName) {
        case UserTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from user  \
                         WHERE user_id = :user_id"];
            break;
        }
        case ChannelTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Channel  \
                         WHERE user_id = :user_id"];
            break;
        }
        case Channel_viewTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Channel_View  \
                         WHERE user_id = :user_id"];
            break;
        }
        case DepartmentTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Department  \
                         WHERE dept_id = :dept_id"];
            break;
        }
        case ImagesTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Images  \
                         WHERE image_id = :image_id"];
            break;
        }
        case ValuesTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from values  \
                         WHERE id = :id"];
            break;
        }
        case MemberTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Member  \
                         WHERE member_id = :member_id"];
            break;
        }
        case CasesTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Cases  \
                         WHERE case_id = :case_id"];
            break;
        }
        case CategoryTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Category  \
                         WHERE id = :case_id"];
            break;
        }
        case AccessoriesTable:
        {
            sqlString = [NSString stringWithFormat:@"DELETE from Accessories  \
                         WHERE acces_id = :acces_id"];
            break;
        }
        default:
            break;
    }
    
    [self dictToDB:dict sqlString:sqlString];
    
    
}

- (void)updataDictToDB:(NSDictionary *)userDict  tableName:(Tables_name)tableName
{
    
    NSMutableString *sqlString = [NSMutableString string];
    
    
    
    switch (tableName) {
        case UserTable:
        {

            [sqlString appendString:@"update user set "];
            
            
            [sqlString appendFormat:@"name='%@',", [userDict objectForKey:@"name"]];
            [sqlString appendFormat:@"account='%@',", [userDict objectForKey:@"account"]];
            [sqlString appendFormat:@"version='%@',", [userDict objectForKey:@"version"]];
            [sqlString appendFormat:@"dept_id='%@'", [userDict objectForKey:@"dept_id"]];
            
            
            
            [sqlString appendFormat:@"WHERE user_id = %@", [userDict objectForKey:@"user_id"]];
            
            
            break;
        }
        case ChannelTable:
        {
            
            sqlString = [NSMutableString stringWithFormat:@"update Channel set \
                         channel_id=:channel_id, name=:name, array_order=:array_order,\
                         status=:status, create_time=:create_time \
                         \
                         WHERE user_id = :user_id;"];
            break;
        }
        case Channel_viewTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Channel_View set \
                         user_id=:user_id, channel_id=:channel_id \
                         \
                         WHERE user_id = :user_id;"];
            break;
        }
        case DepartmentTable:
        {
            [sqlString appendString:@"update Department set "];
            
            
            [sqlString appendFormat:@"name='%@',", [userDict objectForKey:@"name"]];
            [sqlString appendFormat:@"info='%@',", [userDict objectForKey:@"info"]];
            [sqlString appendFormat:@"shop_name='%@',", [userDict objectForKey:@"shop_name"]];
            [sqlString appendFormat:@"team_name='%@',", [userDict objectForKey:@"team_name"]];
            
            
            [sqlString appendFormat:@"status='%@',", [userDict objectForKey:@"status"]];
            [sqlString appendFormat:@"create_time='%@', ", [userDict objectForKey:@"create_time"]];
            [sqlString appendFormat:@"district_id='%@'", [userDict objectForKey:@"district_id"]];

            
            
            [sqlString appendFormat:@"WHERE dept_id = %@", [userDict objectForKey:@"dept_id"]];
            
            break;
        }
        case ImagesTable:
        {
            
            [sqlString appendString:@"update Images set "];
            
            
            [sqlString appendFormat:@"name='%@',", [userDict objectForKey:@"name"]];
            [sqlString appendFormat:@"object_type='%@',", [userDict objectForKey:@"object_type"]];
            [sqlString appendFormat:@"object_id='%@',", [userDict objectForKey:@"object_id"]];
            [sqlString appendFormat:@"url='%@',", [userDict objectForKey:@"url"]];
            
            [sqlString appendFormat:@"status='%@',", [userDict objectForKey:@"status"]];
            [sqlString appendFormat:@"create_time='%@'", [userDict objectForKey:@"create_time"]];
            
            
            
            [sqlString appendFormat:@"WHERE image_id = %@", [userDict objectForKey:@"image_id"]];
            
            break;
        }
        case ValuesTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update values set  \
                         id=:id, key_key=:key_key, key_value=:key_value, user_id=:user_id\
                         \
                         WHERE id = :id;"];
            
            break;
        }
        case MemberTable:
        {
            
            [sqlString appendString:@"update Member set "];
            
            
            [sqlString appendFormat:@"name='%@',", [userDict objectForKey:@"name"]];
            [sqlString appendFormat:@"infor='%@',", [userDict objectForKey:@"infor"]];
            [sqlString appendFormat:@"dept_id='%@',", [userDict objectForKey:@"dept_id"]];
            [sqlString appendFormat:@"type='%@',", [userDict objectForKey:@"type"]];
            
            [sqlString appendFormat:@"status='%@',", [userDict objectForKey:@"status"]];
            [sqlString appendFormat:@"create_time='%@'", [userDict objectForKey:@"create_time"]];
            
            
            
            [sqlString appendFormat:@"WHERE member_id = %@", [userDict objectForKey:@"member_id"]];
            
            
            
            break;
        }
        case CasesTable:
        {
            
            [sqlString appendString:@"update Cases set "];
            
            
            [sqlString appendFormat:@"name='%@',", [userDict objectForKey:@"name"]];
            [sqlString appendFormat:@"info='%@',", [userDict objectForKey:@"info"]];
            [sqlString appendFormat:@"dept_id='%@',", [userDict objectForKey:@"dept_id"]];
            [sqlString appendFormat:@"house_type_id='%@',", [userDict objectForKey:@"house_type_id"]];
            [sqlString appendFormat:@"area_id='%@',", [userDict objectForKey:@"area_id"]];
            [sqlString appendFormat:@"style_id='%@',", [userDict objectForKey:@"style_id"]];
            [sqlString appendFormat:@"member_id='%@',", [userDict objectForKey:@"member_id"]];
            [sqlString appendFormat:@"price='%@',", [userDict objectForKey:@"price"]];
            
            [sqlString appendFormat:@"status='%@',", [userDict objectForKey:@"status"]];
            [sqlString appendFormat:@"create_time='%@'", [userDict objectForKey:@"create_time"]];
            
            
            
            [sqlString appendFormat:@"WHERE case_id = %@", [userDict objectForKey:@"case_id"]];
            
            
            break;
        }
        case CategoryTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Category set \
                         id=:id, name=:name, fid=:fid, level=:level, last=:last,\
                         type=:type, status=:status, create_time=:create_time \
                         WHERE id = :id;"];
            

            
            
            break;
        }
        case AccessoriesTable:
        {
//            sqlString = [NSString stringWithFormat:@"update Accessories set \
//                         id=:id, title=:title, info=:info, cate_id=:cate_id,  \
//                         status=:status, create_time=:create_time \
//                         \
//                         WHERE id = :id;"];
            
            [sqlString appendString:@"update Accessories set "];
            
//            [sqlString appendString:@"acces_id, "];
//            [sqlString appendString:@"title, "];
//            [sqlString appendString:@"infor, "];
//            [sqlString appendString:@"cate_id, "];
//            
//            [sqlString appendString:@"status,"];
//            [sqlString appendString:@"create_time"];


            [sqlString appendFormat:@"acces_id='%@',", [userDict objectForKey:@"acces_id"]];
            [sqlString appendFormat:@"title='%@',", [userDict objectForKey:@"title"]];
            [sqlString appendFormat:@"infor='%@',", [userDict objectForKey:@"infor"]];

            [sqlString appendFormat:@"cate_id='%@',", [userDict objectForKey:@"cate_id"]];
            [sqlString appendFormat:@"status='%@',", [userDict objectForKey:@"status"]];
            [sqlString appendFormat:@"create_time='%@'", [userDict objectForKey:@"create_time"]];

            
            [sqlString appendFormat:@"WHERE acces_id = %@", [userDict objectForKey:@"acces_id"]];
            
            break;
        }
        case UserHaroTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update User set \
                         user_id=:user_id, district_id=:district_id, namer=:namer, email=:email, password=:password, type=:type, create_time=:create_time,  statu=:status \
                         \
                         WHERE user_id = :user_id;"];
            break;
        }
        case ProductTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Product set \
                         product_id=:product_id, cate_id=:cate_id, series=:series, no=:no, color=:color, info_cne=:info_cn, info_en=:info_en,  price=:price, standard=:standard, wood=:wood, process=:process, deal=:deal,\
                         level=:level, array_order=:array_order, status=:status, create_time=:create_time\
                         \
                         WHERE product_id = :product_id;"];
            break;
        }
        case CategoryHaroTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Category set \
                         cate_id=:cate_id, name=:name, array_order=:array_order, status=:status, typed=:type, \
                         \
                         WHERE cate_id = :cate_id;"];
            break;
        }
        case PictureTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Picture set \
                         picture_id=:picture_id, product_id=:product_id, cate_id=:cate_id, type=:type, text=:text, name=:name \
                         \
                         WHERE picture_id = :picture_id;"];
            break;
        }
        case SceneTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Scene set \
                         scene_id=:scene_id, name=:name, status=:status, array_order=:array_order \
                         \
                         WHERE scene_id = :scene_id;"];
            break;
        }
        case LayerTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Layer set \
                         layer_id=:layer_id, scene_id=:scene_id, name=:name, level=:level, status=:status, array_order=:array_order \
                         \
                         WHERE layer_id = :layer_id;"];
            break;
        }
        case ContentTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Content set \
                         content_id=:content_id, product_id=:product_id, scene_id=:scene_id, layer_id=:layer_id, dir=:dir, name=:name, status=:status,  type=:type, array_order=:array_order \
                         \
                         WHERE content_id = :content_id;"];
            break;
        }
        case CustomTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Custom set \
                         custom_id=:custom_id, province_id=:province_id, dealer_id=:dealer_id, shop_id=:shop_id, user_id=:user_id, name=:name, tel=:tel,  address=:address, remark=:remark, create_time=:create_time, array_order=:array_order, time=:time, budget=:budget,\
                         status=:status \
                         \
                         WHERE custom_id = :custom_id;"];
            break;
        }
        case FavoriteTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"update Favorite set \
                         custom_id=:custom_id, cate_id=:cate_id, product_id=:product_id, create_time=:create_time \
                         \
                         WHERE custom_id = :custom_id;"];
            break;
        }
            
            
        default:
            break;
    }
    
    
    
    
    [self stringToDBSqlString:sqlString];
    
}

- (void)insertDictToDB:(NSDictionary *)dict  tableName:(Tables_name)tableName
{
    
    NSMutableString *sqlString = [NSMutableString string];
    
    switch (tableName) {
        case UserTable:
        {
            [sqlString appendString:@"INSERT INTO user ("];
            
            [sqlString appendString:@"user_id, "];
            [sqlString appendString:@"name, "];
            [sqlString appendString:@"account, "];
            [sqlString appendString:@"dept_id, "];
            [sqlString appendString:@"password"];
            
            
            [sqlString appendString:@")"];
            [sqlString appendString:@"VALUES ("];
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"user_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"name"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"account"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"dept_id"]];
            [sqlString appendFormat:@"'%@'", [dict objectForKey: @"password"]];
            
            
            [sqlString appendString:@")"];
            
            break;
        }
        case ChannelTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"INSERT INTO Channel (channel_id, name, array_order, status, create_time) VALUES (:channel_id, :name, :array_order, :status, :create_time)"];
            break;
        }
        case Channel_viewTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"INSERT INTO Channel_View (user_id, channel_id) VALUES (:user_id, :channel_id)"];
            break;
            
        }
        case DepartmentTable:
        {
            
            [sqlString appendString:@"INSERT INTO Department ("];
            
            [sqlString appendString:@"dept_id, "];
            [sqlString appendString:@"name, "];
            [sqlString appendString:@"info, "];
            [sqlString appendString:@"shop_name, "];
            [sqlString appendString:@"team_name,"];
            [sqlString appendString:@"district_id,"];

            [sqlString appendString:@"status,"];
            [sqlString appendString:@"create_time"];
            
            
            [sqlString appendString:@")"];
            [sqlString appendString:@"VALUES ("];
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"dept_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"name"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"info"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"shop_name"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"team_name"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"district_id"]];

            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"status"]];
            [sqlString appendFormat:@"'%@'", [dict objectForKey: @"create_time"]];
            
            
            [sqlString appendString:@")"];
            
            break;
            
        }
        case ImagesTable:
        {
            [sqlString appendString:@"INSERT INTO Images ("];
            
            [sqlString appendString:@"image_id, "];
            [sqlString appendString:@"name, "];
            [sqlString appendString:@"url, "];
            [sqlString appendString:@"object_type, "];
            [sqlString appendString:@"object_id,"];
            [sqlString appendString:@"status,"];
            [sqlString appendString:@"create_time"];
            
            
            [sqlString appendString:@")"];
            [sqlString appendString:@"VALUES ("];
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"image_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"name"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"url"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"object_type"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"object_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"status"]];
            [sqlString appendFormat:@"'%@'", [dict objectForKey: @"create_time"]];
            
            
            [sqlString appendString:@")"];
            
            break;
        }
        case ValuesTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"INSERT INTO values (id, key_key, key_value, user_id) VALUES (:id, :key_key, :key_value, :user_id)"];
            break;
        }
        case MemberTable:
        {
            [sqlString appendString:@"INSERT INTO Member ("];
            
            [sqlString appendString:@"member_id, "];
            [sqlString appendString:@"name, "];
            [sqlString appendString:@"infor, "];
            [sqlString appendString:@"dept_id, "];
            [sqlString appendString:@"type,"];
            
            [sqlString appendString:@"status,"];
            [sqlString appendString:@"create_time"];
            
            
            [sqlString appendString:@")"];
            [sqlString appendString:@"VALUES ("];
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"member_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"name"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"infor"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"dept_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"type"]];
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"status"]];
            [sqlString appendFormat:@"'%@'", [dict objectForKey: @"create_time"]];
            
            
            [sqlString appendString:@")"];
            break;
        }
        case CasesTable:
        {
            [sqlString appendString:@"INSERT INTO Cases ("];
            
            [sqlString appendString:@"case_id, "];
            [sqlString appendString:@"info, "];
            [sqlString appendString:@"name, "];
            [sqlString appendString:@"house_type_id, "];
            [sqlString appendString:@"area_id, "];
            [sqlString appendString:@"style_id, "];
            [sqlString appendString:@"city_id, "];
            [sqlString appendString:@"dept_id, "];
            [sqlString appendString:@"member_id, "];
            [sqlString appendString:@"price, "];
            
            [sqlString appendString:@"status,"];
            [sqlString appendString:@"create_time"];
            
            
            [sqlString appendString:@")"];
            [sqlString appendString:@"VALUES ("];
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"case_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"info"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"name"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"house_type_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"area_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"style_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"city_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"dept_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"member_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"price"]];
            
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"status"]];
            [sqlString appendFormat:@"'%@'", [dict objectForKey: @"create_time"]];
            
            
            [sqlString appendString:@")"];
            
            
            
            break;
        }
        case CategoryTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"INSERT INTO Category (cate_id, name, fid, level, last, status) VALUES (:cate_id, :name, :fid, :level, :last, :status)"];
            break;
        }
        case AccessoriesTable:
        {
            [sqlString appendString:@"INSERT INTO Accessories ("];
            
            [sqlString appendString:@"acces_id, "];
            [sqlString appendString:@"title, "];
            [sqlString appendString:@"infor, "];
            [sqlString appendString:@"cate_id, "];
            
            [sqlString appendString:@"status,"];
            [sqlString appendString:@"create_time"];
            
            
            [sqlString appendString:@")"];
            [sqlString appendString:@"VALUES ("];
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"acces_id"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"title"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"infor"]];
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"cate_id"]];
            
            
            [sqlString appendFormat:@"'%@',", [dict objectForKey: @"status"]];
            [sqlString appendFormat:@"'%@'", [dict objectForKey: @"create_time"]];
            
            
            [sqlString appendString:@")"];
            
            break;
            
        }
        case ProductTable:
        {
            
            [sqlString appendString:@"INSERT OR REPLACE INTO Product ("];
            [sqlString appendString:@"cate_id, \
             color, \
             info_cn, \
             info_en, \
             level, \
             no, \
             price, \
             product_id, \
             series, \
             standard\
             "];
            [sqlString appendString:@")  VALUES ("];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"cate_id"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"color"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"info_cn"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"info_en"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"level"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"no"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"price"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"product_id"]];
            [sqlString appendFormat:@"'%@', ", [dict objectForKey:@"series"]];
            [sqlString appendFormat:@"'%@'", [dict objectForKey:@"standard"]];
            [sqlString appendString:@") "];
            break;
        }
        case CategoryHaroTable:
        {
            [sqlString appendString: @"INSERT INTO Category (cate_id, name, array_order, status, type) VALUES ("];
            [ sqlString appendFormat:@"'%@','%@','%@','%@','%@')",[dict objectForKey:@"cate_id"], [dict objectForKey:@"name"], [dict objectForKey:@"array_order"], [dict objectForKey:@"status"], [dict objectForKey:@"type"]];
            break;
        }
        case PictureTable:
        {
            [sqlString appendString: @"INSERT OR REPLACE INTO Picture (picture_id, product_id, cate_id, type, dir) VALUES ("];
            [sqlString appendFormat:@"'%@','%@','%@','%@','%@')",[dict objectForKey:@"picture_id"], [dict objectForKey:@"product_id"], [dict objectForKey:@"cate_id"], [dict objectForKey:@"type"], [dict objectForKey:@"url"]];
            
            break;
        }
        case SceneTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"INSERT INTO Scene (scene_id, name, status, array_order) VALUES (:scene_id, :name, :status, :array_order)"];
            break;
        }
        case LayerTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"INSERT INTO layer (layer_id, scene_id, name, level, status, array_order) VALUES (:layer_id, :scene_id, :name, :level, :status, :array_order)"];
            break;
        }
            
        case ContentTable:
        {
            [sqlString appendString: @"INSERT OR REPLACE INTO Content (content_id, product_id, scene_id, layer_id, name) VALUES ("];
            [sqlString appendFormat:@"'%@','%@','%@','%@','%@')",[dict objectForKey:@"content_id"], [dict objectForKey:@"product_id"], [dict objectForKey:@"scene_id"], [dict objectForKey:@"layer_id"], [dict objectForKey:@"url"]];
            break;
        }
        case CustomTable:
        {
            sqlString = [NSMutableString stringWithFormat:@"INSERT INTO Custom (custom_id, province_id, dealer_id, shop_id, user_id, name, tel, address, remark, create_time, array_order, time, budget, status) VALUES (:custom_id, :province_id, :dealer_id, :shop_id, :user_id, :name, :tel, :address, :remark, :create_time, :array_order, :time, :budget, :status)"];
            break;
        }
        case UserHaroTable:
        {
            [sqlString appendString: @"INSERT OR REPLACE INTO User (user_id, district_id, name, email, password, type, create_time, status) VALUES ("];
            [sqlString appendFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",[dict objectForKey:@"user_id"], [dict objectForKey:@"district_id"], [dict objectForKey:@"name"], [dict objectForKey:@"email"], [dict objectForKey:@"password"], [dict objectForKey:@"type"], [dict objectForKey:@"create_time"],[dict objectForKey:@"status"]];
            break;
        }
        default:
            break;
    }
    
    
    [self stringToDBSqlString:sqlString];
}


@end
