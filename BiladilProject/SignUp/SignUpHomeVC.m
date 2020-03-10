//
//  SignUpHomeVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SignUpHomeVC.h"
#import "SignUpLawyerrVC.h"
#import "SignUpMemberVC.h"
#import "SignUpTraineeVC.h"

@interface SignUpHomeVC ()

@end

@implementation SignUpHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _btnBlur.hidden = YES;
    _infoView.hidden = YES;
    
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnMemberSignUpAction:(id)sender {
    SignUpMemberVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpMemberVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
}
- (IBAction)btnLawyerSignUpAction:(id)sender {
    SignUpLawyerrVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpLawyerrVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
}
- (IBAction)btnTraineeSignUpAction:(id)sender {
    SignUpTraineeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpTraineeVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
}
- (IBAction)btnMemberInfoAction:(id)sender {
    _btnBlur.hidden = NO;
    _infoView.hidden = NO;
    _tvText.text = @"Member refers to any person who is a  local resident of Saudi Arabia who is a National or has a permanent residence as and employee , professional or investor and Wants to subscribe to the legal services";
}
- (IBAction)btnLawyerInfoAction:(id)sender {
    _btnBlur.hidden = NO;
    _infoView.hidden = NO;
    _tvText.text = @"Any legally qualified and practicing lawyer with the Legal License Of His Country who wants to be part of our panel to Offer legal services to the Subscribers";
}
- (IBAction)btnTraineeInfoAction:(id)sender {
    _btnBlur.hidden = NO;
    _infoView.hidden = NO;
    _tvText.text = @"";
}
- (IBAction)BtnCancelAction:(UIButton *)sender {
    _btnBlur.hidden = YES;
    _infoView.hidden = YES;
}


@end
