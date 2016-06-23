//
//  OverViewController.m
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "OverViewController.h"
#import "VTMagicController.h"
#import "nextView.h"
#import "CutemView.h"
#import "nextCollectionCell.h"
#import "OverViewCell.h"

@interface OverViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,VTMagicViewDelegate,VTMagicViewDataSource>

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UIButton* searchButton;

@property(nonatomic,strong)VTMagicController* magicController;

@property(nonatomic,strong)UICollectionView* nView;

@property(nonatomic,strong)CutemView* detailView;

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)NSArray* lists;

@end
static NSString* oCell = @"cell";
NSString* nCell = @"cell";

@implementation OverViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.lists = @[@"January",
               @"February",
               @"March",
               @"April",
               @"May",
               @"June",
               @"July",
               @"August",
               @"September",
               @"October",
               @"November",
               @"December"];
    
    [self addSubView];
    
    [self addAutolayout];
    
    [self addTarger];
}

- (VTMagicController *)magicController
{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = [UIColor colorWithRed:80/255.0 green:210/255.0 blue:194/255.0 alpha:1];
        _magicController.magicView.backgroundColor = [UIColor greenColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = 40.f;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

-(void)addSubView{
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"Overview";
    self.titleLabel.font = kFONT(18);
    [self.view addSubview:self.titleLabel];
    
    self.addButton = [[UIButton alloc]init];
    [self.addButton setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    
    self.searchButton = [[UIButton alloc]init];
    [self.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.view addSubview:self.searchButton];
    
//    self.magicController = [[VTMagicController alloc]init];
//    self.magicController.magicView.dataSource = self;
//    self.magicController.magicView.delegate = self;
//    self.magicController.magicView.navigationHeight = 40;
//    [self.view addSubview:self.magicController.view];
    
    [self addChildViewController:self.magicController];
    [self.view addSubview:_magicController.view];
    [_magicController didMoveToParentViewController:self];
    [_magicController.magicView reloadData];
    
    UICollectionViewFlowLayout* flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumLineSpacing = 0;
    flow.itemSize = CGSizeMake(self.view.bounds.size.width, 60);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.nView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60) collectionViewLayout:flow];
    self.nView.pagingEnabled = YES;
    self.nView.delegate = self;
    
    self.nView.dataSource = self;
    self.nView.backgroundColor = [UIColor whiteColor];
    self.nView.showsVerticalScrollIndicator = NO;
    self.nView.showsHorizontalScrollIndicator = NO;
    [self.nView registerNib:[UINib nibWithNibName:@"nextCollectionCell" bundle:nil] forCellWithReuseIdentifier:nCell];
    
    
    [self.view addSubview:self.nView];
    
    self.detailView = [[CutemView alloc]init];
    self.detailView.leftCount = 50;
    self.detailView.rightCount = 10;
    [self.view addSubview:self.detailView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OverViewCell" bundle:nil] forCellReuseIdentifier:oCell];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:oCell];
    [self.view addSubview:self.tableView];
}

-(void)addAutolayout{
    
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.left.width.height.mas_equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.left.mas_equalTo(self.menuButton.mas_right).offset(10);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@20);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(self.menuButton.mas_top);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(self.searchButton.mas_top);
        make.right.mas_equalTo(self.searchButton.mas_left).offset(-20);
    }];
    
    [self.magicController.magicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.mas_equalTo(@60);
        make.height.mas_equalTo(@40);
    }];
    
    [self.nView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.magicController.magicView.mas_bottom);
        make.height.mas_equalTo(@70);
    }];
    
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@100);
        make.top.mas_equalTo(self.nView.mas_bottom);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.detailView.mas_bottom);
    }];
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
    OverViewCell* cell = [tableView dequeueReusableCellWithIdentifier:oCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OverViewCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

-(NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView{
    return @[@"DAY",@"WEEK",@"MONTH"];
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex{
    UIButton* but = [[UIButton alloc]init];
    [but setTitle:@"123" forState:UIControlStateNormal];
    but.titleLabel.font = kFONT(14);
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return but;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex{
    UIViewController* vc = [[UIViewController alloc]init];
    
//    vc.view.backgroundColor = [UIColor greenColor];
    return vc;
}

#pragma UICollectionView 代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%ld",self.lists.count);
    return self.lists.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    nextCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:nCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"nextCollectionCell" owner:nil options:nil]lastObject];
    }
    
    cell.title.text = self.lists[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
