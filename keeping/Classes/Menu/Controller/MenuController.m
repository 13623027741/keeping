//
//  MenuController.m
//  keeping
//
//  Created by kaidan on 16/6/16.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "MenuController.h"
//188 189 212
@interface MenuController ()

@end

@implementation MenuController

-(void)awakeFromNib{
    self.MyIconButtton.layer.cornerRadius = 15;
    self.MyIconButtton.backgroundColor = [UIColor orangeColor];
    
    [self addTarger];
}


-(void)addTarger{
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回");
        self.frame = CGRectMake(0, 0, 0, 0);
        self.alpha = 0;
    }];
    
    [[self.MyIconButtton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"点击我的头像");
    }];
    
    [[self.HomeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回Home目录");
    }];
    
    [[self.CalendarButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回日历");
    }];
    
    [[self.OverviewButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回面板");
    }];
    
    [[self.GroupsButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回组");
    }];
    
    [[self.ListsButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回列表");
    }];
    
    [[self.ProfileButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回我的");
    }];
    
    [[self.TimelineButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回时间轴");
    }];
    
    [[self.settingButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"返回设置");
    }];
    
    [[self.logoutButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"退出重登，返回登录界面");
    }];
}

@end
