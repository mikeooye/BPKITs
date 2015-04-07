//
//  BPImageWithColorViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/3/7.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPImageWithColorViewController.h"
#import "UIImage+bpExtension.h"

@implementation BPImageWithColorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    
//    tmpImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ImageSelectedOn"]];
//    [self.view addSubview:tmpImageView];
//    tmpImageView.backgroundColor = [UIColor blueColor];
//    
//    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (IBAction)actionToFillColor:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Color" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"TintColor" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [tmpImageView setImage:[tmpImageView.image imageWithGradientTintColor:[UIColor redColor]]];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"MaskColor" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [tmpImageView setImage:[tmpImageView.image imageWithMaskColor:[UIColor redColor]]];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
