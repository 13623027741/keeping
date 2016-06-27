//
//  SettingController.m
//  keeping
//
//  Created by kaidan on 16/6/24.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "SettingController.h"
#import "MenuController.h"
#import "KSDatePicker.h"
#import "SignUpCell.h"

@interface SettingController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIButton* menuButton;

@property(nonatomic,strong)UILabel* titleLabel;

@property(nonatomic,strong)UIButton* icon_button;

@property(nonatomic,strong)UIButton* logoutButton;

@property(nonatomic,strong)UIImageView* imgView;

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)NSString* date;

@property(nonatomic,strong)NSDictionary* month;

@property(nonatomic,strong)NSArray* titles;

@end
NSString* SCell = @"cell";
@implementation SettingController

+(instancetype)getSettingObject{
    static SettingController* setting;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting = [[SettingController alloc]init];
    });
    return setting;
}

-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"Name",@"Email",@"Password",@"Birthday"];
    }
    return _titles;
}

-(NSDictionary *)month{
    if (!_month) {
        _month = @{@"01":@"January",
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
    }
    return _month;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addView];
    
    [self addAutolayout];
    
    [self addTarger];
}

-(void)addView{
    
    self.menuButton = [[UIButton alloc]init];
    [self.menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [self.view addSubview:self.menuButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = kFONT(15);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"Settings";
    [self.view addSubview:self.titleLabel];
    
    self.icon_button = [[UIButton alloc]init];
    [self.icon_button setImage:[UIImage imageNamed:@"image_icon"] forState:UIControlStateNormal];
    [self.view addSubview:self.icon_button];
    
    self.logoutButton = [[UIButton alloc]init];
    [self.logoutButton setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [self.view addSubview:self.logoutButton];
    
    self.imgView = [[UIImageView alloc]init];
    self.imgView.image = [UIImage imageNamed:@"icon_img"];
    [self.view addSubview:self.imgView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SignUpCell" bundle:nil] forCellReuseIdentifier:SCell];
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor orangeColor];
}

-(void)addAutolayout{
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(@20);
        make.left.mas_equalTo(@20);
        make.top.mas_equalTo(@30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@20);
        make.left.mas_equalTo(self.menuButton.mas_right);
    }];
    
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@30);
        make.width.height.mas_equalTo(@20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
    }];
    
    [self.icon_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.logoutButton);
        make.right.mas_equalTo(self.logoutButton.mas_left).offset(-20);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(@100);
        make.top.mas_equalTo(@85);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.mas_equalTo(@210);
    }];
}

-(void)addTarger{
    
}

#pragma mark - 代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SignUpCell* cell = [tableView dequeueReusableCellWithIdentifier:SCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SignUpCell" owner:nil options:nil]lastObject];
    }
    
    cell.title.text = self.titles[indexPath.row];
    cell.textField.tag = 100 + indexPath.row;
    
    if (indexPath.row == 3) {
        cell.textField.alpha = 0;
        if (self.date.length > 0) {
            cell.textField.text = self.date;
            cell.textField.alpha = 1;
        }
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    if (indexPath.row == 3) {
        
        UITextField* textField = [self.tableView viewWithTag:(100 + indexPath.row)];
        [textField resignFirstResponder];
        KSDatePicker* date = [[KSDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
        [date show];
        
        @weakify(self);
        
        date.appearance.resultCallBack = ^(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType)
        {
            @strongify(self);
            textField.alpha = 1;
            NSLog(@"%@",[self getCustemDateWithDate:currentDate]);
            textField.text = [self getCustemDateWithDate:currentDate];
            self.date = textField.text;
            
        };
    }else if (indexPath.row == 2){
        UITextField* textField = [self.tableView viewWithTag:(100 + indexPath.row)];
        textField.secureTextEntry = YES;
    }
}
/**
 *  取得自定义的时间字符串
 */
-(NSString*)getCustemDateWithDate:(NSDate*)date{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"MM";
    NSString* dateStr = [formatter stringFromDate:date];
    
    NSString* key = [dateStr substringWithRange:NSMakeRange(0, 2)];
    
    NSString* month = [self.month objectForKey:key];
    
    formatter.dateFormat = @"dd,yyyy";
    return [NSString stringWithFormat:@"%@ %@",month,[formatter stringFromDate:date]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
