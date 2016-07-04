//
//  TextController.m
//  keeping
//
//  Created by kaidan on 16/6/29.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "TextController.h"
#import "KSDatePicker.h"
#import "OverViewController.h"
#import "overViewItemModel.h"
#import "FMData.h"

@interface TextController ()

@property(nonatomic,strong)UIBarButtonItem* leftItem;

@property(nonatomic,strong)UIBarButtonItem* rightItem;

@property(nonatomic,strong)UIButton* selectedTime;

@property(nonatomic,strong)UITextField* titleField;

@property(nonatomic,strong)UITextView* textView;

@property(nonatomic,strong)UIButton* rightButton;

@property(nonatomic,strong)NSString* currentDate;

@end

@implementation TextController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentDate = [NSString string];
    
    [self addView];
    
    [self addAutolayout];
    
    [self addTarger];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

-(void)addView{
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    leftButton.titleLabel.font = kFONT(15);
    [leftButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[leftButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = @"cube";
        transition.subtype = @"fromLeft";
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        [self.navigationController popViewControllerAnimated:NO];
    }];
    self.leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = self.leftItem;
    
    
    self.rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
    self.rightButton.titleLabel.font = kFONT(15);
    self.rightButton.enabled = NO;
    [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"Commit" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.type = @"cube";
        transition.subtype = @"fromLeft";
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController popViewControllerAnimated:NO];
        
        
        overViewItemModel* model = [[overViewItemModel alloc]init];
        model.title = self.titleField.text;
        model.massage = self.textView.text;
        model.isComplete = 0;
        model.timeStr = self.selectedTime.titleLabel.text;
        model.shiduan = self.currentDate;
        model.date = [overViewItemModel getNewDate];
        NSLog(@"---[%@]---%@---",[overViewItemModel getNewDate],model.shiduan);
        [FMData insertData:model];
        
    }];
    self.rightItem.enabled = NO;
    self.rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    self.selectedTime = [[UIButton alloc]init];
    self.selectedTime.layer.cornerRadius = 5;
    [self.selectedTime setTitle:@"Selected time" forState:UIControlStateNormal];
    self.selectedTime.titleLabel.font = kFONT(18);
    self.selectedTime.titleLabel.tintColor = [UIColor whiteColor];
    self.selectedTime.backgroundColor = kCOLOR_RGB(80, 210, 194);
    [self.view addSubview:self.selectedTime];
    
    self.titleField = [[UITextField alloc]init];
    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleField.placeholder = @"Title";
    self.titleField.font = kFONT(15);
    [self.view addSubview:self.titleField];
    
    self.textView = [[UITextView alloc]init];
    self.textView.font = kFONT(15);
    self.textView.backgroundColor = kCOLOR_RGB(240, 240, 240);
    self.textView.layer.cornerRadius = 5;
    self.textView.font = kFONT(15);
    [self.view addSubview:self.textView];
}

-(void)addAutolayout{
    [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.mas_equalTo(@84);
        make.height.mas_equalTo(@50);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.titleField);
        make.top.mas_equalTo(self.titleField.mas_bottom).offset(10);
        make.height.mas_equalTo(@200);
    }];
    
    [self.selectedTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.right.equalTo(self.titleField);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(10);
    }];
}
-(void)addTarger{
    @weakify(self);
    
    [[self.selectedTime rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        @strongify(self);
        KSDatePicker* date = [[KSDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
        date.appearance.datePickerMode = UIDatePickerModeTime;
        [date show];
        date.appearance.resultCallBack = ^(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType)
        {
            @strongify(self);
            if (buttonType == KSDatePickerButtonCommit) {
                NSLog(@"---%@---",currentDate);
                NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
                formatter.dateFormat = @"HH:mm";
                
                NSLog(@"%@",[formatter stringFromDate:currentDate]);
                
                [self.selectedTime setTitle:[formatter stringFromDate:currentDate] forState:UIControlStateNormal];
                
                formatter.dateFormat = @"aa";
                
                NSLog(@"%@",[formatter stringFromDate:currentDate]);
                
                [self changeRightItem];
                
                self.currentDate = [formatter stringFromDate:currentDate];
            }
        };
    }];
    
    
    
}

-(void)changeRightItem{
    @weakify(self);
    [[RACSignal combineLatest:@[RACObserve(self, titleField),RACObserve(self, textView),RACObserve(self, selectedTime)] reduce:^id{
        @strongify(self);
        NSLog(@"%ld----%ld----%ld",self.titleField.text.length,self.selectedTime.titleLabel.text.length,self.textView.text.length);
        return @(self.titleField.text.length > 0 && self.selectedTime.titleLabel.text.length < 12 && self.textView.text.length > 0);
    }]subscribeNext:^(NSNumber* value) {
        if ([value boolValue]) {
//            self.rightItem.enabled = YES;
            [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            self.rightItem.enabled = NO;
            [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
