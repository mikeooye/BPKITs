//
//  RFUpdownButton.h
//  LengJingYanZheng
//
//  Created by Haozhen Li on 15-1-9.
//  Copyright (c) 2015年 Refineit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPUpdownButton : UIControl

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


/**
 *  这里的图片会根据Control的highlighted变化而变化
 */
@property (retain, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViews;
@end
