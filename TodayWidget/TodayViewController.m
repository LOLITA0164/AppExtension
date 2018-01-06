//
//  TodayViewController.m
//  TodayWidget
//
//  Created by LOLITA on 18/1/6.
//  Copyright © 2018年 LOLITA. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TableCommonDelegate.h"

@interface TodayViewController () <NCWidgetProviding>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (nonatomic,strong) UIButton *moreBtn;

@property (nonatomic,strong) TableCommonDelegate *delegate;

@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = [[TableCommonDelegate alloc] init];
    self.delegate.isWidget = YES;
    self.table.delegate = self.delegate;
    self.table.dataSource = self.delegate;
    self.table.tableFooterView = [UIView new];
    WS(ws);
    [self.delegate setDidSelectRowWithData:^(NSDictionary *dic) {
        NSString *urlString = [NSString stringWithFormat:@"AppExtension://detail=%@",[dic objectForKey:@"message_id"]];
        [ws.extensionContext openURL:[NSURL URLWithString:urlString] completionHandler:nil];
    }];
    
    self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    
    [self.view addSubview:self.moreBtn];
}


-(UIButton *)moreBtn{
    if (_moreBtn==nil) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, self.delegate.data.count * 110 + 10, self.table.frame.size.width - 70*2, 30)];
        _moreBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_moreBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [_moreBtn setTitle:@"添加更多" forState:UIControlStateNormal];
        _moreBtn.layer.cornerRadius = 3;
        _moreBtn.layer.masksToBounds = YES;
        [_moreBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_moreBtn addTarget:self action:@selector(moreBtnClickEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}


- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}


- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        NSInteger count = MIN(self.delegate.data.count, 3);
        self.preferredContentSize = CGSizeMake(0, 110*count + 50);
    }else{
        self.preferredContentSize = maxSize;
    }
}


-(void)moreBtnClickEvent{
    [self.extensionContext openURL:[NSURL URLWithString:@"AppExtension://add"] completionHandler:nil];
}

@end
