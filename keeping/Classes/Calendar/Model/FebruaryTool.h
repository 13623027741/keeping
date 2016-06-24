//
//  FebruaryTool.h
//  keeping
//
//  Created by kaidan on 16/6/23.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FebruaryTool : NSObject

+(NSInteger)getCurrentYear;

+(NSInteger)getCurrentMonth;

+(NSInteger)getCurrentDay;

+(NSInteger)getWeekWithDay;

+(NSInteger)getMonthDays:(NSInteger)month year:(NSInteger)year;

+ (NSArray*)getCurrentMonthWithDay;

+(NSInteger)getWeekDayWithMonth:(NSInteger)month;
@end
