//
//  HomeController.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "HomeController.h"
#import "RoundButton.h"
@interface HomeController ()

@property(nonatomic,strong)UIImageView* backgroundImageView;

@property(nonatomic,strong)UIButton* leftButton;

@property(nonatomic,strong)RoundButton* rightButton;

@property(nonatomic,strong)UILabel* rightLabel;
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    
    [self addAutoLayout];
}


-(void)addSubView{
    
    self.backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Home_bg"]];
    [self.view addSubview:self.backgroundImageView];
    
    self.leftButton = [[UIButton alloc]init];
    [self.leftButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.leftButton];
    
    self.rightButton = [[UIButton alloc]init];
//    self.rightButton
}

-(void)addAutoLayout{
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
