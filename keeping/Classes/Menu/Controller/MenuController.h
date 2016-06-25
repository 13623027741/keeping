//
//  MenuController.h
//  keeping
//
//  Created by kaidan on 16/6/16.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundButton.h"
@interface MenuController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet RoundButton *MyIconButtton;
@property (weak, nonatomic) IBOutlet UIButton *HomeButton;
@property (weak, nonatomic) IBOutlet UIButton *CalendarButton;
@property (weak, nonatomic) IBOutlet UIButton *OverviewButton;
@property (weak, nonatomic) IBOutlet UIButton *GroupsButton;
@property (weak, nonatomic) IBOutlet UIButton *ListsButton;
@property (weak, nonatomic) IBOutlet UIButton *ProfileButton;
@property (weak, nonatomic) IBOutlet UIButton *TimelineButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end
