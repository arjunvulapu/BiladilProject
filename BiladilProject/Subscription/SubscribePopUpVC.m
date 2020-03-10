//
//  SubscribePopUpVC.m
//  BiladilProject
//
//  Created by iPrism on 09/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SubscribePopUpVC.h"
#import "AppDelegate.h"


@interface SubscribePopUpVC ()<CustomDelegate>

@end

@implementation SubscribePopUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btn_JoinNow:(id)sender {
    
    SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
    viewObj.commingFrom = @"POP_UP";
    [self.navigationController pushViewController:viewObj animated:YES];
}

- (IBAction)btn_JoinNowAction:(UIButton *)sender {
    
    SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
    viewObj.delegate = self;
    viewObj.commingFrom = @"POP_UP";
    
//    [self.navigationController pushViewController:viewObj animated:YES];
    [self presentViewController:viewObj animated:NO completion:nil];
}

- (void)dismissVC {
    [self.navigationController popViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
- (IBAction)btn_Close:(id)sender {
    
//    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:NO completion:nil];
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
