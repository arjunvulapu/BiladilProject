//
//  SocialMediaVC.m
//  BiladilProject
//
//  Created by iPrism Solutions on 26/08/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SocialMediaVC.h"
#import "AppDelegate.h"

@interface SocialMediaVC ()

@end

@implementation SocialMediaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btn_twitterAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/MyBiladl?s=17"]];
}

- (IBAction)btn_linkedInAction:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.linkedin.com/in/biladl-legal-467b4518b"]];
}
- (IBAction)btn_backAction:(id)sender {
    
    RootViewController * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    [self.navigationController pushViewController:viewObj animated:YES];
}


@end
