//
//  TableCommonDelegate.h
//  AppExtension
//
//  Created by LOLITA on 18/1/6.
//  Copyright © 2018年 LOLITA. All rights reserved.
//

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "myModel.h"


@interface TableCommonDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic,assign) BOOL isWidget;

/**
 点击选择的数据
 */
@property (nonatomic,copy) void(^didSelectRowWithData)(NSDictionary* dic);

@end
