//
//  ChangeLanguageVC.m
//  BiladilProject
//
//  Created by mac on 16/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ChangeLanguageVC.h"
#import "AppDelegate.h"

@interface ChangeLanguageVC ()
{
    NSString * str;
}

@end

@implementation ChangeLanguageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_arabicTickImageView setImage:[UIImage imageNamed:@"radio_inactive"]];
    [_englishTickImageView setImage:[UIImage imageNamed:@"radio_inactive"]];
    
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnArabicAction:(UIButton *)sender {
    [_arabicTickImageView setImage:[UIImage imageNamed:@"lng_checkmark"]];
    [_englishTickImageView setImage:[UIImage imageNamed:@"radio_inactive"]];
    str = @"2";
}
- (IBAction)btnEnglishAction:(UIButton *)sender {
    [_arabicTickImageView setImage:[UIImage imageNamed:@"radio_inactive"]];
    [_englishTickImageView setImage:[UIImage imageNamed:@"lng_checkmark"]];
    str = @"1";
}
- (IBAction)btnConfirmAction:(UIButton *)sender {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (str == nil) {
        MDToast * t = [[MDToast alloc]initWithText:@"Please Select Language" duration:kMDToastDurationShort];
        [t show];
    }else{
        
        if([str isEqualToString:@"1"]){
            UIStoryboard *st=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"LANGUAGE"];
            if ([_fromPage isEqualToString:@"MENU"]) {
                RootViewController *navTo=[st instantiateViewControllerWithIdentifier:@"RootViewController"];
                [self.navigationController pushViewController:navTo animated:YES];
                
            }
            else{
                LoginVC * viewObj = [st instantiateViewControllerWithIdentifier:@"LoginVC"];
                [self.navigationController pushViewController:viewObj animated:YES];
            }
            
        }else{
            UIStoryboard *st=[UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"LANGUAGE"];
            if ([_fromPage isEqualToString:@"MENU"]) {
                RootViewController *navTo=[st instantiateViewControllerWithIdentifier:@"RootViewController"];
                [self.navigationController pushViewController:navTo animated:YES];
                
            }
            else{
                LoginVC * viewObj = [st instantiateViewControllerWithIdentifier:@"LoginVC"];
                [self.navigationController pushViewController:viewObj animated:YES];
            }
        }
        
        
        
        
        
//        if ([_fromPage isEqualToString:@"MENU"]) {
//            if ([str isEqualToString:@"2"]) {
//                [defaults setObject:@"2" forKey:@"LANGUAGE"];
//                UIStoryboard *st=[UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
//                RootViewController * viewObj = [st instantiateViewControllerWithIdentifier:@"RootViewController"];
//                [self.navigationController pushViewController:viewObj animated:YES];
//            }else{
//                [defaults setObject:@"1" forKey:@"LANGUAGE"];
//                UIStoryboard *st=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                RootViewController * viewObj = [st instantiateViewControllerWithIdentifier:@"RootViewController"];
//                [self.navigationController pushViewController:viewObj animated:YES];
//            }
//        }else{
//                LoginVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
//                [self.navigationController pushViewController:viewObj animated:YES];
//            }
    }
}

@end
