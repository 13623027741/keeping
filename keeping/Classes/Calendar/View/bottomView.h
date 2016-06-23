//
//  bottomView.h
//  keeping
//
//  Created by kaidan on 16/6/21.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bottomView : UIView

@property(nonatomic,copy)void(^onTouch)(NSInteger tag);

@property(nonatomic,assign)CGFloat width;

@end
