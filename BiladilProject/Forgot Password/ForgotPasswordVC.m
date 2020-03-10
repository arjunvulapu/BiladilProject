//
//  ForgotPasswordVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ForgotPasswordVC.h"
#import "AppDelegate.h"

@interface ForgotPasswordVC ()<UITextFieldDelegate>
{
    NSArray * forgotArray;
    NSString * lang;
}

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    _tfMobileNumber.delegate = self;
    
    if ([lang isEqualToString:@"2"]) {
        [_tfMobileNumber setRightPadding:110];
    }else{
        [_tfMobileNumber setLeftPadding:110];
    }
    
    /*
    [self.tfMobileNumber setLeftPadding: 110];
    [self.tfMobileNumber setRightPadding:110];
    
    */
    [self.forgotPasswordView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.forgotPasswordView.frame.size.height)];
    [self.scrollView addSubview:self.forgotPasswordView];
    [self.scrollView setContentSize:CGSizeMake(0, self.forgotPasswordView.frame.size.height)];
    
    self.tfMobileNumber.layer.cornerRadius = 1;
    self.tfMobileNumber.layer.masksToBounds = YES;
    self.tfMobileNumber.layer.borderWidth = 1;
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tfMobileNumber resignFirstResponder];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tfMobileNumber)
    {
        if(range.length + range.location > self.tfMobileNumber.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.tfMobileNumber.text length] + [string length] - range.length;
        return newLength <= 15;
        return YES;
    }
    return YES;
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnNextAction:(UIButton *)sender {
    
    [self.tfMobileNumber resignFirstResponder];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if ([self.TF_countryCode.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Country Code" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    if ([self.tfMobileNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (self.tfMobileNumber.text.length < 5) {
        
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    NSString * forgotParams = [NSString stringWithFormat:@"{\"mobile\":\"%@\"}",self.tfMobileNumber.text];
    [ServiceApI BiladilApis:@"user_forgot_password" ItemStr:forgotParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    forgotArray = [result valueForKey:@"response"];
                    OtpVC * otpObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OtpVC"];
                    
                    otpObj.fromForgotToOtp = @"YES";
                    otpObj.otpStr = [[result valueForKey:@"OTP"]valueForKey:@"otp"];
                    otpObj.mobileNumberStr = [[result valueForKey:@"response"]valueForKey:@"mobile"];
                    
                    [defaults setObject:[[result valueForKey:@"response"]valueForKey:@"mobile"] forKey:@"MOBILE_NUMBER"];
                    
                    [defaults setObject:[forgotArray valueForKey:@"id"] forKey:@"USER_ID_Temp"];
                    [defaults setObject:[forgotArray valueForKey:@"email"] forKey:@"EMAIL_ID"];
                    [defaults setObject:[forgotArray valueForKey:@"mob_code"] forKey:@"mob_code"];
//                    [defaults setObject:[forgotArray valueForKey:@"username"] forKey:@"MOBILE_NUMBER"];
//                    _loader.hidden = YES;
//                    _btnBlur.hidden = YES;
                    [self.navigationController pushViewController:otpObj animated:YES];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
    
}


@end
