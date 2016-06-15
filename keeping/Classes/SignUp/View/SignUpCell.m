//
//  SignUpCell.m
//  keeping
//
//  Created by kaidan on 16/6/15.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "SignUpCell.h"

@implementation SignUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textField.font = kFONT(17);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
