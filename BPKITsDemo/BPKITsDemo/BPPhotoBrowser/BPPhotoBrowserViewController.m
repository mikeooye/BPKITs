//
//  BPPhotoBrowserViewController.m
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-1-20.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPPhotoBrowserViewController.h"
#import "MWPhotoBrowser.h"


@interface BPPhotoBrowserViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, MWPhotoBrowserDelegate>{
    
    NSArray *_items;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation BPPhotoBrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _items = @[@"photo1", @"photo2", @"photo3", @"photo4", @"photo5", @"photo6", @"photo7", @"photo8"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:99];
    NSString *name = [[_items objectAtIndex:indexPath.item] stringByAppendingString:@"t.jpg"];
    [imageView setImage:[UIImage imageNamed:name]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MWPhotoBrowser *_browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [_browser setCurrentPhotoIndex:indexPath.item];
    [self.navigationController pushViewController:_browser animated:YES];
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    NSString *name = [[_items objectAtIndex:index] stringByAppendingString:@".jpg"];
    MWPhoto *photo = [[MWPhoto alloc] initWithImage:[UIImage imageNamed:name]];
    return photo;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _items.count;
}
@end
