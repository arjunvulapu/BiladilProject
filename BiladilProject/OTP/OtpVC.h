//
//  OtpVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtpVC : UIViewController

@property(nonatomic, weak) NSString * otpStr;
@property(nonatomic, strong) NSString * image1;
@property(nonatomic, strong) NSString * image2;
@property(nonatomic, strong) NSString * image3;
@property(nonatomic, strong) NSString * fromPage;
@property(nonatomic, weak) NSString * fromForgotToOtp;
@property(nonatomic, strong) NSArray * imagesArray;
@property(nonatomic, weak) NSString  *mobileNumberStr;

@property (weak, nonatomic) IBOutlet UITextField *tfOtp;
@property (weak, nonatomic) IBOutlet UIButton *btnResendCode;
@property (weak, nonatomic) IBOutlet UIButton *btnVerify;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *otpView;
@property (weak, nonatomic) IBOutlet UILabel *lblMobileNumber;



@end
