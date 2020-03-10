//
//  OtpVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "OtpVC.h"
#import "AppDelegate.h"

@interface OtpVC ()<UITextFieldDelegate>
{
    NSArray * otpArray;
    NSString * methodStr;
    NSString * params;
}
@end

@implementation OtpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    _tfOtp.delegate = self;
    [self.otpView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.otpView.frame.size.height)];
    [self.scrollView addSubview:self.otpView];
    [self.scrollView setContentSize:CGSizeMake(0, self.otpView.frame.size.height)];
    
    NSLog(@"OTP --> %@",_otpStr);
    
   
//    MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"%@",_otpStr] duration:kMDToastDurationShort];
//    [t show];
}

-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    _lblMobileNumber.text = [NSString stringWithFormat:@"OTP Sent to (%@)", [defaults valueForKey:@"MOBILE_NUMBER"]]; //[defaults valueForKey:@"MOBILE_NUMBER"];
    
//    _lblMobileNumber.text = ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.tfOtp resignFirstResponder];
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tfOtp)
    {
        if(range.length + range.location > self.tfOtp.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.tfOtp.text length] + [string length] - range.length;
        return newLength <= 6;
        return YES;
    }
    return YES;
}
-(void)verifyServiceCall{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    if ([_fromForgotToOtp isEqualToString:@"YES"]) {
        if ([_tfOtp.text isEqualToString:[NSString stringWithFormat:@"%@",_otpStr]]) {
            UpdatePasswordVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"UpdatePasswordVC"];
            [self.navigationController pushViewController:viewObj animated:YES];
        }else{
            MDToast *t = [[MDToast alloc]initWithText:@"Please enter valid OTP" duration:kMDToastDurationShort];
            [t show];
        }
    }else{
        
    if ([_fromPage isEqualToString:@"fromSignUpMember"]) {
        methodStr = @"member_register";
        
        params = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\",\"name\":\"%@\",\"password\":\"%@\",\"Cpassword\":\"%@\",\"country\":\"%@\",\"identity_no\":\"%@\",\"county_code\":\"%@\",\"nationality\":\"%@\",\"dob\":\"%@\",\"region\":\"%@\",\"mob_code\":\"%@\",\"gender\":\"%@\",\"userDocuments1\":\"%@\",\"userDocuments2\":\"%@\",\"userDocuments3\":\"%@\",\"state\":\"%@\",\"street_name\":\"%@\",\"zip_code\":\"%@\"}",[defaults valueForKey:@"MOBILE_NUMBER"],[defaults valueForKey:@"EMAIL_ID"],[defaults valueForKey:@"NAME"],[defaults valueForKey:@"PASSWORD"],[defaults valueForKey:@"CONFIRM_PASSWORD"],[defaults valueForKey:@"COUNTRY_STR"],[defaults valueForKey:@"IDENTITY_NUMBER"],[defaults valueForKey:@"COUNTRY_CODE"],[defaults valueForKey:@"NATIONALITY_STR"],[defaults valueForKey:@"DOB"],[defaults valueForKey:@"CITY_NAME"],[defaults valueForKey:@"COUNTRY_CODE"],[defaults valueForKey:@"GENDER"],_image1,_image2,_image3,[defaults valueForKey:@"STATE_NAME"], [defaults valueForKey:@"STREET"], [defaults valueForKey:@"PINCODE"]];
        
    }else if ([_fromPage isEqualToString:@"fromSignUpTrainee"]){
        methodStr = @"student_register";
        params = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\",\"name\":\"%@\",\"password\":\"%@\",\"Cpassword\":\"%@\",\"country\":\"%@\",\"identity_no\":\"%@\",\"dob\":\"%@\",\"county_code\":\"%@\",\"mob_code\":\"%@\",\"nationality\":\"%@\",\"current_city\":\"%@\",\"instiutute_name\":\"%@\",\"course_name\":\"%@\",\"specialzation\":\"%@\",\"gender\":\"%@\",\"userDocuments1\":\"%@\",\"userDocuments2\":\"%@\",\"userDocuments3\":\"%@\",\"state\":\"%@\",\"street_name\":\"%@\",\"zip_code\":\"%@\"}",[defaults valueForKey:@"MOBILE_NUMBER"],[defaults valueForKey:@"EMAIL_ID"],[defaults valueForKey:@"NAME"],[defaults valueForKey:@"PASSWORD"],[defaults valueForKey:@"CONFIRM_PASSWORD"],[defaults valueForKey:@"COUNTRY_STR"],[defaults valueForKey:@"IDENTITY_NUMBER"],[defaults valueForKey:@"DOB"],[defaults valueForKey:@"COUNTRY_CODE"],[defaults valueForKey:@"COUNTRY_CODE"],[defaults valueForKey:@"NATIONALITY_STR"],[defaults valueForKey:@"CITY_NAME"],[defaults valueForKey:@"INSTITUTION_NAME"],[defaults valueForKey:@"COURSE_NAME"],[defaults valueForKey:@"SPECIALIZATION"],[defaults valueForKey:@"GENDER"],_image1,_image2,_image3,[defaults valueForKey:@"STATE_NAME"],[defaults valueForKey:@"STREET"],[defaults valueForKey:@"PINCODE"]];
        
    }else{
        methodStr = @"lawyer_register";
        params = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\",\"name\":\"%@\",\"current_city\":\"%@\",\"password\":\"%@\",\"Cpassword\":\"%@\",\"country\":\"%@\",\"identity_no\":\"%@\",\"county_code\":\"%@\",\"nationality\":\"%@\",\"licence_no\":\"%@\",\"dob\":\"%@\",\"specialzation\":\"%@\",\"languages\":\"%@\",\"building_no\":\"%@\",\"alternet_no\":\"%@\",\"mob_code\":\"%@\",\"district_name\":\"%@\",\"city_name\":\"%@\",\"street_name\":\"%@\",\"zip_code\":\"%@\",\"gender\":\"%@\",\"userDocuments1\":\"%@\",\"userDocuments2\":\"%@\",\"userDocuments3\":\"%@\",\"state\":\"%@\"}",[defaults valueForKey:@"MOBILE_NUMBER"],[defaults valueForKey:@"EMAIL_ID"],[defaults valueForKey:@"NAME"],[defaults valueForKey:@"CITY_STR"],[defaults valueForKey:@"PASSWORD"],[defaults valueForKey:@"CONFIRM_PASSWORD"],[defaults valueForKey:@"COUNTRY_STR"],[defaults valueForKey:@"IDENTITY_NUMBER"],[defaults valueForKey:@"COUNTRY_CODE"],[defaults valueForKey:@"NATIONALITY_STR"],[defaults valueForKey:@"LICENCE_NUMBER"],[defaults valueForKey:@"DOB"],[defaults valueForKey:@"SPECIALIZATION"],[defaults valueForKey:@"LANGUAGES"],[defaults valueForKey:@"BULDING_NO"],[defaults valueForKey:@"ALTERNATE_NO"],[defaults valueForKey:@"COUNTRY_CODE"],[defaults valueForKey:@"DISTRICT_NAME"],[defaults valueForKey:@"CITY_NAME"],[defaults valueForKey:@"STREET"],[defaults valueForKey:@"PINCODE"],[defaults valueForKey:@"GENDER"],_image1,_image2,_image3, [defaults valueForKey:@"STATE_NAME"]];
        
    }
   
    [ServiceApI BiladilApis:methodStr ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
//                    otpArray = [result valueForKey:@"response"];
                    
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    
                    [t show];
                    
                    LoginVC * verifyObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                    [self. navigationController pushViewController:verifyObj animated:YES];
                    //                        _loader.hidden = YES;
                    //                        _btnBlur.hidden = YES;
                    
                    
                    //                        _loader.hidden = YES;
                    //                        _btnBlur.hidden = YES;
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    //                        _loader.hidden = YES;
                    //                        _btnBlur.hidden = YES;
                    [t show];
                    
                }
            }
        });
    }];
  }
}

//-(void)OtpServiceCall{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSString * params = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\",\"email_ID\":\"%@\"}",[defaults valueForKey:@"MOBILE_NUMBER"],[defaults valueForKey:@"EMAIL_ID"],@"first_time"];
//    
//    [ServiceApI BiladilApis:@"resend_otp" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if (error) {
//                NSLog(@"Error is:%@",[error localizedDescription]);
//                
//            }else{
//                if ([[result valueForKey:@"status"]intValue] == 1) {
//                    otpArray = [result valueForKey:@"response"];
//                    HomeVC * verifyObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
//                    [self. navigationController pushViewController:verifyObj animated:YES];
//                    
//                    //                        _loader.hidden = YES;
//                    //                        _btnBlur.hidden = YES;
//                    
//                }else{
//                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
//                    //                        _loader.hidden = YES;
//                    //                        _btnBlur.hidden = YES;
//                    [t show];
//                    
//                }
//            }
//        });
//    }];
//}
-(void)resendOtpServiceCall{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString *mob_Code = [defaults valueForKey:@"mob_code"];
    NSString * params = @"";
    
    if ([_fromPage isEqualToString:@"fromSignUpMember"]) {
        
        params = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\", \"mob_code\":\"%@\"}",[defaults valueForKey:@"MOBILE_NUMBER"],[defaults valueForKey:@"EMAIL_ID"], mob_Code];
    }else{
        params = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\", \"type\":\"\", \"mob_code\":\"%@\"}",self.mobileNumberStr,[defaults valueForKey:@"EMAIL_ID"], mob_Code];
    }
    
    
    //[defaults valueForKey:@"MOBILE_NUMBER"]
    
    NSLog(@"Parameters --> %@", params);
    
    [ServiceApI BiladilApis:@"resend_otp" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    otpArray = [result valueForKey:@"response"];
                    _otpStr = [[result valueForKey:@"OTP"]valueForKey:@"otp"];
                    NSLog(@"OTP --> %@",_otpStr);
//                    MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"%@",_otpStr] duration:kMDToastDurationShort];
//                    [t show];
                    
//                        _loader.hidden = YES;
//                        _btnBlur.hidden = YES;
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    //                        _loader.hidden = YES;
                    //                        _btnBlur.hidden = YES;
                    [t show];
                    
                }
            }
        });
    }];
}
- (IBAction)btnResendCodeAction:(UIButton *)sender {
    [_tfOtp resignFirstResponder];
    self.tfOtp.text = @"";
    [self resendOtpServiceCall];
}
- (IBAction)btnVerifyAction:(id)sender {
    [_tfOtp resignFirstResponder];
    if ([_tfOtp.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter OTP" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (self.tfOtp.text.length<6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid OTP" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (self.tfOtp.text != [NSString stringWithFormat:@"%@",_otpStr]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Correct OTP" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    
    [self verifyServiceCall];
    
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
