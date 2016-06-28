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
    return arr;
}

+(NSInteger)getCurrentHour{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"hh";
    NSString* dateStr = [formatter stringFromDate:[NSDate date]];
    
    return [dateStr integerValue];
}

+(NSString*)getWeekDay{
    
    NSDictionary* weeks = @{@"星期日":@"MON",
                            @"星期一":@"TUES",
                            @"星期二":@"WEDNES",
                            @"星期三":@"THURS",
                            @"星期四":@"FRI",
                            @"星期五":@"SATUR",
                            @"星期天":@"SUN"
                            };
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"EEEE";
    
    NSDate* date = [NSDate date];
    
     return [weeks objectForKey:[dateFormatter stringFromDate:date]];
    
}

@end
