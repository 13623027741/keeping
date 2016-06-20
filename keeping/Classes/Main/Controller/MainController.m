//
//  MainController.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addItem];
    
    self.navigationBarHidden = YES;
    
}

-(void)addItem{
    
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.left.width.height.mas_equalTo(@20);
    }];
}

-(void)openMenu{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
