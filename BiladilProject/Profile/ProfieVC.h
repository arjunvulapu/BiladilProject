//
//  ProfieVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfieVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *profileScrollView;
@property (strong, nonatomic) IBOutlet UIView *profileView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfFullName;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailId;
@property (weak, nonatomic) IBOutlet UITextField *tfIdNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UIButton *btnChangePassword;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirmChange;
@property (weak, nonatomic) IBOutlet UIButton *btn_Profile;

@end
