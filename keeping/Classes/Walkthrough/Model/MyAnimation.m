//
//  MyAnimation.m
//  keeping
//
//  Created by kaidan on 16/6/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "MyAnimation.h"

@implementation MyAnimation

-(instancetype)initWithPresenting:(BOOL)presenting{
    if (self == [super init]) {
        _presenting = presenting;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.presenting) {
        return .5;
    }
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
    if (self.presenting) {
        [self presentingAnimation:transitionContext];
    }
    else {
        [self dismissingAnimation:transitionContext];
    }
}


// 返回负责展示视图控制器的动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    MyAnimation* animator = [[MyAnimation alloc] initWithPresenting:YES];
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    MyAnimation* animator = [[MyAnimation alloc] initWithPresenting:NO];
    return animator;
}


// present视图控制器的自定义动画(modal出视图控制器)
- (void)presentingAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 通过字符串常量Key从转场上下文种获得相应的对象
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    // 要将toView添加到容器视图中
    [containerView addSubview:toView];
    
    // 自定义动画, 从中间开始进行y方向放大
    // 注意: 这边最好修改transform属性进行动画，否则视图中的子视图将不是你预期的动画效果
//    toView.transform = CGAffineTransformMakeScale(1.0, 0);
    toView.transform = CGAffineTransformMakeRotation(3);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        BOOL success = ![transitionContext transitionWasCancelled];
        
        // 注意:这边一定要调用这句否则UIKit会一直等待动画完成
        [transitionContext completeTransition:success];
    }];
}

// dissmiss视图控制器的自定义动画(关闭modal视图控制器)
- (void)dismissingAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 通过字符串常量Key从转场上下文种获得相应的对象
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    // 先把原来的视图添加回去
    [containerView insertSubview:toView atIndex:0];
    
    // 自定义动画, 从中间开始进行y方向缩小
    // 注意: 这边最好修改transform属性进行动画，否则视图中的子视图将不是你预期的动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = CGAffineTransformMakeScale(1.0, 0.001); //sy这边不能直接设置成0,否则看不出动画效果
    }
                     completion:^(BOOL finished){
                         BOOL success = ![transitionContext transitionWasCancelled];
                         
                         // 注意要把视图移除
                         [fromView removeFromSuperview];
                         
                         // 注意:这边一定要调用这句否则UIKit会一直等待动画完成
                         [transitionContext completeTransition:success];  
                     }];  
}

@end
