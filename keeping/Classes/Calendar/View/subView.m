
//
//  subView.m
//  keeping
//
//  Created by kaidan on 16/6/22.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "subView.h"

@interface subView()



@end

@implementation subView

-(instancetype)init{
    if (self == [super init]) {
        self.imgView = [[UIImageView alloc]init];
        
        [self addSubview:self.imgView];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self);
            make.height.width.mas_equalTo(@20);
        }];
    }
    return self;
}


@end
