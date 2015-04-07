//
//  BPCollectionViewController.h
//  BPKITsDemo
//
//  Created by Haozhen Li on 15-2-3.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>{
    
    __weak IBOutlet UICollectionView *_collectionView;
    __strong IBOutlet UICollectionViewFlowLayout *_layout;
}
@end
