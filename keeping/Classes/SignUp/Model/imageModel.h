//
//  imageModel.h
//  keeping
//
//  Created by kaidan on 16/7/7.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface imageModel : NSObject

@property(nonatomic,strong)UIImage* image;

@property(nonatomic,copy)NSString* imageName;

@property(nonatomic,strong)NSURL* url;

@end
