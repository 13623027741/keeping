
//
//  CreateCell.m
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "CreateCell.h"

@implementation CreateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.title.textColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:194/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
