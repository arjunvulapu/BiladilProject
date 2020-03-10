//
//  UpdatePasswordVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "UpdatePasswordVC.h"
#import "ServiceApI.h"
#import "MDToast.h"
#import "IMUtilities.h"
#import "AppDelegate.h"

@interface UpdatePasswordVC ()<UITextFieldDelegate>
{
    NSString * lang;
}

@end

@implementation UpdatePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    self.btnSave.layer.cornerRadius = 12.0f;
    self.tfNewPassword.delegate = self;
    self.tfConfirmPassword.delegate = self;
    [self setBottomLine:_tfNewPassword];
    [self setBottomLine:_tfConfirmPassword];
}
-(void)setBottomLine:(UITextField *)TF
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, TF.frame.size.height - borderWidth, TF.frame.size.width,TF.frame.size.height);
    border.borderWidth = borderWidth;
    [TF.layer addSublayer:border];
    TF.layer.masksToBounds = YES;
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSaveAction:(UIButton *)sender {
    [self.tfNewPassword resignFirstResponder];
    [self.tfConfirmPassword resignFirstResponder];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([self.tfNewPassword.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (self.tfNewPassword.text.length<6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Password must be Minimum 6 Characters" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([self.tfConfirmPassword.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Confirm Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (self.tfConfirmPassword.text.length<6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Password must be Minimum 6 Characters" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    if (self.tfNewPassword.text == self.tfConfirmPassword.text){
        NSString * saveParams = [NSString stringWithFormat:@"{\"userID\":\"%@\",\"password\":\"%@\",\"Cpassword\":\"%@\"}",[defaults valueForKey:@"USER_ID_Temp"],self.tfNewPassword.text,self.tfConfirmPassword.text];
        [ServiceApI BiladilApis:@"user_change_password" ItemStr:saveParams withCompletionBlock:^(NSArray *result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    NSLog(@"Error is:%@",[error localizedDescription]);
                    
                }else{
                    if ([[result valueForKey:@"status"]integerValue] == 1) {
                        
                        MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                        [t show];
                        
                        if([self->lang isEqualToString:@"1"]){
                            UIStoryboard *st=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
                            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"LANGUAGE"];

                                LoginVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                                [self.navigationController pushViewController:viewObj animated:YES];
                            
                        }else{
                            UIStoryboard *st=[UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
                            
                            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"LANGUAGE"];

                                LoginVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                                [self.navigationController pushViewController:viewObj animated:YES];
                        }
                        
                    }else{
                        MDToast *t = [[MDToast alloc]initWithText:@"New Password and Confirm Password Doesn't match" duration:kMDToastDurationShort];
                        [t show];
                    }
                }
            });
        }];
    }else{
        MDToast *t = [[MDToast alloc]initWithText:@"New Password and Confirm Password Doesn't match" duration:kMDToastDurationShort];
        [t show];
        return;
    }
}

@end
