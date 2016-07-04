//
//  FMData.m
//  FMDB学生管理系统
//
//  Created by kaidan on 15/7/24.
//  Copyright (c) 2015年 kaidan. All rights reserved.
//

#import "FMData.h"
#import "overViewItemModel.h"


@implementation FMData

+(BOOL)isDB{
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbPath = [NSString stringWithFormat:@"%@/task.sqlite",path];
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    return [manager fileExistsAtPath:dbPath];
}

+(FMDatabase*)getFMDataBase{
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbPath = [NSString stringWithFormat:@"%@/task.sqlite",path];
    
    FMDatabase* db = [[FMDatabase alloc]initWithPath:dbPath];

    [db open];
    return db;
    
}

+(BOOL)createTable{
    
    
    FMDatabase* db = [FMData getFMDataBase];
    
    NSString* sql = @" create table task(id integer primary key autoincrement ,title text not null,massage text not null,time varchar(15),shiduan varchar(15),isCompleted integer,dateStr text)";
    
    if([db executeUpdate:sql]){
        NSLog(@"建表成功");
        [db close];
        return YES;
    }else{
        NSLog(@"建表失败");
    }
    
    [db close];
    return NO;
}

+(BOOL)insertData:(id)data{
    
    overViewItemModel* model = (overViewItemModel*)data;
    
    NSLog(@"--[(%@)]--",model.date);
    
    NSLog(@"-[%@]-[%@]--[%@]--[%@]--[%@]--[%d]----",model.title,model.massage,model.timeStr,model.shiduan,model.date,model.isComplete);
    
    FMDatabase* db = [FMData getFMDataBase];
    
    NSString* sql = @" insert into task(title,massage,time,shiduan,isCompleted,dateStr) values(?,?,?,?,?,?)";
    
    if ([db executeUpdate:sql,model.title,model.massage,model.timeStr,model.shiduan,model.isComplete,model.date]) {
        NSLog(@"添加成功");
        [db close];
        return YES;
    }else{
        NSLog(@"添加失败");
        [db close];
        return NO;
    }
}

+(BOOL)delectData:(id)data{
    
    overViewItemModel* model = (overViewItemModel*)data;
    
    FMDatabase* db = [FMData getFMDataBase];
    
    NSString* sql = @" delect from task where date = ?";
    
    if ([db executeUpdate:sql,model.date]) {
        NSLog(@"删除成功");
        [db close];
        return YES;
    }else{
        NSLog(@"删除失败");
        [db close];
        return NO;
    }
}

+(BOOL)updateData:(id)data{
    
    overViewItemModel* model = (overViewItemModel*)data;
    
    FMDatabase* db = [FMData getFMDataBase];
    
    NSString* sql = @" update task set isCompleted = ? where dateStr = ? ";
    
//    NSString* sql = [NSString stringWithFormat:@"update task set isCompleted = 1 where dateStr = '%@' ",model.date];
    
    if ([db executeUpdate:sql,@(model.isComplete),model.date]) {
        NSLog(@"修改成功");
        [db close];
        return YES;
    }else{
        NSLog(@"修改失败");
        [db close];
        return NO;
    }
}

+(NSArray*)selectData{
    
    NSMutableArray* arr = [NSMutableArray array];
    
    FMDatabase* db = [FMData getFMDataBase];
    
    NSString* sql = @" select * from task ";
    
    FMResultSet* result = [db executeQuery:sql];
    
    while (result.next) {
        
        NSString* title = [result stringForColumn:@"title"];
        NSString* massage = [result stringForColumn:@"massage"];
        NSString* time = [result stringForColumn:@"time"];
        NSString* shiduan = [result stringForColumn:@"shiduan"];
        BOOL isCompleted = [result boolForColumn:@"isCompleted"];
        NSString* date = [result stringForColumn:@"dateStr"];
        
        overViewItemModel* model = [[overViewItemModel alloc]init];
        model.title = title;
        model.massage = massage;
        model.timeStr = time;
        model.shiduan = shiduan;
        model.isComplete = isCompleted;
        model.date = date;
        [arr addObject:model];
        
//        NSLog(@"-数据库保存的条数--%ld",arr.count);
        
        NSLog(@"-%@--",date);
    }
    
    return arr;
}

@end
