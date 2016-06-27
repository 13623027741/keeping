//
//  SettingController.m
//  keeping
//
//  Created by kaidan on 16/6/24.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "SettingController.h"
#import "MenuController.h"


@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* icon_button;

@property(nonatomic,strong)UIButton* logoutButton;

@property(nonatomic,strong)UIImageView* imgView;

@property(nonatomic,strong)UITableView* tableView;

@end
NSString* SCell = @"cell";
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addView];
    
    [self addAutolayout];
    
    [self addTarger];
}

-(void)addView{
    
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = kFONT(15);
    self.titleLabel.text = @"Settings";
    [self.view addSubview:self.titleLabel];
    
    self.icon_button = [[UIButton alloc]init];
    [self.icon_button setImage:[UIImage imageNamed:@"image_icon"] forState:UIControlStateNormal];
    [self.view addSubview:self.icon_button];
    
    self.logoutButton = [[UIButton alloc]init];
    [self.logoutButton setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [self.view addSubview:self.logoutButton];
    
    self.imgView = [[UIImageView alloc]init];
    self.imgView.image = [UIImage imageNamed:@"icon_img"];
    [self.view addSubview:self.imgView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SCell];
    [self.view addSubview:self.tableView];
    
}

-(void)addAutolayout{
    
}

-(void)addTarger{
    
}

#pragma mark - 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:SCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SCell];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
