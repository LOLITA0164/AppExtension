//
//  AppDelegate.m
//  AppExtension
//
//  Created by LOLITA on 18/1/6.
//  Copyright © 2018年 LOLITA. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AddViewController.h"
#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window makeKeyWindow];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    
    self.window.rootViewController = nav;
    
    return YES;
}



- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    if ([url.absoluteString hasPrefix:@"AppExtension"]) {
        if ([url.absoluteString hasSuffix:@"add"]) {//判断是否是直接跳入到添加页面
            AddViewController *addCtrl = [AddViewController new];
            UINavigationController *rootNav = (UINavigationController*)self.window.rootViewController;
            [rootNav pushViewController:addCtrl animated:YES];
            
        }
        else if ([url.absoluteString containsString:@"detail"]){
            NSString *detail_MessageId = [[url.absoluteString componentsSeparatedByString:@"//"] lastObject];
            NSString *message_id = [[detail_MessageId componentsSeparatedByString:@"="] lastObject];
            DetailViewController *detailCtrl = [DetailViewController new];
            detailCtrl.title = message_id;
            UINavigationController *rootNav = (UINavigationController*)self.window.rootViewController;
            [rootNav pushViewController:detailCtrl animated:YES];
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
