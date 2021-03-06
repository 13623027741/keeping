
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
#import "KSDatePicker.h"

@interface CreateController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIImageView* addImageView;

@property(nonatomic,strong)UIButton* addButton;

@property(nonatomic,strong)UITextField* addImageButton;

@property(nonatomic,strong)UILabel* dicriptionLabel;

@property(nonatomic,strong)UIButton* nextButton;

@property(nonatomic,strong)UIImageView* checkImageView;

@property(nonatomic,strong)MenuController* menu;

@property(nonatomic,strong)LZBBubbleTransition* transition;

@property(nonatomic,strong)KSDatePicker* datePicker;

@end
static NSString* CCell = @"cell";
@implementation CreateController

+(instancetype)getxCreateObject{
    static CreateController* create;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        create = [[CreateController alloc]init];
    });
    return create;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addSubView];
    
    [self addAutolayout];
    
    [self addTarger];
}

-(void)addSubView{
    
    self.datePicker = [[KSDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    
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
    self.titleLabel.font = kFONT(15);
    [self.view addSubview:self.titleLabel];
    
    self.addButton = [[UIButton alloc]init];
    [self.addButton setImage:[UIImage imageNamed:@"image_icon"] forState:UIControlStateNormal];
    [self.view addSubview:self.addButton];
    
    self.addImageView = [[UIImageView alloc]init];
    self.addImageView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:249/255.0 alpha:1];
    [self.view addSubview:self.addImageView];
    
    self.addImageButton = [[UITextField alloc]init];
    self.addImageButton.font = kFONT(25);
    self.addImageButton.textColor = [UIColor blackColor];
    self.addImageButton.textAlignment = NSTextAlignmentCenter;
    self.addImageButton.borderStyle = UITextBorderStyleNone;
    self.addImageButton.placeholder = @"Add Title";
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
        make.width.mas_equalTo(@300);
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
}

-(void)addTarger{
    @weakify(self);
    [[self.menuButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"打开菜单");
        @strongify(self);
        MenuController* menu = [[[NSBundle mainBundle]loadNibNamed:@"MenuController" owner:nil options:nil]lastObject];
        [self pushViewController:menu button:self.menuButton];
    }];
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
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self);
    CreateCell* cell = [tableView dequeueReusableCellWithIdentifier:CCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CreateCell" owner:nil options:nil]lastObject];
    }
    if (indexPath.row == 0) {
        cell.title.text = @"Date";
        cell.massage.text = @"";
        [[[cell.button rac_signalForControlEvents:UIControlEventTouchUpInside]
        throttle:0.3]
        subscribeNext:^(id x) {
            @strongify(self);
            self.datePicker.appearance.datePickerMode = UIDatePickerModeDateAndTime;
            [self.datePicker show];
            self.datePicker.appearance.resultCallBack = ^(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
                if (buttonType == KSDatePickerButtonCommit) {
                    NSLog(@"%@",currentDate);
                }
            };
        }];
    }else if (indexPath.row == 1){
        cell.title.text = @"Time";
        cell.massage.text = @"";
        
        
        
    }else if (indexPath.row == 2){
        cell.title.text = @"Location";
        cell.massage.text = @"";
    }else if (indexPath.row == 3){
        cell.title.text = @"Repeat";
        cell.massage.text = @"";
    }
    
    return cell;
}

/**
 *  取得自定义的时间字符串
 */
-(NSString*)getCustemDateWithDate:(NSDate*)date{
    
    NSDictionary* m = @{@"01":@"January",
                   @"02":@"February",
                   @"03":@"March",
                   @"04":@"April",
                   @"05":@"May",
                   @"06":@"June",
                   @"07":@"July",
                   @"08":@"August",
                   @"09":@"September",
                   @"10":@"October",
                   @"11":@"November",
                   @"12":@"December"};
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM";
    NSString* dateStr = [formatter stringFromDate:date];
    
    NSString* key = [dateStr substringWithRange:NSMakeRange(0, 2)];
    
    NSString* month = [m objectForKey:key];
    
    formatter.dateFormat = @"dd,yyyy";
    return [NSString stringWithFormat:@"%@ %@",month,[formatter stringFromDate:date]];
}

@end
