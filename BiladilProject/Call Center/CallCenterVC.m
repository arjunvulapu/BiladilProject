//
//  CallCenterVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CallCenterVC.h"
#import "AppDelegate.h"

@interface CallCenterVC ()

@end

@implementation CallCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnBlur.hidden = YES;
    
    [self service_checkSubscribe];
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnCallSupportAction:(id)sender {
    //    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *phNo = [defaults valueForKey:@"DRIVER_MOBILE"];
    _btnBlur.hidden = NO;
    NSString *phNo = @"1(123)4567890";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl options:@{} completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"Opened url");
            }
        }];
    }
}

-(void)service_checkSubscribe{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_current_package" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                
                
                if ([[result valueForKey:@"status"]intValue] == 0)
                {
                    /*
                    SubscribePopUpVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscribePopUpVC"];
                    
                    viewObj.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    viewObj.modalPresentationStyle = UIModalPresentationOverCurrentContext;//UIModalPresentationPopover;
                    
                    [self presentViewController:viewObj animated:YES completion:nil];
//                    [self.navigationController pushViewController:viewObj animated:NO];
                    
                    */
                    NSString* lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
                    if ([lang isEqualToString:@"1"]){
                    
                        [self subscriptionAlert_English];
                    }else{
                        [self subscriptionAlert_Arabic];
                    }
                    
                }

                if ([[result valueForKey:@"status"]intValue] == 1) {
//                    selectPlanArray = [[result valueForKey:@"response"]valueForKey:@"package_details"];
                    
//                    NSLog(@"Package details array --> %@",selectPlanArray);
                    
//                    if (selectPlanArray.count>0) {
//                        //                        [self.subcriptionCollectionView reloadData];
//                    }
//
//                    NSLog(@"Subscription Data---> %@",selectPlanArray);
//
//                    self.txtView_AboutPlan.text = [selectPlanArray valueForKey:@"description"];
                    
                }else{
//                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
//                    [t show];
                }
            }
        });
    }];
}

-(void)subscriptionAlert_English{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Subscription"
                                                                   message:@"Your package is expired or your not subscribed any package yet!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action_JoinNow = [UIAlertAction actionWithTitle:@"Join Now" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
                                                              viewObj.delegate = self;
                                                              viewObj.commingFrom = @"POP_UP";
                                                              
                                                            [self.navigationController pushViewController:viewObj animated:YES];
                                                              
                                                          }];
    
    UIAlertAction* action_Close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               HomeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                                                               [self.navigationController pushViewController:viewObj animated:YES];
                                                           }];
    [alert addAction:action_Close];
    [alert addAction:action_JoinNow];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)subscriptionAlert_Arabic{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"اشتراك"
                                                                   message:@"انتهت صلاحية الحزمة الخاصة بك أو لم تقم بالاشتراك في أي حزمة حتى الآن!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action_JoinNow = [UIAlertAction actionWithTitle:@"نضم الان" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
                                                               viewObj.delegate = self;
                                                               viewObj.commingFrom = @"POP_UP";
                                                               
                                                               [self.navigationController pushViewController:viewObj animated:YES];
                                                               
                                                           }];
    
    UIAlertAction* action_Close = [UIAlertAction actionWithTitle:@"قريب" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             
                                                             HomeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                                                             [self.navigationController pushViewController:viewObj animated:YES];
                                                         }];
    [alert addAction:action_Close];
    [alert addAction:action_JoinNow];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
