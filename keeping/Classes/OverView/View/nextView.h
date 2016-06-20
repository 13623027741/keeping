//
//  nextView.h
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nextView : UICollectionView

@property(nonatomic,strong)NSArray* lists;

@property(nonatomic,copy)void(^selectedRow)(NSInteger row);

@end
