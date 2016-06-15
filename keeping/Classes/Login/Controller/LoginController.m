//
//  LoginController.m
//  keeping
//
//  Created by kaidan on 16/6/14.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "LoginController.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"
#import "MBProgressHUD.h"
#import "WSPaymentCircleView.h"
#import "SignUpController.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface LoginController ()<UITextFieldDelegate>

@property(nonatomic,strong)UIImageView* backgroundView;

@property(nonatomic,strong)WSPaymentCircleView* circleView;

@property(nonatomic,strong)UIView* whiteView;

@property(nonatomic,strong)UILabel* label;

@property(nonatomic,strong)UIImageView* iconView;

//----------login---------//
/**
 *  用户名提示
 */
@property(nonatomic,strong)UILabel* userNameLabel;
/**
 *  用户名框
 */
@property(nonatomic,strong)UITextField* userName;
/**
 *  密码框提示
 */
@property(nonatomic,strong)UILabel* passWordLabel;
/**
 *  密码框
 */
@property(nonatomic,strong)UITextField* passWord;
/**
 *  登陆
 */
@property(nonatomic,strong)UIButton* login;
/**
 *  错误图片
 */
@property(nonatomic,strong)UIImageView* errorView;
/**
 *  描述
 */
@property(nonatomic,strong)UILabel* massageLabel;
/**
 *  注册
 */
@property(nonatomic,strong)UIButton* signUp;

@property(nonatomic,strong)UIView* msgView;

@end

@implementation LoginController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
    
    [self addAutoLayout];
    
    [self addTarger];
}
/**
 *  添加View
 */
-(void)addView{
    self.backgroundView = [[UIImageView alloc]init];
    self.backgroundView.image = [UIImage imageNamed:@"login_bg"];
    [self.view addSubview:self.backgroundView];
    
    
    self.whiteView = [[UIView alloc]init];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.layer.cornerRadius = 50;
    [self.view addSubview:self.whiteView];
    
    self.iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    [self.view addSubview:self.iconView];
    
    self.circleView = [[WSPaymentCircleView alloc]initWithFrame:CGRectMake(SCREEN_SIZE.width / 2-30, 120, 60, 60)];
    [self.circleView loadStatus:WSLoadStatusLoading];
    [self.view addSubview:self.circleView];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView* img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
        img.tag = 1000 + i;
        img.layer.opacity = 0;
        [self.view addSubview:img];
    }
    
    self.label = [[UILabel alloc]init];
    self.label.text = @"Get Started!";
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = kFONT(25);
    [self.view addSubview:self.label];
    
    
    self.userNameLabel = [[UILabel alloc]init];
    self.userNameLabel.text = @"Username";
    self.userNameLabel.textColor = [UIColor whiteColor];
    self.userNameLabel.alpha = 0.7;
    self.userNameLabel.font = kFONT(13);
    [self.view addSubview:self.userNameLabel];
    
    self.userName = [[UITextField alloc]init];
    self.userName.textColor = [UIColor whiteColor];
    self.userName.font = kFONT(13);
    self.userName.delegate = self;
    self.userName.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.userName];
    
    self.passWordLabel = [[UILabel alloc]init];
    self.passWordLabel.text = @"Password";
    self.passWordLabel.textColor = [UIColor whiteColor];
    self.passWordLabel.alpha = 0.7;
    self.passWordLabel.font = kFONT(13);
    [self.view addSubview:self.passWordLabel];
    
    self.passWord = [[UITextField alloc]init];
    self.passWord.textColor = [UIColor whiteColor];
    self.passWord.font = kFONT(13);
    self.passWord.secureTextEntry = YES;
    self.passWord.delegate = self;
    self.passWord.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.passWord];
    
    self.login = [[UIButton alloc]init];
    [self.login setTitle:@"Login" forState:UIControlStateNormal];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.login.titleLabel.font = kFONT(18);
    [self.login setBackgroundImage:[UIImage imageNamed:@"button_background"] forState:UIControlStateNormal];
    [self.view addSubview:self.login];
    
    self.massageLabel = [[UILabel alloc]init];
    self.massageLabel.textColor = [UIColor whiteColor];
    self.massageLabel.text = @"Don't have an accout?";
    self.massageLabel.font = kFONT(13);
    CGFloat y = SCREEN_SIZE.height - 30;
    self.massageLabel.frame = CGRectMake((SCREEN_SIZE.width - 200) / 2, y, 150, 20);
    [self.view addSubview:self.massageLabel];
    
    self.signUp = [[UIButton alloc]init];
    [self.signUp setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUp setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGFloat x = SCREEN_SIZE.width - self.massageLabel.center.x + 10;
    self.signUp.frame = CGRectMake(x, y, 50, 20);
    self.signUp.titleLabel.font = kFONT(13);
    [self.view addSubview:self.signUp];
    
    UIView* lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    lineView.tag = 1111;
    lineView.alpha = 0.5;
    [self.view addSubview:lineView];
}
/**
 *  自动布局
 */
-(void)addAutoLayout{
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.whiteView.mas_centerY);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView* img = [self.view viewWithTag:(1000 + i)];
        
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(self.whiteView);
            make.centerX.mas_equalTo(self.whiteView.mas_centerX);
            make.centerY.mas_equalTo(self.whiteView.mas_centerY);
        }];
    }
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(@50);
        make.width.mas_equalTo(@200);
        make.top.mas_equalTo(self.whiteView.mas_bottom).offset(50);
    }];
    
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@50);
    }];
    
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@40);
        make.bottom.mas_equalTo(self.login.mas_top);
    }];
    
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.passWord.mas_top);
        make.height.mas_equalTo(@20);
        make.left.mas_equalTo(self.passWord.mas_left);
        make.width.mas_equalTo(@100);
    }];
    
    [[self.view viewWithTag:1111] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
        make.bottom.mas_equalTo(self.passWordLabel.mas_top);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.passWord);
        make.bottom.mas_equalTo(self.passWord.mas_top).offset(-20);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.userName.mas_top);
        make.height.mas_equalTo(@20);
        make.left.mas_equalTo(self.userName.mas_left);
        make.width.mas_equalTo(@100);
    }];
    
}

-(void)updateAutoLayout:(CGFloat)height{
    
    [self.backgroundView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backgroundView.mas_top).offset(height);
    }];
    
    [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.whiteView.mas_top).offset(height);
    }];
    
    
    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_top).offset(height);
    }];
    
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView* img = [self.view viewWithTag:(1000 + i)];
        
        [img mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(img.mas_top).offset(height);
        }];
    }
    
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_top).offset(height);
    }];
    
    [self.login mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.login.mas_top).offset(height);
    }];
    
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWord.mas_top).offset(height);
    }];
    
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordLabel.mas_top).offset(height);
    }];
    
    [[self.view viewWithTag:1111] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo([self.view viewWithTag:1111 ].mas_top).offset(height);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userName.mas_top).offset(height);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameLabel.mas_top).offset(height);
    }];
}

/**
 *  添加button的点击事件
 */
-(void)addTarger{
    @weakify(self);
    [[self.login rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"login...username[%@].password[%@]..",self.userName.text,self.passWord.text);
        [self addAnimation];
        
        NSString* userName = [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
        NSString* passWord = [[NSUserDefaults standardUserDefaults]objectForKey:@"passWord"];
        
        if ([self.userName.text isEqualToString:userName] && [self.passWord.text isEqualToString:passWord]) {
            NSLog(@"登陆成功");
            self.iconView.alpha = 0;
            [self.circleView loadStatus:WSLoadStatusSuccess];
        }else{
            NSLog(@"登陆失败");
            self.iconView.alpha = 0;
            [self.circleView loadStatus:WSLoadStatusFailed];
            [NSTimer scheduledTimerWithTimeInterval:2
                                             target:self
                                           selector:@selector(changeAlpha) userInfo:nil repeats:NO];
        }
        
    }];
    [[self.signUp rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"signUp....");
        
//        [self presentViewController:signUp animated:YES completion:nil];
    }];
    
    [[RACSignal combineLatest:@[self.userName.rac_textSignal,self.passWord.rac_textSignal] reduce:^id{
        @strongify(self);
        return @(self.userName.text.length > 0 && self.passWord.text.length > 0);
    }]
    subscribeNext:^(NSNumber* value) {
        @strongify(self);
        if ([value boolValue]) {
            NSLog(@"用户名和密码都有填");
            [self.login setBackgroundImage:[UIImage imageNamed:@"button_background"] forState:UIControlStateNormal];
            self.login.userInteractionEnabled = YES;
        }else{
            NSLog(@"用户名和密码都没填");
            [self.login setBackgroundImage:nil forState:UIControlStateNormal];
            [self.login setBackgroundColor:[UIColor colorWithRed:179/255.0 green:178/255.0 blue:2 alpha:215/255.0]];
            self.login.userInteractionEnabled = NO;
            
        }
    }];
//    self.userName.backgroundColor = [UIColor greenColor];
//    self.passWord.backgroundColor = [UIColor greenColor];
    self.userName.text = @"admin";
    self.passWord.text = @"admin";
}

/**
 *  添加动画效果
 */
-(void)addAnimation{
    
    for (NSInteger i = 0; i < 3; i++) {
        
        UIImageView* img = (UIImageView*)[self.view viewWithTag:(1000 + i)];
        
        CAKeyframeAnimation* keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        CAKeyframeAnimation* alphaAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        
        
        keyAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 0)]
                                ];
        alphaAnimation.values = @[@1,@0];
        
        CAAnimationGroup* group = [CAAnimationGroup animation];
        group.animations = @[keyAnimation,alphaAnimation];
        group.duration = (i + 1) * 0.8;
        [img.layer addAnimation:group forKey:nil];
    }
    
    
}

#pragma mark 代理

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"点击了返回。。。");
    [textField resignFirstResponder];
    
//    NSTimeInterval animationDuration = 0.30f;
//    CGRect frame = self.view.frame;
//    frame.origin.y +=216;
//    frame.size. height -=216;
//    self.view.frame = frame;
//    //self.view移回原位置
//    [UIView beginAnimations:@"ResizeView" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    self.view.frame = frame;
//    [UIView commitAnimations];
//    // 这里只用写textField 不用写myTextField
//    [textField resignFirstResponder];
//    
//    [self updateAutoLayout:-216];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSTimeInterval animationDuration = 0.30f;
//    CGRect frame = self.view.frame;
//    //如果屏幕已经上移过，就不上移。
//    if (frame.origin.y < 0){
//        return;
//    }
//    frame.origin.y -=216;
//    frame.size.height +=216;
//    self.view.frame = frame;
//    
//    [UIView beginAnimations:@"ResizeView" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    self.view.frame = frame;
//    [UIView commitAnimations];
//    
//    [self updateAutoLayout:216];
}

-(void)changeAlpha{
    self.iconView.alpha = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
