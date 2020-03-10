//
//  LoginVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"


@interface LoginVC ()<UITextFieldDelegate>
{
    NSArray * loginArray;
    NSString * lang;
    
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    _tfMobileNumber.delegate = self;
    _tfPassword.delegate = self;
    
    [self.loginView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.loginView.frame.size.height)];
    [self.scrollView addSubview:self.loginView];
    [self.scrollView setContentSize:CGSizeMake(0, self.loginView.frame.size.height)];
    [self.tfMobileNumber setValue:[UIColor blackColor] forKeyPath:@"placeholderLabel.textColor"];
    [self.tfPassword setValue:[UIColor blackColor] forKeyPath:@"placeholderLabel.textColor"];
    _btnLogin.layer.cornerRadius = 5.0f;
    _btnLogin.clipsToBounds = YES;
    if ([lang isEqualToString:@"2"]) {
        [_tfMobileNumber setRightPadding:80];
        [_tfPassword setRightPadding:80];
    }else{
        [_tfMobileNumber setLeftPadding:80];
        [_tfPassword setLeftPadding:80];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tfMobileNumber.text = @"";
    self.tfPassword.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tfMobileNumber resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    
    return YES;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (textField == self.tfMobileNumber) {
//        
//        if(range.length + range.location > self.tfMobileNumber.text.length) {
//            return NO;
//        }
//        NSUInteger newLength = [self.tfMobileNumber.text length] + [string length] - range.length;
//        return newLength <= 15;
//        return YES;
//    }
//    return YES;
//}
- (IBAction)btnLoginAction:(UIButton *)sender {
    
    [self.tfMobileNumber resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([self.tfMobileNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Email_Id" duration:kMDToastDurationShort];
        [t show];
        return;
    }else if (![self NSStringIsValidEmail:self.tfMobileNumber.text]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Email_Id" duration:kMDToastDurationShort];
        [t show];
        return;
    }
//    if (self.tfMobileNumber.text.length < 5) {
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Mobile Number" duration:kMDToastDurationShort];
//        [t show];
//        return;
//    }
    if ([self.tfPassword.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (self.tfPassword.text.length<6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter minimum 6 Characters of Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }
//    NSString * loginParams = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"password\":\"%@\"}",self.tfMobileNumber.text,self.tfPassword.text];
    NSString * loginParams = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\"}",self.tfMobileNumber.text,self.tfPassword.text];

    [ServiceApI BiladilApis:@"user_login" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->loginArray = [result valueForKey:@"response"];
                    
                    NSLog(@"%@", self->loginArray);
                    
                    [defaults setObject:[self->loginArray valueForKey:@"id"] forKey:@"USER_ID"];
                    [defaults setObject:[self->loginArray valueForKey:@"name"] forKey:@"USER_NAME"];
                    
                    NSString *imgURL = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[self->loginArray valueForKey:@"profile_pic"]];
                    NSLog(@"%@", imgURL);
                    [defaults setObject:imgURL forKey:@"profile_pic"];
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                    
                    [self service_checkSubscribe];
                      
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
    
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
- (IBAction)btnForgotPasswordAction:(UIButton *)sender {
    ForgotPasswordVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
}

- (IBAction)btnSignUpAction:(UIButton *)sender {
    SignUpHomeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpHomeVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
}

-(void)service_checkSubscribe {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_current_package" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                
                if ([[result valueForKey:@"status"]intValue] == 0)
                {
                   
                    SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
                    viewObj.isFirstTime = YES;
                    [self.navigationController pushViewController:viewObj animated:YES];
                    
//                    NSString* lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
//                    if ([lang isEqualToString:@"1"]){
//
////                        RootViewController * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
////                        [self.navigationController pushViewController:viewObj animated:YES];
//
//                        SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
//                        viewObj.isFirstTime = YES;
//
//                        [self.navigationController pushViewController:viewObj animated:YES];
//                    }else{
//                        SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
//                        viewObj.isFirstTime = YES;
//                        //                        viewObj.commingFrom = @"POP_UP";
//
//                        [self.navigationController pushViewController:viewObj animated:YES];
//                    }
                    
                }
                
                 if ([[result valueForKey:@"status"]intValue] == 1) {
                    
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isSubscribed"];
                     
                        RootViewController * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
                        [self.navigationController pushViewController:viewObj animated:YES];
                    
                    
                }else{
                                        MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                                        [t show];
                }
            }
        });
    }];
}

@end
