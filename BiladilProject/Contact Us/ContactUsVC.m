//
//  ContactUsVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ContactUsVC.h"
#import <MessageUI/MessageUI.h>


@interface ContactUsVC ()<MFMailComposeViewControllerDelegate>

@end

@implementation ContactUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.btnCall.layer.cornerRadius = self.btnCall.frame.size.height/2;
    self.btnCall.layer.masksToBounds = YES;
    
    self.btnMail.layer.cornerRadius = self.btnMail.frame.size.height/2;
    self.btnMail.layer.masksToBounds = YES;
    
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnCallAction:(UIButton *)sender {{
    //    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *phNo = [defaults valueForKey:@"DRIVER_MOBILE"];
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
}
- (IBAction)btnMailAction:(UIButton *)sender {
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"Sample Subject"];
        [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [mail setToRecipients:@[@"support@biladil.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        NSLog(@"This device cannot send email");
    }
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
