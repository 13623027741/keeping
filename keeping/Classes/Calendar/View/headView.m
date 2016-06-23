//
//  headView.m
//  keeping
//
//  Created by kaidan on 16/6/22.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "headView.h"

@implementation headView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(0, (frame.size.width / 7)-1, frame.size.width, 1)];
        lineView.backgroundColor = kCOLOR_RGB(117, 115, 175);
        [self addSubview:lineView];
        
        NSArray* arr = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
        
        CGFloat width = frame.size.width / 7;
        for (NSInteger i = 0; i < 7; i++) {
            UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, width)];
            lab.text = arr[i];
            lab.font = kFONT(17);
            lab.textColor = [UIColor whiteColor];
            lab.textAlignment = NSTextAlignmentCenter;
            
            
            
            [self addSubview:lab];
        }
        
    }
    return self;
}

@end
