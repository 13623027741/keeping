//
//  SignUpController.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "SignUpController.h"
#import "SignUpCell.h"
// 101 99 164
@interface SignUpController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray* titles;

@end
static NSString* signUpcell = @"cell";
@implementation SignUpController

-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"Name",@"Email",@"Password",@"Birthday"];
    }
    return _titles;
}

-(instancetype)init{
    if (self == [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.checkButton.backgroundColor = [UIColor colorWithRed:101/255.0 green:99/255.0 blue:164/255.0 alpha:1];
    [self.tableView registerNib:[UINib nibWithNibName:@"SignUpCell" bundle:nil] forCellReuseIdentifier:signUpcell];
    
}

#pragma mark - 代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SignUpCell* cell = [tableView dequeueReusableCellWithIdentifier:signUpcell forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:nil options:nil]lastObject];
    }
    
    cell.title.text = self.titles[indexPath.row];
    cell.textField.tag = 100 + indexPath.row;
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
