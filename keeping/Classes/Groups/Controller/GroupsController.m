//
//  GroupsController.m
//  keeping
//
//  Created by kaidan on 16/6/16.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "GroupsController.h"
#import "GroupsCell.h"
#import "MenuController.h"
#import "MenuController.h"

@interface GroupsController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UIButton* searchButton;

@property(nonatomic,strong)MenuController* menu;

@property(nonatomic,strong)LZBBubbleTransition* transition;

@end
static NSString* gCell = @"cell";
@implementation GroupsController

+(instancetype)getGroupsObject{
    static GroupsController* groups;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        groups = [[GroupsController alloc]init];
    });
    return groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubView];
    [self addAutoLayout];
    [self addTarger];
    
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
    self.titleLabel.font = kFONT(15);
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

-(void)addTarger{
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"弹出菜单");
        
        MenuController* menu = [[[NSBundle mainBundle]loadNibNamed:@"MenuController" owner:nil options:nil]lastObject];
        [self pushViewController:menu button:self.menuButton];
    }];
    
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"添加一项提醒");
    }];
    
    [[self.searchButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"查找");
    }];
    
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc]init];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [swipe.rac_gestureSignal subscribeNext:^(id x) {
        NSLog(@"向下激发手势");
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.8;
        transition.type = @"cube";
        transition.subtype = @"fromTop";
        
        self.tabBarController.selectedIndex = 3;
        
        [self.tabBarController.view.layer addAnimation:transition forKey:nil];
        
        
    }];
    
    [self.view addGestureRecognizer:swipe];
    
    
    UISwipeGestureRecognizer* swipe1 = [[UISwipeGestureRecognizer alloc]init];
    swipe1.direction = UISwipeGestureRecognizerDirectionDown;
    [swipe1.rac_gestureSignal subscribeNext:^(id x) {
        NSLog(@"向上激发手势");
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.8;
        transition.type = @"cube";
        transition.subtype = @"fromBottom";
        
        self.tabBarController.selectedIndex = 1;
        
        [self.tabBarController.view.layer addAnimation:transition forKey:nil];
        
        
    }];
    
    [self.view addGestureRecognizer:swipe1];
    
}

-(void)pushViewController:(UIViewController*)viewController button:(UIButton*)button{
    
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    
    self.transition = [[LZBBubbleTransition alloc]initWithPresent:^(UIViewController *presented, UIViewController *presenting, UIViewController *sourceVC, LZBBaseTransition *transition) {
        LZBBubbleTransition  *bubble = (LZBBubbleTransition *)transition;
        //设置动画的View
        bubble.targetView = button;
        //设置弹簧属性
        bubble.bounceIsEnable = YES;
    } Dismiss:^(UIViewController *dismissVC, LZBBaseTransition *transition) {
        
    }];
    viewController.transitioningDelegate = self.transition;
    [self presentViewController:viewController animated:YES completion:nil];
    
}


#pragma mark - 代理


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupsCell* cell = [tableView dequeueReusableCellWithIdentifier:gCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"GroupsCell" owner:nil options:nil]lastObject];
    }
    
//    cell.title.text = @"Food";
    
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
