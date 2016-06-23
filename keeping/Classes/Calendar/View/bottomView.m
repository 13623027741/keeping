
//
//  bottomView.m
//  keeping
//
//  Created by kaidan on 16/6/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "bottomView.h"
#import "subView.h"

@interface bottomView ()

@property (weak, nonatomic) IBOutlet subView *button1;

@property (weak, nonatomic) IBOutlet subView *button2;

@property (weak, nonatomic) IBOutlet subView *button3;

@property (weak, nonatomic) IBOutlet subView *button4;

@end

@implementation bottomView

-(void)awakeFromNib{
    
    self.onTouch = ^(NSInteger tag){};
    
    
    self.button1.imgView.image = [UIImage imageNamed:@"completed"];
    self.button2.imgView.image = [UIImage imageNamed:@"shandian"];
    self.button3.imgView.image = [UIImage imageNamed:@"snoozed"];
    self.button4.imgView.image = [UIImage imageNamed:@"alert"];
    
    
}

-(instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = kCOLOR_RGB(80, 210, 194);
        
        
        
    }
    return self;
}


-(void)setWidth:(CGFloat)width{
    _width = width;
    
}
-(BOOL)needsUpdateConstraints{
    NSLog(@"--");
    
    CGFloat w = _width / 4;
    
    NSLog(@"--%g--%g-",_width,w);
    
    [self.button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.width.mas_equalTo(@103);
    }];
    
    [self.button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.button1.mas_right);
        make.width.mas_equalTo(self.button1.mas_width);
        make.bottom.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
    }];
    
    [self.button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.button2.mas_right);
        make.bottom.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.width.mas_equalTo(self.button1);
    }];
    
    [self.button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.button3.mas_right);
        make.bottom.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.width.mas_equalTo(self.button1);
    }];

    
    return YES;
}

@end
