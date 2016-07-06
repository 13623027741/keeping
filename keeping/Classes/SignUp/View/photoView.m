
//
//  photoView.m
//  keeping
//
//  Created by kaidan on 16/7/6.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "photoView.h"

@implementation photoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
