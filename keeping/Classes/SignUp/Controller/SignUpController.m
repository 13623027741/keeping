//
//  SignUpController.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "SignUpController.h"
#import "SignUpCell.h"
#import "KSDatePicker.h"
// 101 99 164
@interface SignUpController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray* titles;

@property(nonatomic,strong)NSDictionary* month;

@property(nonatomic,strong)NSString* date;

@end
static NSString* signUpcell = @"cell";
@implementation SignUpController

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
    
    self.date = [NSString string];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.signUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [[self.signUpButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.checkButton.backgroundColor = [UIColor colorWithRed:101/255.0 green:99/255.0 blue:164/255.0 alpha:1];
    [self.tableView registerNib:[UINib nibWithNibName:@"SignUpCell" bundle:nil] forCellReuseIdentifier:signUpcell];
    
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.addPhoto.layer.cornerRadius = 50;
    
    [[self.addPhoto rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        
    }];
    
    [[self.checkButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        
    }];
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
    // Dispose of any resources that can be recreated.
}

@end
