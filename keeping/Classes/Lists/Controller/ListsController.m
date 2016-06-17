//
//  ListsController.m
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "ListsController.h"
#import "ListsCell.h"
#import "MenuController.h"
@interface ListsController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* shareButton;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UIButton* searchButton;

@property(nonatomic,strong)UIImageView* imageView;

@property(nonatomic,strong)UIButton* imageButton;

@property(nonatomic,strong)UILabel* massageLabel;

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)MenuController* menu;
@end
static NSString* LCell = @"cell";
@implementation ListsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addSubView];
    
    [self addAutolayout];
}

-(void)addSubView{
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = kFONT(19);
    self.titleLabel.text = @"Lists";
    [self.view addSubview:self.titleLabel];
    
    self.shareButton = [[UIButton alloc]init];
    [self.shareButton setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.view addSubview:self.shareButton];
    
    self.addButton  = [[UIButton alloc]init];
    [self.addButton setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    
    self.searchButton = [[UIButton alloc]init];
    [self.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.view addSubview:self.searchButton];
    
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heroBackground"]];
    [self.view addSubview:self.imageView];
    
    self.imageButton = [[UIButton alloc]init];
    [self.imageButton setTitle:@"Work" forState:UIControlStateNormal];
    [self.imageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.imageButton.titleLabel.font = kFONT(25);
    [self.view addSubview:self.imageButton];
    
    self.massageLabel = [[UILabel alloc]init];
    self.massageLabel.text = @"FREELANCE PROJECTS";
    self.massageLabel.textColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:194/255.0 alpha:1];
    self.massageLabel.textAlignment = NSTextAlignmentCenter;
    self.massageLabel.font = kFONT(13);
    [self.view addSubview:self.massageLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LCell];
    [self.view addSubview:self.tableView];
    
    self.menu = [[[NSBundle mainBundle]loadNibNamed:@"MenuController" owner:nil options:nil]lastObject];
    self.menu.alpha = 0;
    [self.view addSubview:self.menu];
}

-(void)addAutolayout{
    
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.height.width.mas_equalTo(@20);
        make.left.mas_equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.height.mas_equalTo(@20);
        make.left.mas_equalTo(self.menuButton.mas_right).offset(10);
        make.width.mas_equalTo(@80);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.searchButton.mas_left).offset(-20);
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.addButton.mas_left).offset(-20);
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(@60);
        make.height.mas_equalTo(@200);
    }];
    
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@50);
        make.centerY.mas_equalTo(self.imageView.mas_centerY).offset(-10);
    }];
    
    [self.massageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@20);
        make.top.mas_equalTo(self.imageButton.mas_bottom);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.imageView.mas_bottom);
    }];
    
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListsCell* cell = [tableView dequeueReusableCellWithIdentifier:LCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ListsCell" owner:nil options:nil]lastObject];
    }
    
    cell.textLabel.text = @"111";
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
