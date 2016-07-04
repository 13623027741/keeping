//
//  OverViewCell.h
//  keeping
//
//  Created by kaidan on 16/6/20.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *shiduanLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *massageLabel;

@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
