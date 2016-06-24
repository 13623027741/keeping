//
//  FebruaryTool.m
//  keeping
//
//  Created by kaidan on 16/6/23.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "FebruaryTool.h"

@implementation FebruaryTool


+(NSInteger)getCurrentYear{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy";
    NSString* dateStr = [formatter stringFromDate:[NSDate date]];
    //    NSLog(@"%@",dateStr);
    
    return [dateStr integerValue];
}


+(NSInteger)getCurrentMonth{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM";
    NSString* dateStr = [formatter stringFromDate:[NSDate date]];
    //    NSLog(@"%@",dateStr);
    
    return [dateStr integerValue];
}

+(NSInteger)getDayCountWithLastMonth{
    
    
    return [self getMonthDays:[FebruaryTool getCurrentMonth] - 1 year:[FebruaryTool getCurrentYear]];
    
}


+(NSInteger)getCurrentDay{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"dd";
    NSString* dateStr = [formatter stringFromDate:[NSDate date]];
    //    NSLog(@"%@",dateStr);
    
    return [dateStr integerValue];
}

+(NSInteger)getWeekWithDay{
    
    NSDictionary* weeks = @{@"星期日":@(0),
                   @"星期一":@(1),
                   @"星期二":@(2),
                   @"星期三":@(3),
                   @"星期四":@(4),
                   @"星期五":@(5),
                   @"星期天":@(6)
                   };
    
    NSString* str = [NSString stringWithFormat:@"%ld:%ld:01",[FebruaryTool getCurrentYear],[FebruaryTool getCurrentMonth]];
    NSDateFormatter* dateF = [[NSDateFormatter alloc]init];
    dateF.dateFormat = [NSString stringWithFormat:@"yyyy:MM:dd"];
    NSDate* date = [dateF dateFromString:str];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"EEEE";
    
    NSNumber* number = [weeks objectForKey:[dateFormatter stringFromDate:date]];
    return [number integerValue];
}

+(NSInteger)getWeekDayWithMonth:(NSInteger)month{
    
    NSDictionary* weeks = @{@"星期日":@(0),
                            @"星期一":@(1),
                            @"星期二":@(2),
                            @"星期三":@(3),
                            @"星期四":@(4),
                            @"星期五":@(5),
                            @"星期天":@(6)
                            };
    
    NSString* str = [NSString stringWithFormat:@"%ld:%ld:01",[FebruaryTool getCurrentYear],month];
    NSDateFormatter* dateF = [[NSDateFormatter alloc]init];
    dateF.dateFormat = [NSString stringWithFormat:@"yyyy:MM:dd"];
    NSDate* date = [dateF dateFromString:str];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"EEEE";
    
    NSNumber* number = [weeks objectForKey:[dateFormatter stringFromDate:date]];
    return [number integerValue];
    
}

+(NSInteger)getMonthDays:(NSInteger)month year:(NSInteger)year
{
    if (month<=0 || month > 12) {
        return 0;
    }
    BOOL isLeapYear = [self isLeapYear:year];
    int  februaryDay;
    if (isLeapYear) {
        februaryDay = 29;
    }
    else
    {
        februaryDay = 28;
    }
    
    if (month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12) {
        return 31;
    } else if (month == 4||month ==6||month ==9||month ==11) {
        return 30;
    }else {
        return februaryDay;
    }
}

+(BOOL)isLeapYear:(NSInteger)year{
    if ((year % 4  == 0 && year % 100 != 0)|| year % 400 == 0)
        return YES;
    else
        return NO;
}

+ (NSArray*)getCurrentMonthWithDay{
    
    NSMutableArray* arr = [NSMutableArray array];
    
    NSInteger day = [FebruaryTool getMonthDays:[FebruaryTool getCurrentMonth] year:[FebruaryTool getCurrentYear]];
    
    for (NSInteger i = 1; i <= day; i++) {
        [arr addObject:@(i)];
    }
    
//    NSInteger count = [FebruaryTool getWeekWithDay] - 1;
//    
//    NSMutableArray* arr1 = [NSMutableArray array];
//    
//    NSInteger temp = [FebruaryTool getDayCountWithLastMonth];
//    
//    for (NSInteger i = 0; i < count; i++) {
//        [arr1 addObject:@(temp - count + i)];
//    }
//    
//    NSMutableArray* arr2 = [NSMutableArray array];
//    
//    count = 35 - arr.count - arr1.count;
//    
//    for (NSInteger i = 1; i <= count; i++) {
//        [arr2 addObject:@(i)];
//    }
//    
//    NSMutableArray* arr3 = [NSMutableArray array];
//    
//    for (NSNumber* num in arr1) {
//        [arr3 addObject:num];
//    }
//    
//    for (NSNumber* num in arr) {
//        [arr3 addObject:num];
//    }
//    for (NSNumber* num in arr2) {
//        [arr3 addObject:num];
//    }
//    return arr3;
    return arr;
}

@end
