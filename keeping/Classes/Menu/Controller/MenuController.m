//
//  MenuController.m
//  keeping
//
//  Created by kaidan on 16/6/16.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "MenuController.h"
#import "ProfileController.h"
#import "HomeController.h"
#import "CreateController.h"
#import "OverViewController.h"
#import "GroupsController.h"
#import "ListsController.h"
#import "TimelineController.h"
#import "LoginController.h"
#import "SettingController.h"
#import "FebruaryController.h"
#import "LZBBubbleTransition.h"
#import "AppDelegate.h"
#import "TabBarController.h"
#import "LoginController.h"

//188 189 212
@interface MenuController ()

@property(nonatomic,strong)LZBBubbleTransition* transition;

@end

@implementation MenuController


-(void)awakeFromNib{
    self.MyIconButtton.layer.cornerRadius = 25;
    self.MyIconButtton.backgroundColor = [UIColor orangeColor];
    
    
    [self addTarger];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


/*
 [HomeController getHomeObject],           0
 [FebruaryController getxCalendarObject],  1
 [CreateController getxCreateObject],      2
 [ListsController getxListsObject],        3
 [OverViewController getOverViewObject],   4
 [TimelineController getTimelineObject],   5
 [GroupsController getxGroupsObject],      6
 [ProfileController getProfileObject]      7
 */
-(void)addTarger{
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回");
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [[self.MyIconButtton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"点击我的头像");
    }];
    
    [[self.HomeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回Home目录");
        [self pushViewControllerWithIndex:0];
    }];
    
    [[self.OverviewButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回面板");
        [self pushViewControllerWithIndex:1];
    }];
    
    [[self.GroupsButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回组");
        [self pushViewControllerWithIndex:2];
        
    }];
    
    [[self.ProfileButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回我的");
        
        [self pushViewControllerWithIndex:3];
    }];
    
    [[self.TimelineButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回时间轴");
        [self pushViewControllerWithIndex:4];
        
    }];
    
    [[self.settingButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回设置");
        
    }];
    
    [[self.logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"退出重登，返回登录界面");
        
        LoginController* loginVC = [[LoginController alloc]init];
        AppDelegate* app = [UIApplication sharedApplication].delegate;
        app.window.rootViewController = loginVC;
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)pushViewControllerWithIndex:(NSInteger)index{
    AppDelegate* app = [UIApplication sharedApplication].delegate;
    TabBarController* tab = (TabBarController*)app.window.rootViewController;
    tab.selectedIndex = index;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pushViewController:(UIViewController*)viewController button:(UIButton*)button{
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    self.transition = [[LZBBubbleTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
        LZBBubbleTransition  *bubble = (LZBBubbleTransition *)transition;
        //设置动画的View
        bubble.targetView = button;
        //设置弹簧属性
        bubble.bounceIsEnable = YES;
    } Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
        
    }];
    viewController.transitioningDelegate = self.transition;
    [self presentViewController:viewController animated:YES completion:nil];
    
}

@end
