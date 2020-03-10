//
//  CyberDefamationVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "CyberDefamationVC.h"

@interface CyberDefamationVC ()

@end

@implementation CyberDefamationVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews {
    [self.textView setContentOffset:CGPointZero animated:NO];
}

@end
