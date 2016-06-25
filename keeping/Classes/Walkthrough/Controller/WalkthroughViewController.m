//
//  ViewController.m
//  GCCardViewController
//

#import "WalkthroughViewController.h"
#import "CardScrollView.h"
#import "MainController.h"
#import "HomeController.h"
#import "MyAnimation.h"

@interface WalkthroughViewController ()<CardScrollViewDelegate,CardScrollViewDataSource,UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) CardScrollView *cardScrollView;
@property (nonatomic, strong) NSMutableArray *cards;
@property(nonatomic,strong)UIPageControl* pageControl;

@property(nonatomic,strong)UIButton* but;
@end

@implementation WalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cardScrollView = [[CardScrollView alloc] initWithFrame:self.view.frame];
    self.cardScrollView.cardDelegate = self;
    self.cardScrollView.cardDataSource = self;
    self.cardScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cardScrollView];
    
    self.cards = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        [self.cards addObject:@(i)];
    }
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = kCOLOR_RGB(101, 99, 164);
    self.pageControl.pageIndicatorTintColor = kCOLOR_RGB(232, 232, 232);
    self.pageControl.numberOfPages = 3;
    [self.view addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@20);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    self.but = [[UIButton alloc]init];
    [self.but setTitle:@"START" forState:UIControlStateNormal];
    self.but.titleLabel.font = kFONT(11);
    self.but.backgroundColor = kCOLOR_RGB(80, 210, 194);
    self.but.layer.cornerRadius = 20;
    self.but.alpha = 0;
    [self.view addSubview:self.but];
    
    [self.but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@40);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(@30);
    }];
    
    [[self.but rac_signalForControlEvents:UIControlEventTouchUpInside]
    subscribeNext:^(id x) {
        NSLog(@"开启。。");
        
        
        
        MainController* mainVC = [[MainController alloc]initWithRootViewController:[[HomeController alloc]init]];
        
        mainVC.transitioningDelegate = self;
        
        [self presentViewController:mainVC animated:YES completion:nil];
        
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.cardScrollView loadCard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CardScrollViewDelegate
- (void)updateCard:(UIView *)card withProgress:(CGFloat)progress direction:(CardMoveDirection)direction {
    if (direction == CardMoveDirectionNone) {
        if (card.tag != [self.cardScrollView currentCard]) {
            CGFloat scale = 1 - 0.1 * progress;
            card.layer.transform = CATransform3DMakeScale(scale, scale, 1.0);
            card.layer.opacity = 1 - 0.2*progress;
        } else {
            card.layer.transform = CATransform3DIdentity;
            card.layer.opacity = 1;
        }
    } else {
        NSInteger transCardTag = direction == CardMoveDirectionLeft ? [self.cardScrollView currentCard] + 1 : [self.cardScrollView currentCard] - 1;
        if (card.tag != [self.cardScrollView currentCard] && card.tag == transCardTag) {
            card.layer.transform = CATransform3DMakeScale(0.9 + 0.1*progress, 0.9 + 0.1*progress, 1.0);
            card.layer.opacity = 0.8 + 0.2*progress;
        } else if (card.tag == [self.cardScrollView currentCard]) {
            card.layer.transform = CATransform3DMakeScale(1 - 0.1 * progress, 1 - 0.1 * progress, 1.0);
            card.layer.opacity = 1 - 0.2*progress;
        }
    }
    
//    NSLog(@"%ld",self.cardScrollView.currentCard);
    self.pageControl.currentPage = self.cardScrollView.currentCard;
    
    
    if (self.pageControl.currentPage == 2) {
        self.but.alpha = 1;
    }else{
        self.but.alpha = 0;
    }
}

#pragma mark - CardScrollViewDataSource
- (NSInteger)numberOfCards {
    return self.cards.count;
}

- (UIView *)cardReuseView:(UIView *)reuseView atIndex:(NSInteger)index {
    if (reuseView) {
        
        return reuseView;
    }
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 400)];
    imageView.layer.cornerRadius = 4;
    imageView.layer.masksToBounds = YES;
    switch (index) {
        case 0:
            imageView.image = [UIImage imageNamed:@"leftCard"];
            break;
        case 1:
            imageView.image = [UIImage imageNamed:@"mainCard"];
            break;
        case 2:
            imageView.image = [UIImage imageNamed:@"rightCard"];
            break;
        default:
            break;
    }
    
    
    
    return imageView;
}

- (void)deleteCardWithIndex:(NSInteger)index {
    [self.cards removeObjectAtIndex:index];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
//    CATransition* transition = [[CATransition alloc]init];
//    transition.type = @"push";
//    transition.duration = 1;
//    transition.removedOnCompletion = NO;
//    transition.fillMode = kCAFillModeForwards;
//    
    MyAnimation* animation = [[MyAnimation alloc]initWithPresenting:YES];
    
    return animation;
}

@end
