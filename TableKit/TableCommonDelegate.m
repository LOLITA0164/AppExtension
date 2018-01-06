//
//  TableCommonDelegate.m
//  AppExtension
//
//  Created by LOLITA on 18/1/6.
//  Copyright © 2018年 LOLITA. All rights reserved.
//

#import "TableCommonDelegate.h"
@interface TableCommonDelegate ()
@end

@implementation TableCommonDelegate

- (instancetype)init {
    if (self = [super init]) {
        self.data = [NSMutableArray array];
        [self loadData];
    }
    return self;
}

- (void)loadData {
    [self.data removeAllObjects];
    NSArray *myNote = [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.LOLITA.appExtension"] valueForKey:@"myNote"];
    if (myNote) {
        [self.data addObjectsFromArray:myNote];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [self loadData];
    if (self.isWidget) {
        return MIN(self.data.count, 3); // 最多3个
    }
    return self.data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        NSBundle *bundle = [NSBundle bundleForClass:[TableViewCell class]];
        NSArray *cells = [bundle loadNibNamed:@"TableViewCell" owner:@"TableKit" options:nil];
        cell = cells.firstObject;
    }
    NSDictionary *itemDic = self.data[indexPath.row];
    cell.titleLabel.text = [itemDic objectForKey:@"title"]?[itemDic objectForKey:@"title"]:@"-";
    cell.dateLabel.text = [itemDic objectForKey:@"date"]?[itemDic objectForKey:@"date"]:@"xxxx.xx.xx";
    NSInteger value = arc4random_uniform(4 + 1);
    NSString *iconString = [NSString stringWithFormat:@"%ld",value];
    cell.iconImageView.image = [UIImage imageNamed:iconString];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *itemDic = self.data[indexPath.row];
    if (self.didSelectRowWithData) {
        self.didSelectRowWithData(itemDic);
    }
}



@end
