//
//  RoundButton.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "RoundButton.h"

@implementation RoundButton


-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        CGFloat r = frame.size.width / 2;
        
        self.layer.cornerRadius = r;
    }
    return self;
}

@end
