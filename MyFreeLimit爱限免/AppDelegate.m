//
//  AppDelegate.m
//  MyFreeLimit爱限免
//
//  Created by qianfeng on 14-9-2.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "AppDelegate.h"



#import "VCSpecial.h"
#import "VCRoot.h"
#import "FreeLimitViewController.h"
#import "FreeViewController.h"
#import "HotViewController.h"
#import "SalesViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self creatViewControllers];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)creatViewControllers
{
    NSArray* arrClassName=[NSArray arrayWithObjects:@"FreeLimitViewController",@"FreeViewController",@"SalesViewController",@"HotViewController",@"VCSpecial",nil];
    NSArray* arrTitle=[NSArray arrayWithObjects:@"限免",@"免费",@"促销",@"热榜",@"专题",nil];
    NSArray* barItemStr=[NSArray arrayWithObjects:@"限免",@"免费",@"降价",@"热点",@"专题",nil];
    
    NSMutableArray* arrControllers=[[NSMutableArray alloc]init];
    
    for (int i=0; i<5; i++) {
        NSString* strClass=[arrClassName objectAtIndex:i];
        Class vcClass=NSClassFromString(strClass);
        UIViewController* vc=(UIViewController*)[[vcClass alloc]init];
        vc.title=[arrTitle objectAtIndex:i];
        
        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:vc];
        
        NSString* barStr=[barItemStr objectAtIndex:i];
        UITabBarItem* barItem=[[UITabBarItem alloc]initWithTitle:barStr image:[UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_正常",barStr]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn_%@_点击",barStr]]];
        nav.tabBarItem=barItem;
        
        [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Cochin" size:20],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
        
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"6.应用详情_0.png"] forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.translucent=NO;
        
        [arrControllers addObject:nav];
    }
    
    NSLog(@"%@",NSHomeDirectory());
    VCRoot* root=[[VCRoot alloc]init];
    root.viewControllers=arrControllers;
    self.window.rootViewController=root;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
