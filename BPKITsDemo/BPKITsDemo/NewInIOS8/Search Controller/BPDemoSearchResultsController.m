//
//  BPDemoSearchResultsController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/4.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPDemoSearchResultsController.h"

@interface BPDemoSearchResultsController ()

@property (assign, nonatomic) UISearchController *searchController;
@end

@implementation BPDemoSearchResultsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set red backgroundColor to mark this viewController is Visiable
    self.view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2];

    // add tap gesture and when tap self.view to cancel search (setActive:NO)
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSearch)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)cancelSearch
{
    if (self.searchController) {
        [self.searchController setActive:NO];
    }
}

#pragma mark - UISearchResultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // get the reference of the searchController
    self.searchController = searchController;
}
@end
