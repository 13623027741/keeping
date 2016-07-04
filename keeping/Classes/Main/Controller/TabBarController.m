//
//  TabBarController.m
//  keeping
//
//  Created by kaidan on 16/6/24.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "TabBarController.h"
#import "CreateController.h"
#import "ListsController.h"
#import "CreateController.h"
#import "GroupsController.h"
#import "HomeController.h"
#import "OverViewController.h"
#import "ProfileController.h"
#import "TimelineController.h"
#import "FebruaryController.h"
#import "MainController.h"

@interface TabBarController ()

@end

@implementation TabBarController

-(instancetype)init{
    if (self == [super init]) {
        
        MainController* home = [[MainController alloc]initWithRootViewController:[HomeController getHomeObject]];
        MainController* overView = [[MainController alloc]initWithRootViewController:[OverViewController getOverViewObject]];
        MainController* groups = [[MainController alloc]initWithRootViewController:[GroupsController getGroupsObject]];
        MainController* Profile = [[MainController alloc]initWithRootViewController:[ProfileController getProfileObject]];
        MainController* timeline = [[MainController alloc]initWithRootViewController:[TimelineController getTimelineObject]];
        
        
        self.viewControllers = @[home,overView,groups,Profile,timeline];
        
//        self.viewControllers = @[
//                                 [HomeController getHomeObject],
//                                 [OverViewController getOverViewObject],
//                                 [GroupsController getGroupsObject],
//                                 [ProfileController getProfileObject],
//                                 [TimelineController getTimelineObject],
//                                 ];
        
        
        self.tabBar.hidden = YES;
    }
    
    
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
