//
//  ViewController.m
//  AppExtension
//
//  Created by LOLITA on 18/1/6.
//  Copyright © 2018年 LOLITA. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "TableCommonDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) UITableView *table;
@property (nonatomic,strong) TableCommonDelegate *delegate;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


/// !!!: 初始化UI
-(void)initUI{
    self.title = @"TodayExtension";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.table];
}


#pragma mark - 初始化控件

-(UITableView *)table{
    if (_table==nil) {
        _table = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
        self.delegate = [[TableCommonDelegate alloc] init];
        _table.delegate = self.delegate;
        _table.dataSource = self.delegate;
        _table.tableFooterView = [UIView new];
    }
    return _table;
}


#pragma mark - 点击事件

-(void)addEvent{
    AddViewController *ctrl = [AddViewController new];
    [self.navigationController pushViewController:ctrl animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
