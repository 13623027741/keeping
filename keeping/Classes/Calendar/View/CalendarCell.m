//
//  CalendarCell.m
//  keeping
//
//  Created by kaidan on 16/6/22.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgView.backgroundColor = [UIColor whiteColor];
    self.imgView.layer.cornerRadius = 2.5;
//    self.imgView.alpha = 0;
    
}

@end
