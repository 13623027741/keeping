//
//  HomeController.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "HomeController.h"
#import "RoundButton.h"
#import "HomeDateView.h"
#import "MenuController.h"
#import "LZBBubbleTransition.h"
#import "FebruaryTool.h"
#import "FebruaryController.h"


@interface HomeController ()

@property(nonatomic,strong)UIImageView* backgroundImageView;

@property(nonatomic,strong)UIButton* leftButton;

@property(nonatomic,strong)RoundButton* rightButton;

@property(nonatomic,strong)UILabel* rightLabel;

@property(nonatomic,strong)HomeDateView* dateView;

@property(nonatomic,strong)UILabel* massage;

@property(nonatomic,strong)NSArray* massages;

@property(nonatomic,strong)UILabel* dateMassage;

@property(nonatomic,strong)UIButton* moreButton;

@property(nonatomic,strong)MenuController* menu;

@property(nonatomic,strong)LZBBubbleTransition* transition;
@end

@implementation HomeController

+(instancetype)getHomeObject{
    static HomeController* home;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        home = [[HomeController alloc]init];
    });
    return home;
}

-(NSArray *)massages{
    if (!_massages) {
        _massages = @[@"Good Morning!",@"Good Afternoon!",@"Good Evening!"];
    }
    return _massages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    
    [self addAutoLayout];
    
    [self addTarger];
    
    [self checkMassage];
    [NSTimer scheduledTimerWithTimeInterval:100 target:self selector:@selector(checkMassage) userInfo:nil repeats:YES];
}

/**
 *  添加View
 */
-(void)addSubView{
    
    self.backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Home_bg"]];
    [self.view addSubview:self.backgroundImageView];
    
    self.leftButton = [[UIButton alloc]init];
    [self.leftButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.leftButton];
    
    self.rightButton = [[RoundButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.rightButton setImage:[UIImage imageNamed:@"icon_img"] forState:UIControlStateNormal];
    
    
    [self.view addSubview:self.rightButton];
    
    self.rightLabel = [[UILabel alloc]init];
    self.rightLabel.text = @"62°";
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel.font = kFONT(19);
    [self.view addSubview:self.rightLabel];
    
    self.massage = [[UILabel alloc]init];
    self.massage.text = self.massages[0];
    self.massage.font = kFONT(25);
    self.massage.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.massage];
    
    self.dateView = [[[NSBundle mainBundle]loadNibNamed:@"HomeDateView" owner:nil options:nil]lastObject];
    self.dateView.timeLabel.layer.cornerRadius = 10;
    [self.view addSubview:self.dateView];
    
    self.dateMassage = [[UILabel alloc]init];
    self.dateMassage.font = kFONT(17);
    self.dateMassage.text = @"FEBUARY 2015";
    self.dateMassage.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.dateMassage];
    
    self.moreButton = [[UIButton alloc]init];
    [self.moreButton setImage:[UIImage imageNamed:@"Dislosure"] forState:UIControlStateNormal];
    [self.view addSubview:self.moreButton];
    
}
/**
 *  添加自动约束
 */
-(void)addAutoLayout{
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(30);
        make.left.equalTo(self.view).offset(20);
        make.width.height.mas_equalTo(@20);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-70);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
        make.top.mas_equalTo(@30);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.width.height.mas_equalTo(@40);
        make.top.mas_equalTo(@30);
    }];
    
    [self.massage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@50);
        make.top.mas_equalTo(@100);
    }];
    
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(@200);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    [self.dateMassage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@250);
        make.height.mas_equalTo(@30);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(@20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
    }];
    
}
/**
 *  添加事件
 */
-(void)addTarger{
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"---");
        MenuController* vc = [[[NSBundle mainBundle]loadNibNamed:@"MenuController" owner:nil options:nil]lastObject];
        @weakify(self);
        
        vc.modalPresentationStyle = UIModalPresentationCustom;
        self.transition = [[LZBBubbleTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
            @strongify(self);
            LZBBubbleTransition  *bubble = (LZBBubbleTransition *)transition;
            //设置动画的View
            bubble.targetView = self.leftButton;
            //设置弹簧属性
            bubble.bounceIsEnable = YES;
        } Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
            
        }];
        vc.transitioningDelegate = self.transition;
        [self presentViewController:vc animated:YES completion:nil];

        
    }];
    
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc]init];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [swipe.rac_gestureSignal subscribeNext:^(id x) {
        NSLog(@"向下激发手势");
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = @"cube";
        transition.subtype = @"fromTop";
        
//        self.tabBarController.selectedIndex = 1;
        
        [self.navigationController pushViewController:[FebruaryController getxCalendarObject] animated:NO];
        
        [self.tabBarController.view.layer addAnimation:transition forKey:nil];
        
        
    }];
    
    [self.view addGestureRecognizer:swipe];
    
    
//    UISwipeGestureRecognizer* swipe1 = [[UISwipeGestureRecognizer alloc]init];
//    swipe1.direction = UISwipeGestureRecognizerDirectionDown;
//    [swipe1.rac_gestureSignal subscribeNext:^(id x) {
//        NSLog(@"向上激发手势");
//        
//        CATransition* transition = [CATransition animation];
//        transition.duration = 0.5;
//        transition.type = @"cube";
//        transition.subtype = @"fromBottom";
//        
//        self.tabBarController.selectedIndex = 4;
//        
//        [self.tabBarController.view.layer addAnimation:transition forKey:nil];
//        
//        
//    }];
//    
//    [self.view addGestureRecognizer:swipe1];
}

-(void)checkMassage{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"hh";
    
    NSInteger time = [[formatter stringFromDate:[NSDate date]] integerValue];
    
    NSLog(@"--%ld--",time);
    
    if (5 < time && time < 10) {
        self.massage.text = self.massages[0];
    }else if (11 <= time && time < 17){
        self.massage.text = self.massages[1];
    }else{
        self.massage.text = self.massages[2];
    }
    
    self.dateView.dateLabel.text = [NSString stringWithFormat:@"%ld",[FebruaryTool getCurrentDay]];
    self.dateView.timeLabel.text = [NSString stringWithFormat:@"%ld",[FebruaryTool getCurrentHour]];
    self.dateView.week.text = [NSString stringWithFormat:@"%@",[FebruaryTool getWeekDay]];
    
    NSArray* arr = @[@"January",
                   @"February",
                   @"March",
                   @"April",
                   @"May",
                   @"June",
                   @"July",
                   @"August",
                   @"September",
                   @"October",
                   @"November",
                   @"December"];
    
    NSString* month = arr[[FebruaryTool getCurrentMonth] - 1];
    self.dateMassage.text = [NSString stringWithFormat:@"%@ %ld",month,[FebruaryTool getCurrentYear]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
