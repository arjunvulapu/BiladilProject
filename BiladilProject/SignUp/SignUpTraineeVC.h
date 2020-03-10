//
//  SignUpTraineeVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpTraineeVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnBlur;
@property (strong, nonatomic) IBOutlet UIView *traineeView;
@property (weak, nonatomic) IBOutlet UITextField *tfFullName;
@property (weak, nonatomic) IBOutlet UITextField *tfIdentityNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailId;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnNationality;
@property (weak, nonatomic) IBOutlet UIButton *btnDateOfbirth;
@property (weak, nonatomic) IBOutlet UIButton *btnGender;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrentCity;
@property (weak, nonatomic) IBOutlet UITextField *tfInstitutionName;
@property (weak, nonatomic) IBOutlet UITextField *tfCourseName;
@property (weak, nonatomic) IBOutlet UITextField *tfSpecialization;
@property (weak, nonatomic) IBOutlet UIButton *btnUploadDocuments;
@property (weak, nonatomic) IBOutlet UICollectionView *traineeCollectionView;
@property (weak, nonatomic) IBOutlet UIView *termsView;
@property (weak, nonatomic) IBOutlet UIButton *btnPrivacyPolicy;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *nationalityTableView;
@property (weak, nonatomic) IBOutlet UITableView *genderTableView;
@property (weak, nonatomic) IBOutlet UITableView *currentCityTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UITableView *countryTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;
@property (weak, nonatomic) IBOutlet UIButton *btnTermsConditions;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_NationalityHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_GenderHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_CountryHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_CityHeight;

@property (weak, nonatomic) IBOutlet UITextField *TF_state;
@property (weak, nonatomic) IBOutlet UITextField *TF_street;
@property (weak, nonatomic) IBOutlet UITextField *TF_pincode;



@end
