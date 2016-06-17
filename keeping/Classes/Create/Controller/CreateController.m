
//
//  CreateController.m
//  keeping
//
//  Created by kaidan on 16/6/16.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "CreateController.h"
#import "CreateCell.h"
#import "MenuController.h"

@interface CreateController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIImageView* addImageView;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UIButton* addImageButton;

@property(nonatomic,strong)UILabel* dicriptionLabel;

@property(nonatomic,strong)UIButton* nextButton;

@property(nonatomic,strong)UIImageView* checkImageView;

@property(nonatomic,strong)MenuController* menu;

@end
static NSString* CCell = @"cell";
@implementation CreateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubView];
    
    [self addAutolayout];
    
    [self addTarger];
}

-(void)addSubView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"CreateCell" bundle:nil] forCellReuseIdentifier:CCell];
    [self.view addSubview:self.tableView];
    
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"Create New";
    self.titleLabel.font = kFONT(18);
    [self.view addSubview:self.titleLabel];
    
    self.addButton = [[UIButton alloc]init];
    [self.addButton setImage:[UIImage imageNamed:@"image_icon"] forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    
    self.addImageView = [[UIImageView alloc]init];
    self.addImageView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:249/255.0 alpha:1];
    [self.view addSubview:self.addImageView];
    
    self.addImageButton = [[UIButton alloc]init];
    [self.addImageButton setTitle:@"Add Title" forState:UIControlStateNormal];
    [self.addImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addImageButton.titleLabel.font = kFONT(25);
    [self.view addSubview:self.addImageButton];
    
    self.dicriptionLabel = [[UILabel alloc]init];
    self.dicriptionLabel.font = kFONT(13);
    self.dicriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.dicriptionLabel.text = @"ADD DISCRIPTION";
    self.dicriptionLabel.textColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:194/255.0 alpha:1];
    [self.view addSubview:self.dicriptionLabel];
    
    self.nextButton = [[UIButton alloc]init];
    [self.nextButton setBackgroundColor:[UIColor colorWithRed:101/255.0 green:99/255.0 blue:164/255.0 alpha:1]];
    [self.view addSubview:self.nextButton];
    
    self.checkImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check"]];
    [self.view addSubview:self.checkImageView];
    
    self.menu = [[[NSBundle mainBundle]loadNibNamed:@"MenuController" owner:nil options:nil]lastObject];
    self.menu.alpha = 0;
    [self.view addSubview:self.menu];
}

-(void)addAutolayout{
    
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.width.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.menuButton.mas_right).offset(10);
        make.top.height.equalTo(self.titleLabel);
        make.width.mas_equalTo(@80);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
    }];
    
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(@60);
        make.height.mas_equalTo(@150);
    }];
    
    [self.addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@50);
        make.centerY.mas_equalTo(self.addImageView.mas_centerY).offset(-10);
    }];
    
    [self.dicriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.addImageButton.mas_bottom);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@50);
    }];
    
    [self.checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.nextButton.mas_top).offset(10);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.mas_equalTo(self.addImageView.mas_bottom);
        make.bottom.mas_equalTo(self.nextButton.mas_top);
    }];
    
    [self.menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

-(void)addTarger{
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"打开菜单");
        self.menu.alpha = 1;
    }];
}

#pragma mark - 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CreateCell* cell = [tableView dequeueReusableCellWithIdentifier:CCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CreateCell" owner:nil options:nil]lastObject];
    }
    cell.title.text = @"Date";
    
    return cell;
}
@end
