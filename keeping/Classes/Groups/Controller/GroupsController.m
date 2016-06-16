//
//  GroupsController.m
//  keeping
//
//  Created by kaidan on 16/6/16.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "GroupsController.h"
#import "GroupsCell.h"
@interface GroupsController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UIButton* searchButton;

@end
static NSString* gCell = @"cell";
@implementation GroupsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubView];
    [self addAutoLayout];
    
}

-(void)addSubView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"GroupsCell" bundle:nil] forCellReuseIdentifier:gCell];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = kFONT(19);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"Groups";
    [self.view addSubview:self.titleLabel];
    
    self.addButton = [[UIButton alloc]init];
    [self.addButton setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    
    self.searchButton = [[UIButton alloc]init];
    [self.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.view addSubview:self.searchButton];
}

-(void)addAutoLayout{
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(@30);
        make.left.width.height.mas_equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@50);
        make.top.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@20);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
        make.right.mas_equalTo(self.searchButton.mas_left).offset(-20);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(60);
        make.left.bottom.right.equalTo(self.view);
        
    }];
}

#pragma mark - 代理


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupsCell* cell = [tableView dequeueReusableCellWithIdentifier:gCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GroupsCell" owner:nil options:nil]lastObject];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
