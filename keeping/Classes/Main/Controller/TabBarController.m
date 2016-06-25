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
#import "MainController.h"
#import "FebruaryController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addViewController];
    
    self.tabBar.hidden = YES;
}

-(void)addViewController{
    
    
    self.viewControllers = @[
                             [HomeController getHomeObject],
                             [FebruaryController getxCalendarObject],
                             [CreateController getxCreateObject],
                             [ListsController getxListsObject],
                             [OverViewController getOverViewObject],
                             [TimelineController getTimelineObject],
                             [GroupsController getGroupsObject],
                             [ProfileController getProfileObject]
                             ];
    
}

-(MainController*)navigationControllerWithViewController:(UIViewController*)viewController{
    viewController.tabBarItem.title = @"111";
    MainController* vc = [[MainController alloc]initWithRootViewController:viewController];
    
    return vc;
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
