//
//  AppDelegate.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()
{
    UINavigationController * nav;
    OPPCheckoutProvider * checkoutProvider;
    
}

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    sleep(2);
    
    BOOL isUpdateAvailable = [self isUpdateAvailable];
    
    if (isUpdateAvailable) {
        
        [self checkForUpdate];
    }
    
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[HomeVC alloc] init]];
    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
    LeftMenuViewController * rightMenuVC = [storyBoard instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    
    LeftMenuViewController *rightMenuViewController = [[LeftMenuViewController alloc] init];
    
    // Create side menu controller
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:rightMenuVC];
    sideMenuViewController.panGestureEnabled = NO;
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    
    // Make it a root controller
    //
    self.window.rootViewController = sideMenuViewController;
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    UIView *statusBar;
    if (@available(iOS 13, *)) {
        UIView *_localStatusBar = [[UIApplication sharedApplication].keyWindow.windowScene.statusBarManager performSelector:@selector(createLocalStatusBar)];
        statusBar = [_localStatusBar performSelector:@selector(statusBar)];
    }
    else {
        statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    }
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor blackColor];
    }
    
    if ([statusBar respondsToSelector:@selector(setForegroundColor:)]) {
        
    }
    
    SEL setForegroundColor_sel = NSSelectorFromString(@"setForegroundColor:");
    if([statusBar respondsToSelector:setForegroundColor_sel])
    {
        [statusBar performSelector:setForegroundColor_sel withObject:[UIColor whiteColor]];
    }

    
    NSString * userID = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER_ID"];
    if (userID.length>0) {
         if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"]isEqualToString:@"2"]) {
             
             
             
//             UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
//             RootViewController * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
//             nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
//             [nav setNavigationBarHidden:YES];
//
//             [self.window setRootViewController:nav];
//             [self.window makeKeyAndVisible];
             
             if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isSubscribed"]) {
                 
                  UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
                  RootViewController * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
                  nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
                  [nav setNavigationBarHidden:YES];
     
                  [self.window setRootViewController:nav];
                  [self.window makeKeyAndVisible];
             }else{
                 
                 UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
                 SubscriptionVC * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
                 viewObj.isFirstTime = YES;
                 nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
                 [nav setNavigationBarHidden:YES];
                 
                 [self.window setRootViewController:nav];
                 [self.window makeKeyAndVisible];
             }
             
             
         }else{
             
             if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isSubscribed"]) {
                 
                 UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 RootViewController * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
                 nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
                 [nav setNavigationBarHidden:YES];
                 
                 [self.window setRootViewController:nav];
                 [self.window makeKeyAndVisible];
             }else{
                 
                 UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 SubscriptionVC * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
                 viewObj.isFirstTime = YES;
                 nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
                 [nav setNavigationBarHidden:YES];
                 
                 [self.window setRootViewController:nav];
                 [self.window makeKeyAndVisible];
             }
             
             
             
//             UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//             RootViewController * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"RootViewController"];
//             nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
//             [nav setNavigationBarHidden:YES];
//
//             [self.window setRootViewController:nav];
//             [self.window makeKeyAndVisible];
         }
        
    }else{
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"]isEqualToString:@"2"]) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
            ChangeLanguageVC * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"ChangeLanguageVC"];
            nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
            [nav setNavigationBarHidden:YES];
            
            [self.window setRootViewController:nav];
            [self.window makeKeyAndVisible];
        }else{
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ChangeLanguageVC * viewObj = [storyBoard instantiateViewControllerWithIdentifier:@"ChangeLanguageVC"];
            nav = [[UINavigationController alloc] initWithRootViewController:viewObj];
            [nav setNavigationBarHidden:YES];
            
            [self.window setRootViewController:nav];
            [self.window makeKeyAndVisible];
        }
    }
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 20)];
    view.backgroundColor=[UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0f];
    [self.window.rootViewController.view addSubview:view];
    
//    id statusBarWindow = [[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
//    id statusBar = [statusBarWindow valueForKey:@"statusBar"];
//    SEL setForegroundColor_sel = NSSelectorFromString(@"setForegroundColor:");
//    if([statusBar respondsToSelector:setForegroundColor_sel])
//    {
//        [statusBar performSelector:setForegroundColor_sel withObject:[UIColor whiteColor]];
//    }
    // Override point for customization after application launch.
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
    
    [self checkForUpdate];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(AppDelegate *)getDelegate {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate;
}

-(void)sideMenu {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeVC *homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"HomeVC"];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    LeftMenuViewController *leftMenuVC = [storyBoard instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    
    RESideMenu *reSideMenu = [[RESideMenu alloc]initWithContentViewController:homeNav leftMenuViewController:leftMenuVC rightMenuViewController:leftMenuVC];
    UIWindow *window = [[UIWindow alloc]init];
    window.rootViewController = reSideMenu;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme caseInsensitiveCompare:@"com.iPrism.Biladl.payments"] == NSOrderedSame) {
        [checkoutProvider dismissCheckoutAnimated:YES completion:^{
            // request payment status
        }];
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    NSLog(@"url scheme:%@",url.scheme);
    
    BOOL handler = NO;
    
    if ([url.scheme caseInsensitiveCompare:@"com.iPrism.Biladl.payments"] ==  NSOrderedSame) {
        
        [NSNotificationCenter.defaultCenter postNotificationName:@"AsyncPaymentCompletedNotificationKey" object:nil];
        
        handler = YES;
        
    }
    
    return handler;
    
}

#pragma mark - CheckUpdate

-(void)checkForUpdate {
    
    BOOL update = [self isUpdateAvailable];
    
    if (update) {
        
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Update" message:@"There is an update available.\n Please update to use this App!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Ok action example
            NSString *iTunesLink = @"http://appstore.com/Biladl";
            //@"https://itunes.apple.com/us/app/biladl/id1462257989?mt=8&ign-mpt=uo%3D2";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            // Other action
        }];
        
        [alertCtrl addAction:otherAction];
        [alertCtrl addAction:okAction];
        
        UIWindow *alertWindow = [[UIWindow alloc]initWithFrame: [[UIScreen mainScreen] bounds]];
        alertWindow.rootViewController = [UIViewController new];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertCtrl animated:YES completion:nil];

    }
    
}

-(BOOL) isUpdateAvailable {
    
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier = bundleInfo[@"CFBundleIdentifier"];
    NSString *currentVersion = bundleInfo[@"CFBundleShortVersionString"];
    NSURL *lookupURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/lookup?bundleId=%@", bundleIdentifier]];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void) {
    
        NSData *lookupResults = [NSData dataWithContentsOfURL:lookupURL];
        if (!lookupResults) {
            // completion(NO, nil);
            return NO;
        }
        
        NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:lookupResults options:0 error:nil];
        
//        dispatch_async(dispatch_get_main_queue(), ^(void) {
            NSUInteger resultCount = [jsonResults[@"resultCount"] integerValue];
            if (resultCount){
                NSDictionary *appDetails = [jsonResults[@"results"] firstObject];
                NSString *appItunesUrl = [appDetails[@"trackViewUrl"] stringByReplacingOccurrencesOfString:@"&uo=4" withString:@""];
                NSString *latestVersion = appDetails[@"version"];
                
                if ([latestVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                    
                    return YES;
                    
                } else {
                    return NO;
                }
            } else {
                return NO;
            }
//        });
//    });
}



@end
