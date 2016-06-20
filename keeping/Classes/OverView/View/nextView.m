//
//  nextView.m
//  keeping
//
//  Created by kaidan on 16/6/17.
//  Copyright © 2016年 kaidan. All rights reserved.
//

#import "nextView.h"
#import "nextCollectionCell.h"
@interface nextView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
NSString* collectionCell = @"cell";
@implementation nextView



-(instancetype)init{
    if (self == [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"nextCollectionCell" bundle:nil] forCellWithReuseIdentifier:collectionCell];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    nextCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"nextCollectionCell" owner:nil options:nil] lastObject];
    }
    
    cell.title.text = self.lists[indexPath.row];
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"结束滚动");
    NSLog(@"----");
    
}

@end
