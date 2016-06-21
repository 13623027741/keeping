//
//  MyAnimation.h
//  keeping
//
//  Created by kaidan on 16/6/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;

- (instancetype)initWithPresenting:(BOOL)presenting;  

@end
