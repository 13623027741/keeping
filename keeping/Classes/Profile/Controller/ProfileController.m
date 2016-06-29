//
//  OverViewController.m
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "ProfileController.h"
#import "CutemView.h"
#import "ProfileCell.h"
#import "MenuController.h"
@interface ProfileController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* editButton;

@property(nonatomic,strong)UIImageView* iconView;

@property(nonatomic,strong)UILabel* infoLabel;

@property(nonatomic,strong)UILabel* massage;

@property(nonatomic,strong)CutemView* detailView;

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)LZBBubbleTransition* transition;


@end
static NSString* PCell = @"cell";

@implementation ProfileController


+(instancetype)getProfileObject{
    static ProfileController* profile;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        profile = [[ProfileController alloc]init];
    });
    return profile;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubView];
    
    [self addAutolayout];
    
    [self addTarger];
}



-(void)addSubView{
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"Profile";
    self.titleLabel.font = kFONT(15);
    [self.view addSubview:self.titleLabel];
    
    self.editButton = [[UIButton alloc]init];
    [self.editButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.view addSubview:self.editButton];
    
    self.iconView = [[UIImageView alloc]init];
    self.iconView.layer.cornerRadius = 50;
    self.iconView.image = [UIImage imageNamed:@"icon_img"];
    [self.view addSubview:self.iconView];
    
    self.infoLabel = [[UILabel alloc]init];
    self.infoLabel.text = @"Good Job,Marie!";
    self.infoLabel.textAlignment = NSTextAlignmentCenter;
    self.infoLabel.textColor = [UIColor blackColor];
    self.infoLabel.font = kFONT(20);
    [self.view addSubview:self.infoLabel];
    
    self.massage = [[UILabel alloc]init];
    self.massage.text = @"You haven’t missed any tasks this week.";
    self.massage.font = kFONT(14);
    self.massage.textAlignment = NSTextAlignmentCenter;
    self.massage.textColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:170/255.0 alpha:1];
    
    [self.view addSubview:self.massage];
    
    self.detailView = [[CutemView alloc]init];
    self.detailView.leftCount = 50;
    self.detailView.rightCount = 10;
    [self.view addSubview:self.detailView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:PCell];
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
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(self.menuButton.mas_top);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.width.mas_equalTo(@100);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.height.mas_equalTo(@30);
        make.top.mas_equalTo(self.iconView.mas_bottom);
    }];
    
    [self.massage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@20);
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.infoLabel.mas_bottom);
    }];
    
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@100);
        make.top.mas_equalTo(self.massage.mas_bottom).offset(10);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(self.detailView.mas_bottom);
    }];
}

-(void)addTarger{
    @weakify(self);
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        @strongify(self);
        MenuController* menu = kBOUNDLE_SOURCE(@"MenuController");
        [self pushViewController:menu button:self.menuButton];
    }];
    
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc]init];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [swipe.rac_gestureSignal subscribeNext:^(id x) {
        NSLog(@"向下激发手势");
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.8;
        transition.type = @"cube";
        transition.subtype = @"fromTop";
        
        self.tabBarController.selectedIndex = 4;
        
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
        
        self.tabBarController.selectedIndex = 2;
        
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
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCell* cell = [tableView dequeueReusableCellWithIdentifier:PCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ProfileCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
