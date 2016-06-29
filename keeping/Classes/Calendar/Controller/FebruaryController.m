//
//  FebruaryController.m
//  keeping
//
//  Created by kaidan on 16/6/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "FebruaryController.h"
#import "bottomView.h"
#import "OverViewCell.h"
#import "JinnPopMenu.h"
#import "CalendarCell.h"
#import "headView.h"
#import "FebruaryTool.h"
#import "MenuController.h"
#import "LZBBubbleTransition.h"

@interface FebruaryController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,JinnPopMenuDelegate>

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* selectorDate;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UIImageView* icon_imageView;

@property(nonatomic,strong)headView* headview;

@property(nonatomic,strong)UICollectionView* collectionView;

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)bottomView* bottom_View;

@property(nonatomic,strong)MenuController* menu;

@property(nonatomic,strong)NSArray* month;

@property(nonatomic,assign)NSInteger CurrentDay;

@property(nonatomic,assign)NSInteger dayCount;

@property(nonatomic,strong)NSDictionary* weeks;

@property(nonatomic,assign)NSInteger currentWeekDay;

@property(nonatomic,strong)LZBBubbleTransition* transition;

@end


//320  568

NSString* CCell = @"cell";
NSString* TCell = @"cell";
NSInteger tag = 1;
int i = 1;
@implementation FebruaryController

+(instancetype)getxCalendarObject{
    static FebruaryController* february;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        february = [[FebruaryController alloc]init];
    });
    return february;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.CurrentDay = [FebruaryTool getCurrentDay] ;
    
    self.dayCount = [FebruaryTool getMonthDays:[FebruaryTool getCurrentMonth] year:[FebruaryTool getCurrentYear]];
    self.currentWeekDay = [FebruaryTool getWeekWithDay];
    
    self.month = @[@"January",
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
    
    self.weeks = @{@"星期日":@(0),
                   @"星期一":@(1),
                   @"星期二":@(2),
                   @"星期三":@(3),
                   @"星期四":@(4),
                   @"星期五":@(5),
                   @"星期天":@(6)
                   };
    
    [self addSubView];
    
    [self addAutolayout];
    
    [self addTarger];
    
    [FebruaryTool getWeekWithDay];
}

-(void)addSubView{
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"February";
    self.titleLabel.font = kFONT(15);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.selectorDate = [[UIButton alloc]init];
    [self.selectorDate setImage:[UIImage imageNamed:@"Dislosure"] forState:UIControlStateNormal];
    [self.view addSubview:self.selectorDate];
    
    self.addButton = [[UIButton alloc]init];
    [self.addButton setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    
    self.icon_imageView = [[UIImageView alloc]init];
    self.icon_imageView.image = [UIImage imageNamed:@"calendar_icon"];
    self.icon_imageView.layer.cornerRadius = 15;
    [self.view addSubview:self.icon_imageView];
    
    self.headview = [[headView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.width / 7)];
    self.headview.backgroundColor = kCOLOR_RGB(101, 99, 164);
    [self.view addSubview:self.headview];
    
    UICollectionViewFlowLayout* flow = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = kSCREEN_SIZE.width / 7;
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    NSLog(@"--%g--",width);
    flow.itemSize = CGSizeMake(width,width);
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //CGRectMake(0, 60, kSCREEN_SIZE.width,200)
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flow];
//    self.collectionView.alpha = 0;
    self.collectionView.backgroundColor = kCOLOR_RGB(101, 99, 164);
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"CalendarCell" bundle:nil] forCellWithReuseIdentifier:CCell];
    
    [self.view addSubview:self.collectionView];
    //CGRectMake(0, 260, kSCREEN_SIZE.width, 248)
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OverViewCell" bundle:nil] forCellReuseIdentifier:TCell];
    [self.view addSubview:self.tableView];
    
    self.bottom_View = [[[NSBundle mainBundle]loadNibNamed:@"bottomView" owner:nil options:nil]lastObject];
    self.bottom_View.width =  self.view.bounds.size.width;
//    [self.view addSubview:self.bottom_View];
    
}

-(void)addAutolayout{
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.width.height.mas_equalTo(@20);
        make.left.mas_equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
        make.left.mas_equalTo(self.menuButton.mas_right).offset(10);
    }];
    
    [self.selectorDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
        make.left.mas_equalTo(self.titleLabel.mas_right);
    }];
    
    [self.icon_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(@25);
        make.width.height.mas_equalTo(@30);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
        make.right.mas_equalTo(self.icon_imageView.mas_left).offset(-20);
    }];
    
//    [self.bottom_View mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.height.mas_equalTo(@60);
//    }];
//
    [self.headview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@60);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(kSCREEN_SIZE.width / 7));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.mas_equalTo(self.headview.mas_bottom);
        make.height.mas_equalTo(@230);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

-(void)addTarger{
    @weakify(self);
    [[self.selectorDate rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        @strongify(self);
        [self labelButtonClicked];
    }];
    
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        MenuController* vc = [[[NSBundle mainBundle]loadNibNamed:@"MenuController" owner:nil options:nil]lastObject];
        [self pushViewController:vc button:self.menuButton];
    }];
    
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc]init];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [swipe.rac_gestureSignal subscribeNext:^(id x) {
        NSLog(@"激发手势");
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.8;
        transition.type = @"cube";
        transition.subtype = @"fromBottom";
        
        self.tabBarController.selectedIndex = 0;
        
        [self.tabBarController.view.layer addAnimation:transition forKey:nil];
        
        
    }];
    [self.view addGestureRecognizer:swipe];
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

#pragma mark - UICollectionView 代理

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 35;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CalendarCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CCell forIndexPath:indexPath];
    cell.titleLabel.text = @"";
    cell.imgView.alpha = 0;
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CalendarCell" owner:nil options:nil]lastObject];
    }
    
    if (indexPath.row == self.CurrentDay) {
        cell.backgroundColor = kCOLOR_RGB(80, 210, 194);
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    
    
    if (self.currentWeekDay <= indexPath.row) {
        if ((indexPath.row - self.currentWeekDay) < self.dayCount) {
            cell.titleLabel.text = [NSString stringWithFormat:@"%d",i];
            cell.imgView.alpha = 1;
            i ++;
        }
        
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    i = 1;
    self.CurrentDay = indexPath.row;
    NSLog(@"%ld",indexPath.row);
    [collectionView reloadData];
}

#pragma mark - UITableView 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:TCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OverViewCell" owner:nil options:nil]lastObject];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - JinnPopMenuItem
- (void)labelButtonClicked
{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.month.count; i++)
    {
        UIColor* color = [UIColor blackColor];
        JinnPopMenuItem *popMenuItem = [[JinnPopMenuItem alloc] initWithTitle:self.month[i] titleColor:color];
        [popMenuItem.itemLabel.layer setCornerRadius:40];
        [popMenuItem.itemLabel setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.8]];
        [items addObject:popMenuItem];
    }
    
    JinnPopMenu *popMenu = [[JinnPopMenu alloc] initWithPopMenus:[items copy]];
    [popMenu setShouldHideWhenBackgroundTapped:YES];
    popMenu.backgroundView.backgroundColor = kCOLOR_RGB(101, 99, 164);
    [popMenu setItemSize:CGSizeMake(80, 80)];
    [popMenu setDelegate:self];
    [self.view addSubview:popMenu];
    [popMenu showAnimated:YES];
    [popMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
}


#pragma mark -  JinnPopMenuDelegate 代理
- (void)itemSelectedAtIndex:(NSInteger)index popMenu:(JinnPopMenu *)popMenu
{
    i  = 1;
    NSLog(@"%@",self.month[index]);
    self.titleLabel.text = self.month[index];
    if (popMenu.tag != 10000)
    {
        [popMenu dismissAnimated:NO];
    }
    
    self.dayCount = [FebruaryTool getMonthDays:(index + 1) year:[FebruaryTool getCurrentYear]];
    self.currentWeekDay = [FebruaryTool getWeekDayWithMonth:index + 1];
    
    [self.collectionView reloadData];
}



- (void)didReceiveMemoryWarning {
    
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
