//
//  BPRefreshTableViewController.m
//  BPKITsDemo
//
//  Created by LiHaozhen on 15/2/24.
//  Copyright (c) 2015年 ihojin. All rights reserved.
//

#import "BPRefreshTableViewController.h"
#import "BPLoadingMore2Control.h"

@interface BPRefreshTableViewController ()<UITableViewDataSource, UITableViewDelegate>{
    
    NSInteger _rowCount;
    BPLoadingMore2Control *_loadingMoreControl;
}

@end

@implementation BPRefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableVIew.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [_tableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableVIew.delegate = self;
    _tableVIew.dataSource = self;
    
    _rowCount = 20;
    
    
    BPLoadingMore2Control *control = [[BPLoadingMore2Control alloc] init];
    [control addTarget:self action:@selector(tableDidLoadingMore) forControlEvents:UIControlEventValueChanged];
    [_tableVIew addSubview:control];
    
    _loadingMoreControl = control;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _loadingMoreControl.hasMore = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)tableDidLoadingMore
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"%s", __PRETTY_FUNCTION__);
        _rowCount+=20;
        
        [_tableVIew reloadData];
        [_loadingMoreControl endRefreshing];
    });
}

#pragma mark - TableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - TableDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *fmt = @"Section: %d, Row: %d";
    cell.textLabel.text = [NSString stringWithFormat:fmt, indexPath.section, indexPath.row];
    return cell;
}

@end
