//
//  SignUpMemberVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpMemberVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnBlur;
@property (weak, nonatomic) IBOutlet UITableView *genderTableView;
@property (weak, nonatomic) IBOutlet UITableView *CountryTableView;
@property (weak, nonatomic) IBOutlet UITableView *nationalityTableView;
@property (weak, nonatomic) IBOutlet UITableView *regionTableView;

@property (strong, nonatomic) IBOutlet UIView *memberView;
@property (weak, nonatomic) IBOutlet UITextField *tfFullName;
@property (weak, nonatomic) IBOutlet UITextField *tfIdentitynumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailId;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnNationality;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnRegion;
@property (weak, nonatomic) IBOutlet UIButton *btnDateOfBirth;
@property (weak, nonatomic) IBOutlet UIButton *btnGender;
@property (weak, nonatomic) IBOutlet UIButton *btnUploadDocuments;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UIView *termsView;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivacyPolicy;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;
@property (weak, nonatomic) IBOutlet UIButton *btnTermsConditions;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_NationalityHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_GenderHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_RegionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_CountryHeight;

@property (weak, nonatomic) IBOutlet UITextField *TF_state;
@property (weak, nonatomic) IBOutlet UITextField *TF_street;
@property (weak, nonatomic) IBOutlet UITextField *TF_pincode;


@end
