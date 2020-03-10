//
//  ProfieVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ProfieVC.h"
#import "AppDelegate.h"

@interface ProfieVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSArray * profileArray;
    NSString *profilePicBase64String;
    NSString * lang;
}

@end

@implementation ProfieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnConfirmChange.hidden = YES;
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    NSString *img = [[NSUserDefaults standardUserDefaults]valueForKey:@"profile_pic"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:img]
                             placeholderImage:[UIImage imageNamed:@"profile.png"]];
    [self.profileView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.profileView.frame.size.height)];
//    [self.profileScrollView addSubview:self.profileView];
//    [self.profileScrollView setContentSize:CGSizeMake(0, self.profileView.frame.size.height)];
    [self getProfileServiceCall];
    
    self.tfMobileNumber.enabled = NO;
    self.tfFullName.enabled = NO;
    self.tfEmailId.enabled = NO;
    self.tfIdNumber.enabled = NO;
    self.tfCountry.enabled = NO;
    self.tfCity.enabled = NO;
    
    self.profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2;
    self.profileImageView.layer.masksToBounds = YES;
    
    self.btn_Profile.userInteractionEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}

-(void)getProfileServiceCall{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"user_profile_details" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    profileArray = [[result valueForKey:@"response"]valueForKey:@"main_profile"];
                    self.lblUserName.text = [profileArray valueForKey:@"name"];
                    self.lblAddress.text = [profileArray valueForKey:@"mobile"];
                    self.tfFullName.text = [profileArray valueForKey:@"name"];
                    self.tfMobileNumber.text = [profileArray valueForKey:@"mobile"];
                    self.tfEmailId.text = [profileArray valueForKey:@"email"];
                    self.tfIdNumber.text = [[[result valueForKey:@"response"]valueForKey:@"get_profile_data"]valueForKey:@"identity_no"];
                    self.tfCountry.text = [[[result valueForKey:@"response"]valueForKey:@"get_profile_data"]valueForKey:@"country"];
                    self.tfCity.text = [[[result valueForKey:@"response"]valueForKey:@"get_profile_data"]valueForKey:@"region"];
//                    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[profileArray valueForKey:@"profile_pic"]]]];
                    
                    NSString *imgURL = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[profileArray valueForKey:@"profile_pic"]];
                    NSLog(@"%@", imgURL);
                    [defaults setObject:imgURL forKey:@"profile_pic"];
                    
//                    NSString *img = [[NSUserDefaults standardUserDefaults]valueForKey:@"profile_pic"];
                    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:imgURL]
                                             placeholderImage:[UIImage imageNamed:@"profile.png"]];
                    
                    self.tfMobileNumber.enabled = NO;
                    self.tfFullName.enabled = NO;
                    self.tfEmailId.enabled = NO;
                    self.tfIdNumber.enabled = NO;
                    self.tfCountry.enabled = NO;
                    self.tfCity.enabled = NO;
                    
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnEditAction:(UIButton *)sender {
    
    self.btnConfirmChange.hidden = NO;
    
    self.tfMobileNumber.enabled = YES;
    self.tfFullName.enabled = YES;
    self.tfEmailId.enabled = YES;
    self.tfIdNumber.enabled = NO;
    self.tfCountry.enabled = NO;
    self.tfCity.enabled = NO;
    
    self.btn_Profile.userInteractionEnabled = YES;
}
- (IBAction)btn_ProfilePicEdit:(id)sender {
    
    
    [self imageUploadAction];
}



- (IBAction)btnChangePasswordAction:(UIButton *)sender {
    
    ForgotPasswordVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
    
}
- (IBAction)btnConfirmChangesAction:(UIButton *)sender {
    NSString *base64 = @"";
    
    if (profilePicBase64String != nil) {
        
    }else{
        profilePicBase64String = @"";
    }
//    if ([profilePicBase64String isEqualToString:@"nil"]) {
//
//    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\", \"name\":\"%@\", \"Email_ID\":\"%@\", \"mobile\":\"%@\", \"Profile_pic\":\"%@\"}",[defaults valueForKey:@"USER_ID"], self.tfFullName.text, self.tfEmailId.text, self.tfMobileNumber.text, profilePicBase64String];
    [ServiceApI BiladilApis:@"user_change_profile" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    NSDictionary *respDict = [[NSDictionary alloc]init];
                    respDict = [result valueForKey:@"response"];
                    
                    /*
                    self.lblUserName.text = [respDict valueForKey:@"name"];
                    self.lblAddress.text = [respDict valueForKey:@"mobile"];
                    self.tfFullName.text = [respDict valueForKey:@"name"];
                    self.tfMobileNumber.text = [respDict valueForKey:@"mobile"];
                    self.tfEmailId.text = [respDict valueForKey:@"email"];
                    self.tfIdNumber.text = [[[result valueForKey:@"response"]valueForKey:@"get_profile_data"]valueForKey:@"identity_no"];
                    self.tfCountry.text = [[[result valueForKey:@"response"]valueForKey:@"get_profile_data"]valueForKey:@"country"];
                    self.tfCity.text = [[[result valueForKey:@"response"]valueForKey:@"get_profile_data"]valueForKey:@"region"];
                    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[profileArray valueForKey:@"profile_pic"]]]];
                    
                    */
                    
                    
//                    NSString *imgURL = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[respDict valueForKey:@"profile_pic"]];
//
//                    [defaults setObject:imgURL forKey:@"profile_pic"];
                    [defaults setObject:[respDict valueForKey:@"name"] forKey:@"USER_NAME"];
                    
//                    NSString *img = [[NSUserDefaults standardUserDefaults]valueForKey:@"profile_pic"];
//                    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:imgURL]
//                    placeholderImage:[UIImage imageNamed:@"profile.png"]];
                    
                    [self getProfileServiceCall];
                    self.btnConfirmChange.hidden = YES;
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

#pragma mark - Functions

-(void)imageUploadAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Profile Image" message:@"Select Camera (or) Gallery" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                              {
                                  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                  picker.delegate = self;
                                  picker.allowsEditing = YES;
                                  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  [self presentViewController:picker animated:YES completion:nil];
                              }];
    UIAlertAction * gallery = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                               {
                                   UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                   picker.delegate = self;
                                   picker.allowsEditing = YES;
                                   picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                   [self presentViewController:picker animated:YES completion:nil];
                                   
                               }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [alert addAction:camera];
    [alert addAction:gallery];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    // output image
    UIImage * image = info[UIImagePickerControllerEditedImage];
    
    UIGraphicsBeginImageContext(image.size);
    [image drawAtPoint:CGPointZero];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self dismissViewControllerAnimated:true completion:^{
        
            self.profileImageView.image = image;
        
    }];
    
        NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
        NSString * str1 = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        profilePicBase64String  = [NSString stringWithFormat:@"data:image/png;base64,%@",str1];
//        NSLog(@"Base 64: %@",profilePicBase64String);
//        [defaults setObject:profilePicBase64String forKey:@"profilePicBase64String"];
    
   
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
