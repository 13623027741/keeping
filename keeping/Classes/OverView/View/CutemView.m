//
//  CutemView.m
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "CutemView.h"

@interface CutemView()

@property(nonatomic,strong)UILabel* letfTitleLabel;

@property(nonatomic,strong)UILabel* leftMassageLabel;

@property(nonatomic,strong)UILabel* rightTitleLabel;

@property(nonatomic,strong)UILabel* rightMassageLabel;

@end

@implementation CutemView

-(instancetype)init{
    if (self == [super init]) {
        [self addsubView];
    }
    return self;
}

-(void)addsubView{
    
    UIView* letfView = [[UIView alloc]init];
    letfView.backgroundColor = [UIColor colorWithRed:80/255.0 green:210/255.0 blue:194/255.0 alpha:1];
    [self addSubview:letfView];
    
    UIView* rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor colorWithRed:214/255.0 green:103/255.0 blue:205/255.0 alpha:1];
    [self addSubview:rightView];
    
    self.letfTitleLabel = [[UILabel alloc]init];
    self.letfTitleLabel.font = kFONT(15);
    self.letfTitleLabel.text = @"COMPLETED";
    self.letfTitleLabel.textColor = [UIColor whiteColor];
    self.letfTitleLabel.textAlignment = NSTextAlignmentCenter;
    [letfView addSubview:self.letfTitleLabel];
    
    self.leftMassageLabel = [[UILabel alloc]init];
    self.leftMassageLabel.font = kFONT(35);
    self.leftMassageLabel.textColor = [UIColor whiteColor];
    self.leftMassageLabel.textAlignment = NSTextAlignmentCenter;
    [letfView addSubview:self.leftMassageLabel];
    
    self.rightTitleLabel = [[UILabel alloc]init];
    self.rightTitleLabel.font = kFONT(15);
    self.rightTitleLabel.text = @"OVERDUE";
    self.rightTitleLabel.textColor = [UIColor whiteColor];
    self.rightTitleLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:self.rightTitleLabel];
    
    self.rightMassageLabel = [[UILabel alloc]init];
    self.rightMassageLabel.font = kFONT(35);
    self.rightMassageLabel.textAlignment = NSTextAlignmentCenter;
    self.rightMassageLabel.textColor = [UIColor whiteColor];
    [rightView addSubview:self.rightMassageLabel];
    
    
    [letfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.right.mas_equalTo(self.mas_centerX);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.left.mas_equalTo(self.mas_centerX);
        
    }];
    
    [self.letfTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(letfView).offset(20);
        make.centerX.mas_equalTo(letfView.mas_centerX);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@20);
    }];
    
    [self.leftMassageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.letfTitleLabel.mas_bottom);
        make.height.width.mas_equalTo(@50);
        make.centerX.mas_equalTo(letfView.mas_centerX);
    }];
    
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightView).offset(20);
        make.centerX.mas_equalTo(rightView.mas_centerX);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@20);
    }];
    
    [self.rightMassageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rightTitleLabel.mas_bottom);
        make.height.width.mas_equalTo(@50);
        make.centerX.mas_equalTo(rightView.mas_centerX);
    }];
}

-(void)setLeftCount:(NSInteger)leftCount{
    _leftCount = leftCount;
    
    self.leftMassageLabel.text = [NSString stringWithFormat:@"%ld",leftCount];
}

-(void)setRightCount:(NSInteger)rightCount{
    _rightCount = rightCount;
    
    self.rightMassageLabel.text = [NSString stringWithFormat:@"%ld",rightCount];
}

@end
