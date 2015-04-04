//
//  BPDemoSearchController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/4/4.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPDemoSearchController.h"
#import "BPDemoSearchResultsController.h"

@interface BPDemoSearchController ()

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) UISearchDisplayController *searchDisplayVC;
@end

@implementation BPDemoSearchController

- (void)viewDidLoad
{
/*
    //Old Api
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    UISearchDisplayController *searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchDisplayVC = searchDisplayController;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
//    searchDisplayController.displaysSearchBarInNavigationBar = YES;
    self.tableView.tableHeaderView = searchBar;
    [searchDisplayController.searchResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
 */


    //New Api in iOS 8
    BPDemoSearchResultsController *resultsController = [[BPDemoSearchResultsController alloc] init];
    UISearchController *searchController = [[UISearchController alloc]
                                            initWithSearchResultsController:resultsController];
    searchController.searchResultsUpdater = resultsController;
    searchController.dimsBackgroundDuringPresentation = YES;
    searchController.hidesNavigationBarDuringPresentation = NO;
    //缺少这句 searchBar高度为0，看不见效果
    [searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = YES;
    
    self.searchController = searchController;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.dataArray = [@[@"1", @"2", @"3", @"4", @"5"] mutableCopy];
}

#pragma mark - UISearchControllerDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
@end
