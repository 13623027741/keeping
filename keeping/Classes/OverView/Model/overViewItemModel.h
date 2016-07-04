//
//  overViewItemModel.h
//  keeping
//
//  Created by kaidan on 16/6/30.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface overViewItemModel : NSObject

/**
 *  标题
 */
@property(nonatomic,copy)NSString* title;
/**
 *  详细信息
 */
@property(nonatomic,copy)NSString* massage;
/**
 *  时间字符串
 */
@property(nonatomic,copy)NSString* timeStr;
/**
 *  时段
 */
@property(nonatomic,copy)NSString* shiduan;
/**
 *  是否完成
 */
@property(nonatomic,assign)NSInteger isComplete;

@property(nonatomic,copy)NSString* date;

-(CGFloat)getCellHeight;

-(CGFloat)getMassageHeight;

+(NSString*)getNewDate;

@end
