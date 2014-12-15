//
//  ViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 14/11/15.
//  Copyright (c) 2014年 ihojin. All rights reserved.
//

#import "ViewController.h"
#import "BPKITs.h"


@interface ViewController (){
    
    UIViewController *first;
    UIViewController *second;
    
    UIButton *_btn;
}

@property (strong, nonatomic) IBOutlet UIView *container;

- (IBAction)segChanged:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    first = [UIViewController new];
    first.view.backgroundColor = [UIColor blueColor];
    
    second = [UIViewController new];
    second.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 60)];
    btn.backgroundColor = [UIColor greenColor];
    [second.view addSubview:btn];
    
    btn.center = CGRectGetCenter(second.view.bounds);
    btn.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [btn addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchCancel];
    _btn = btn;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(addingBounds) withObject:nil afterDelay:0.1];
}

- (void)addingBounds
{
    [_btn.layer addAnimation:[BPAnimationCreater candyCrushBounceAnimationWithStartScale:1.0] forKey:@"candyCrash"];
}

- (void)buttonTouchDown:(UIButton *)btn
{
    [btn.layer removeAllAnimations];
    [btn.layer addAnimation:[[BPAnimationCreater bounceInAnimationWithDuration:0.5] setCompletion:^(BOOL finished) {
        
        if (finished) {
            btn.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8);
            [btn.layer addAnimation:[BPAnimationCreater candyCrushBounceAnimationWithStartScale:0.8] forKey:@"candyCrash"];
        }
        
    }] forKey:@"BounceIn"];
}

- (void)buttonTouchUp:(UIButton *)btn
{
    [btn.layer removeAllAnimations];
    [btn.layer addAnimation:[[BPAnimationCreater bounceOutAnimationWithDuration:0.5] setCompletion:^(BOOL finished) {

        if (finished) {
            btn.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
            [btn.layer addAnimation:[BPAnimationCreater candyCrushBounceAnimationWithStartScale:1.0] forKey:@"candyCrash"];
        }
    }] forKey:@"BounceOut"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segChanged:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
//        [self transitionToViewController:first container:_container duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve];
        
//        [self bpDismissViewController];
        [self bpPresentViewController:first size:CGSizeMake(300, 300)];
    }else{
//        [self transitionToViewController:second container:_container duration:0.3f options:UIViewAnimationOptionTransitionCrossDissolve];
//        [first bpDismissViewController];
        [self bpPresentViewController:second size:CGSizeMake(300, 300)];
//        second.view.layer.cornerRadius = 150;
//        second.view.layer.masksToBounds = YES;
        
        [self addingBounds];
        
//        [second.view.layer addAnimation:[BPAnimationCreater candyCrushBounceAnimation] forKey:@"candyCrushBounce"];
    }
}
@end
