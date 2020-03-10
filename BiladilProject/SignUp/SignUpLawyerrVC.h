//
//  SignUpLawyerrVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpLawyerrVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *lawyerView;
@property (weak, nonatomic) IBOutlet UITableView *nationalityTableView;
@property (weak, nonatomic) IBOutlet UITableView *genderTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnBlur;
@property (weak, nonatomic) IBOutlet UITextField *tfFullName;
@property (weak, nonatomic) IBOutlet UITextField *tfIdentityNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailId;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnNationality;
@property (weak, nonatomic) IBOutlet UIButton *btnDateOfBirth;
@property (weak, nonatomic) IBOutlet UIButton *btnGender;
@property (weak, nonatomic) IBOutlet UITextField *tfLicenseNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfSpecialization;
@property (weak, nonatomic) IBOutlet UITextField *tfLanguagesKnown;
@property (weak, nonatomic) IBOutlet UIButton *btnUploadDocuments;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UIView *termsView;
@property (weak, nonatomic) IBOutlet UITextField *tfBuildingNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfDistrictName;
@property (weak, nonatomic) IBOutlet UITextField *tfCityName;
@property (weak, nonatomic) IBOutlet UITextField *tfStreetName;
@property (weak, nonatomic) IBOutlet UITextField *tfZipCode;
@property (weak, nonatomic) IBOutlet UITextField *tfAdditionalNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivacyPolicy;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnTermsConditions;
@property (weak, nonatomic) IBOutlet UIButton *btn_Country;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_NationalityHeight;
@property (weak, nonatomic) IBOutlet UITableView *TV_Country;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_GenderHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_CountryHeight;

@property (weak, nonatomic) IBOutlet UITextField *TF_state;

@end
