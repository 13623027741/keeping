//
//  overViewItemModel.m
//  keeping
//
//  Created by kaidan on 16/6/30.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "overViewItemModel.h"

@implementation overViewItemModel

-(CGFloat)getCellHeight{
    
    NSLog(@"--%g--%g---",[overViewItemModel heightForText:self.title],[overViewItemModel heightForText:self.massage]);
    
    return [overViewItemModel heightForText:self.title] + [overViewItemModel heightForText:self.massage];
}

-(CGFloat)getMassageHeight{
    return [overViewItemModel heightForText:self.massage];
}

//单独计算文本的高度
+ (CGFloat)heightForText:(NSString *)text
{
    //设置计算文本时字体的大小,以什么标准来计算
    NSDictionary *attrbute = @{ NSFontAttributeName:[UIFont fontWithName:@"Avenir-Book" size:15]};
    return [text boundingRectWithSize:CGSizeMake(150, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height;
}

+(NSString *)getNewDate{
    
    NSDate* date = [NSDate date];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    return [formatter stringFromDate:date];
}

@end
