//
//  BPCollectionViewController.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPCollectionViewController.h"
#import "BPCollectionViewCell.h"

@implementation BPCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置item之间的间距
    _layout.minimumInteritemSpacing = 2;
    //设置行间距
    _layout.minimumLineSpacing = 6;
}

//section数量
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//每个section中item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 4;
    }
    return 6;
}

//设置item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CGFloat width = CGRectGetWidth(collectionView.frame);
        return CGSizeMake(width - 5, width * 0.5 - 5);
    }else if (indexPath.section == 1){
        
        CGFloat width = (CGRectGetWidth(collectionView.frame) - 18) * 0.5;
        return CGSizeMake(width, width);
    }else{
        
        CGFloat width = (CGRectGetWidth(collectionView.frame) - 24) / 3.0;
        return CGSizeMake(width, width);
    }
}

//设置section内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(10, 0, 5, 0);
    }else{
        return UIEdgeInsetsMake(10, 6, 5, 6);
    }
}
@end
