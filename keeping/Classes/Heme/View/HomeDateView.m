//
//  HomeDateView.m
//  keeping
//
//  Created by kaidan on 16/6/16.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "HomeDateView.h"

// 101 99 164
@implementation HomeDateView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.dateView.layer.cornerRadius = 75;
    self.dateLabel.font = kFONT(40);
    self.week.font = kFONT(17);
    self.dateLabel.textColor = [UIColor whiteColor];
    self.week.textColor = [UIColor whiteColor];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.font =kFONT(13);
    self.dateView.backgroundColor = [UIColor colorWithRed:80/255.0 green:210/255.0 blue:194/255.0 alpha:1];
    self.timeView.layer.cornerRadius = 15;
    self.timeView.backgroundColor = [UIColor colorWithRed:101/255.0 green:99/255.0 blue:164/255.0 alpha:1];
}

-(instancetype)init{
    if (self == [super init]) {
    }
    return self;
}

@end
