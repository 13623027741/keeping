//
//  OverViewController.m
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "OverViewController.h"
#import "VTMagicView.h"
#import "nextView.h"
#import "CutemView.h"
@interface OverViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UIButton* searchButton;

@property(nonatomic,strong)VTMagicView* magicView;

@property(nonatomic,strong)nextView* nView;

@property(nonatomic,strong)CutemView* leftView;

@property(nonatomic,strong)CutemView* rightView;

@property(nonatomic,strong)UITableView* tableView;

@end
static NSString* oCell = @"cell";
@implementation OverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    
    [self addAutolayout];
    
    [self addTarger];
}

-(void)addSubView{
    
}

-(void)addAutolayout{
    
}

-(void)addTarger{
    
}

#pragma mark - 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:oCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:oCell];
    }
    cell.textLabel.text = @"333";
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
