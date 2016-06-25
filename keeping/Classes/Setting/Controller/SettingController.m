//
//  SettingController.m
//  keeping
//
//  Created by kaidan on 16/6/24.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()

@end

@implementation SettingController

+(instancetype)getSettingObject{
    static SettingController* setting;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting = [[SettingController alloc]init];
    });
    return setting;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
