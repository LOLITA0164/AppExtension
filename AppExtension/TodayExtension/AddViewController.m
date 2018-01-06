//
//  AddViewController.m
//  AppExtension
//
//  Created by LOLITA on 18/1/6.
//  Copyright © 2018年 LOLITA. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(completedEvent)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.textView becomeFirstResponder];
}


-(void)completedEvent{
    NSString *content = self.textView.text;
    // 保存到NSUserDefaults里 group.com.LOLITA.appExtension
    if (content.length) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:content forKey:@"title"];
        [dic setValue:[self getCurrentDate] forKey:@"date"];
        NSArray *array = [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.LOLITA.appExtension"] valueForKey:@"myNote"];
        NSMutableArray *myNote = [NSMutableArray arrayWithArray:array];
        if (myNote==nil) {
            myNote = [NSMutableArray array];
        }
        [dic setValue:@(myNote.count) forKey:@"message_id"];
        [myNote insertObject:dic atIndex:0];
        // 重新存入
        [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.LOLITA.appExtension"] setValue:myNote forKey:@"myNote"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}





-(NSString *)getCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
