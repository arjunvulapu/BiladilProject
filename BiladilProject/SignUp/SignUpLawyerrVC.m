//
//  SignUpLawyerrVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SignUpLawyerrVC.h"
#import "AppDelegate.h"

@interface SignUpLawyerrVC() <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZCImagePickerControllerDelegate,MDDatePickerDialogDelegate>
{
    NSMutableArray *_imageViewArray;
    UIPopoverController *_popoverController;
    UIButton *_launchButton;
    NSString *profileImg;
    NSString *img1;
    NSString *img2;
    NSString *img3;
    NSArray * genderArray;
    NSArray * nationalityArray;
    NSArray * countryArray;
    NSArray * cityArray;
    NSString * genderId;
    NSString * nationalityId;
    NSString * countryId;
    NSString * cityId;
    NSString * genderStr;
    NSString * nationalityStr;
    NSString * countryStr;
    NSString * cityStr;
    NSString * dobStr;
    
    MDDatePickerDialog * mdDatePicker;
    BOOL isChecked;
    
}

@end

@implementation SignUpLawyerrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    countryArray = [NSArray new];
    mdDatePicker = [[MDDatePickerDialog alloc]init];
    mdDatePicker.delegate = self;
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _TV_Country.hidden = YES;
    _btnBlur.hidden = YES;
//    _imagesCollectionView.hidden = YES;
    self.collectionViewHeightConstraint.constant = 0;
    _genderTableView.dataSource = self;
    _genderTableView.delegate = self;
    _nationalityTableView.dataSource = self;
    _nationalityTableView.delegate = self;
    _imagesCollectionView.dataSource = self;
    _imagesCollectionView.delegate = self;
    _tfFullName.delegate = self;
    _tfIdentityNumber.delegate = self;
    _tfCountryCode.delegate = self;
    _tfEmailId.delegate = self;
    _tfMobileNumber.delegate = self;
    _tfPassword.delegate = self;
    _tfConfirmPassword.delegate = self;
    _tfLicenseNumber.delegate = self;
    _tfSpecialization.delegate = self;
    _tfLanguagesKnown.delegate = self;
    _imageViewArray = [[NSMutableArray alloc]init];
    _collectionViewHeightConstraint.constant = 0;
    _termsView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
    
    [self.lawyerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.lawyerView.frame.size.height)];
    [self.scrollView addSubview:self.lawyerView];
    [self.scrollView setContentSize:CGSizeMake(0, self.lawyerView.frame.size.height)];
    
    genderArray = @[@"Male",@"Female"];
//    nationalityArray = @[@"India",@"Saudi Arabia"];
    
    [_tfFullName setValue:[UIColor blackColor]
               forKeyPath:@"placeholderLabel.textColor"];
    [_tfIdentityNumber setValue:[UIColor blackColor]
                     forKeyPath:@"placeholderLabel.textColor"];
    [_tfCountryCode setValue:[UIColor blackColor]
                  forKeyPath:@"placeholderLabel.textColor"];
    [_tfMobileNumber setValue:[UIColor blackColor]
                  forKeyPath:@"placeholderLabel.textColor"];
    [_tfEmailId setValue:[UIColor blackColor]
              forKeyPath:@"placeholderLabel.textColor"];
    [_tfPassword setValue:[UIColor blackColor]
               forKeyPath:@"placeholderLabel.textColor"];
    [_tfConfirmPassword setValue:[UIColor blackColor]
                      forKeyPath:@"placeholderLabel.textColor"];
    [_tfLicenseNumber setValue:[UIColor blackColor]
                 forKeyPath:@"placeholderLabel.textColor"];
    [_tfLanguagesKnown setValue:[UIColor blackColor]
                      forKeyPath:@"placeholderLabel.textColor"];
    [_tfSpecialization setValue:[UIColor blackColor]
                     forKeyPath:@"placeholderLabel.textColor"];
    
    [_tfBuildingNumber setValue:[UIColor blackColor]
              forKeyPath:@"placeholderLabel.textColor"];
    [_tfDistrictName setValue:[UIColor blackColor]
               forKeyPath:@"placeholderLabel.textColor"];
    [_tfCityName setValue:[UIColor blackColor]
                      forKeyPath:@"placeholderLabel.textColor"];
    [_tfStreetName setValue:[UIColor blackColor]
                    forKeyPath:@"placeholderLabel.textColor"];
    [_tfZipCode setValue:[UIColor blackColor]
                     forKeyPath:@"placeholderLabel.textColor"];
    [_tfAdditionalNumber setValue:[UIColor blackColor]
                     forKeyPath:@"placeholderLabel.textColor"];
    
    self.TV_Country.delegate = self;
    self.TV_Country.dataSource = self;
    
    [self service_Nationality];
    [self countryServiceCall];
}

- (IBAction)btn_AgreeAction:(id)sender {
    
    if (isChecked) {
        isChecked = NO;
        [self.btnAgree setImage:[UIImage imageNamed:@"icon_Uncheck"] forState:UIControlStateNormal];
    }else {
        isChecked = YES;
        [self.btnAgree setImage:[UIImage imageNamed:@"signup_checkmark"] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tfResignResponderMethod];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.tfMobileNumber)
    {
        if(range.length + range.location > self.tfMobileNumber.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.tfMobileNumber.text length] + [string length] - range.length;
        return newLength <= 15;
        return YES;
    }if (textField == self.tfIdentityNumber)
    {
        if(range.length + range.location > self.tfIdentityNumber.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.tfIdentityNumber.text length] + [string length] - range.length;
        return newLength <= 15;
        return YES;
    }
    
    if(textField==_tfLicenseNumber || textField == _tfLicenseNumber)
    {
        
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        
        return YES;
    }
    
    return YES;
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
#pragma TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.genderTableView) {
        return genderArray.count;
    }if (tableView == self.nationalityTableView) {
        return nationalityArray.count;
    }
    if (tableView == self.TV_Country) {
        return countryArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    if (tableView == _genderTableView) {
        cell.textLabel.text = [genderArray objectAtIndex:indexPath.row];
    }if (tableView == _nationalityTableView) {
        cell.textLabel.text = [[nationalityArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    }
    
    if (tableView == _TV_Country) {
        cell.textLabel.text = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"];
    }
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:15.0];
    return cell;
}

#pragma TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (tableView == _genderTableView) {
        [_btnGender setTitle:[genderArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        genderId = [genderArray objectAtIndex:indexPath.row];
        genderStr = [genderArray objectAtIndex:indexPath.row];
        _btnBlur.hidden = YES;
        self.genderTableView.hidden = YES;
    }if (tableView == _nationalityTableView) {
        [_btnNationality setTitle:[[nationalityArray objectAtIndex:indexPath.row]valueForKey:@"title"] forState:UIControlStateNormal];
        nationalityId =  [[nationalityArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        nationalityStr =  [[nationalityArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        _btnBlur.hidden = YES;
        self.nationalityTableView.hidden = YES;
    }
    if (tableView == _TV_Country) {
        [_btn_Country setTitle:[[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"] forState:UIControlStateNormal];
        countryId =  [[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"];
        countryStr = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"];
        self.tfCountryCode.text = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"mob_code"];
        _btnBlur.hidden = YES;
        self.TV_Country.hidden = YES;
//        [self cityServiceCall];
    }
}
- (IBAction)btnBackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btn_CountryAction:(id)sender {
    
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _TV_Country.hidden = NO;
    _TV_Country.hidden = NO;
    _btnBlur.hidden = NO;
    [self.TV_Country reloadData];
    self.TV_CountryHeight.constant = _TV_Country.contentSize.height;
}
- (IBAction)btnNationlityAction:(UIButton *)sender {
    
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = NO;
    _btnBlur.hidden = NO;
    
    self.TV_NationalityHeight.constant = _nationalityTableView.contentSize.height;
}
- (IBAction)btnDateOfBirthAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    [self.view bringSubviewToFront:mdDatePicker];
    [mdDatePicker show];
}
- (void)datePickerDialogDidSelectDate:(nonnull NSDate *)date{
    NSDateFormatter* dateFormatter_1 = [[NSDateFormatter alloc] init];
    dateFormatter_1.dateFormat = @"dd-MMM-yyyy";
    [_btnDateOfBirth setTitle:[dateFormatter_1 stringFromDate:date] forState:UIControlStateNormal];
    dobStr = [dateFormatter_1 stringFromDate:date];
}

- (IBAction)btnGenderAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = NO;
    _nationalityTableView.hidden = YES;
    _btnBlur.hidden = NO;
    
    self.TV_GenderHeight.constant = _genderTableView.contentSize.height;
}
- (IBAction)btnUploadDocumentsAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    
//    [self action_SheetController];
    [self alertFor_imagePicker];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSInteger i = buttonIndex;
    
    switch(i) {
            
        case 0:
        {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                picker.allowsEditing = false;
                
                [self presentViewController:picker animated:true completion:nil];
            }
            
        }
            break;
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                picker.allowsEditing = true;
                [self presentViewController:picker animated:true completion:nil];
            }
        }
            
        default:
            // Do Nothing.........
            break;
            
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage * image = info[UIImagePickerControllerEditedImage];
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawAtPoint:CGPointZero];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // Adding images to array

    
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
    
    NSString * str1 = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    profileImg  = [NSString stringWithFormat:@"data:image/png;base64,%@",str1];
    
    [self dismissViewControllerAnimated:true completion:^{
        
        //        self.profileImageView.image = image;
        [self->_imageViewArray addObject:image];
//        self.collectionViewHeightConstraint.constant = 120;
        [self->_imagesCollectionView reloadData];
    }];
    
    if (_imageViewArray.count>=1) {
        NSData *imageData1 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:0], 0.2);
        img1 = [imageData1 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    
    if (_imageViewArray.count>=2) {
        NSData *imageData2 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:1], 0.2);
        img2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    if (_imageViewArray.count>=3) {
        NSData *imageData3 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:2], 0.2);
        img3 = [imageData3 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    self.collectionViewHeightConstraint.constant = 120;
//    [_imagesCollectionView reloadData];

    
    
    /*
    /////////////////////////////////////////
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //image = [self scaleAndRotateImage:image];
    UIGraphicsBeginImageContext(image.size);
    [image drawAtPoint:CGPointZero];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //[[self delegate] sendImage:image];
    //[self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
    
     {
     "UserId":"358dd614-945b-4fc4-b8b2-dd04b6366b1e",
     "ProfileImage":"asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd"
     }
     */
    /*
    [self dismissViewControllerAnimated:true completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // [self showLoadingIndicator];
            
            // self.profileImg.image = image;
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
            profileImg = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        });
    }];
    
    */
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - ZCImagePickerControllerDelegate

- (void)zcImagePickerController:(ZCImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(NSArray *)info {
    _collectionViewHeightConstraint.constant = 120;
    _imagesCollectionView.hidden = NO;
//    _termsView.frame = CGRectMake(10, _imagesCollectionView.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
    [self dismissPickerView];

    for (NSDictionary *imageDic in info) {
        
        
        
        [_imageViewArray addObject:[imageDic objectForKey:UIImagePickerControllerOriginalImage]];
        
    }
    if (_imageViewArray.count>=1) {
        NSData *imageData1 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:0], 0.2);
        img1 = [imageData1 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    
    if (_imageViewArray.count>=2) {
        NSData *imageData2 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:1], 0.2);
        img2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    if (_imageViewArray.count>=3) {
        NSData *imageData3 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:2], 0.2);
        img3 = [imageData3 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    [_imagesCollectionView reloadData];
    
}

- (void)zcImagePickerControllerDidCancel:(ZCImagePickerController *)imagePickerController {
    [self dismissPickerView];
}


- (void)dismissPickerView {
    if (_popoverController) {
        [_popoverController dismissPopoverAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageViewArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LawyerCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LawyerCollectionCell" forIndexPath:indexPath];
    cell.lawyersImageView.clipsToBounds=YES;
    cell.lawyersImageView.image = [_imageViewArray objectAtIndex:indexPath.row];
    [cell.btnClose addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnClose.tag = indexPath.row;
    return cell;
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(100, 100);
//}

-(void)CancelAction:(UIButton *)sender{
    [_imageViewArray removeObjectAtIndex:sender.tag];
    if (_imageViewArray.count>0) {
        [_imagesCollectionView reloadData];
    }else{
        _collectionViewHeightConstraint.constant = 0;
//        _imagesCollectionView.hidden = YES;
//        _termsView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
    }
}

//MARK:- SignUp Buttons Action

- (IBAction)btnSignUpAction:(UIButton *)sender {
    
    [self tfResignResponderMethod];
    
    if ([_tfFullName.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Full Name" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfIdentityNumber.text isEqualToString:@""]) {
        _tfIdentityNumber.text = @"";
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Identity Number" duration:kMDToastDurationShort];
//        [t show];
//        return;
    }
    
    if (countryStr == nil) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Country" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([_tfCountryCode.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Country Code" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([_tfMobileNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (_tfMobileNumber.text.length < 5) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfEmailId.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Email_Id" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (![self NSStringIsValidEmail:self.tfEmailId.text]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Email_Id" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfPassword.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (_tfPassword.text.length < 6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter minimum 6 characters of Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfConfirmPassword.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Confirm Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (_tfConfirmPassword.text.length < 6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter minimum 6 characters of Confirm Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if (![_tfPassword.text isEqualToString:_tfConfirmPassword.text]){
        MDToast *t = [[MDToast alloc]initWithText:@"Password and Confirm Password not matched" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if (nationalityStr == nil) {
        nationalityStr = @"";
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Nationality" duration:kMDToastDurationShort];
//        [t show];
//        return;
    }if (dobStr == nil) {
        dobStr = @"";
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Date Of Birth" duration:kMDToastDurationShort];
//        [t show];
//        return;
    }if (genderStr == nil) {
        genderStr = @"";
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Gender" duration:kMDToastDurationShort];
//        [t show];
//        return;
    }if ([_tfLicenseNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter License Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfSpecialization.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Specialization" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfLanguagesKnown.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Language(s)" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (_imageViewArray.count == 0) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Upload Atleast One Document" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfBuildingNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Building Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([self.TF_state.text isEqualToString:@""]) {
        
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter State" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([_tfDistrictName.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter District Name" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfCityName.text isEqualToString:@""]) {
//        _tfCityName.text = @"";
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter City Name" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfStreetName.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Street Name" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfZipCode.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Zip Code" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if (!isChecked) {
        
        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Terms and Conditions" duration:kMDToastDurationShort];
        [t show];
        return;
    }else {
        [self serviceCall];
    }
    
    

    
}

//MARK:- Service Calls

-(void)service_Nationality{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //    NSString * loginParams = [NSString stringWithFormat:@"{\"\":\"%@\"}",@""];
    [ServiceApI BiladilApis:@"nationality" ItemStr:@"" withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->nationalityArray = [result valueForKey:@"response"];
//                    NSLog(@"Nationality Array --> %@",nationalityArray);
                    [self.nationalityTableView reloadData];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

-(void)serviceCall{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (self.tfPassword.text == self.tfConfirmPassword.text) {
        //        _loader.hidden = NO;
        //        _btnBlur.hidden = NO;
        NSString * otpParams = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\",\"mob_code\":\"%@\"}",self.tfMobileNumber.text,_tfEmailId.text,self.tfCountryCode.text];
        [ServiceApI BiladilApis:@"resend_otp" ItemStr:otpParams withCompletionBlock:^(NSArray *result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    NSLog(@"Error is:%@",[error localizedDescription]);
                    
                }else{
                    if ([[result valueForKey:@"status"]intValue] == 1) {
                        
                        OtpVC * verifyObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OtpVC"];
                        verifyObj.otpStr = [[result valueForKey:@"OTP"] valueForKey:@"otp"];
                        verifyObj.fromPage = @"fromSignUpLawyer";
                        if (self->img1 != nil) {
                            verifyObj.image1 = self->img1;
                        }if (self->img2 != nil) {
                            verifyObj.image2 = self->img2;
                        }if (self->img3 != nil) {
                            verifyObj.image3 = self->img3;
                        }
                        //  verifyObj.imagesArray = selectedImagesArray;
                        
                        
                        [defaults setObject:self.tfMobileNumber.text forKey:@"MOBILE_NUMBER"];
                        [defaults setObject:self.tfEmailId.text forKey:@"EMAIL_ID"];
                        [defaults setObject:self.tfFullName.text forKey:@"NAME"];
                        [defaults setObject:self.tfPassword.text forKey:@"PASSWORD"];
                        [defaults setObject:self.tfConfirmPassword.text forKey:@"CONFIRM_PASSWORD"];
                        [defaults setObject:self.btnNationality.titleLabel.text forKey:@"COUNTRY_STR"];
                        [defaults setObject:self.tfIdentityNumber.text forKey:@"IDENTITY_NUMBER"];
                        [defaults setObject:self.tfCountryCode.text forKey:@"COUNTRY_CODE"];
                        [defaults setObject:self->nationalityStr forKey:@"NATIONALITY_STR"];
                        [defaults setObject:self->countryStr forKey:@"LICENCE_NUMBER"];
                        [defaults setObject:self->dobStr forKey:@"DOB"];
                        [defaults setObject:self.tfSpecialization.text forKey:@"SPECIALIZATION"];
                        [defaults setObject:self.tfLanguagesKnown.text forKey:@"LANGUAGES"];
                        [defaults setObject:self.tfSpecialization.text forKey:@"BULDING_NO"];
                        [defaults setObject:self.tfAdditionalNumber.text forKey:@"ALTERNATE_NO"];
                        [defaults setObject:self.tfDistrictName.text forKey:@"DISTRICT_NAME"];
                        
                        [defaults setObject:self.TF_state.text forKey:@"STATE_NAME"];
                        [defaults setObject:self.tfCityName.text forKey:@"CITY_NAME"];
                        [defaults setObject:self.tfStreetName.text forKey:@"STREET"];
                        [defaults setObject:self.tfZipCode.text forKey:@"PINCODE"];
                        
                        
                        [defaults setObject:self->genderStr forKey:@"GENDER"];
                        
                        
                        
                        //                        _loader.hidden = YES;
                        //                        _btnBlur.hidden = YES;
                        
                        [self. navigationController pushViewController:verifyObj animated:YES];
                    }else{
                        MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                        //                        _loader.hidden = YES;
                        //                        _btnBlur.hidden = YES;
                        [t show];
                        
                    }
                }
            });
        }];
    }else{
        MDToast *t = [[MDToast alloc]initWithText:@"Password and Confirm Password Doesn't match." duration:kMDToastDurationShort];
        [t show];
    }
    
}
- (IBAction)btnBlurAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _btnBlur.hidden = YES;
}
- (IBAction)btnTermsConditionsAction:(id)sender {
    [self tfResignResponderMethod];
    NSURL* url = [[NSURL alloc] initWithString: @"http://biladl.com/Pages/terms"];
    [[UIApplication sharedApplication] openURL: url];
}
-(void)tfResignResponderMethod{
    [_tfFullName resignFirstResponder];
    [_tfIdentityNumber resignFirstResponder];
    [_tfCountryCode resignFirstResponder];
    [_tfMobileNumber resignFirstResponder];
    [_tfEmailId resignFirstResponder];
    [_tfPassword resignFirstResponder];
    [_tfConfirmPassword resignFirstResponder];
    [_tfLicenseNumber resignFirstResponder];
    [_tfLanguagesKnown resignFirstResponder];
    [_tfSpecialization resignFirstResponder];
}

-(void)countryServiceCall{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * loginParams = [NSString stringWithFormat:@"{\"\":\"%@\"}",@""];
    [ServiceApI BiladilApis:@"countrylist" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->countryArray = [result valueForKey:@"response"];
                    [self.TV_Country reloadData];
//                    _btnCurrentCity.titleLabel.text = @"Current City";
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

- (void)action_SheetController {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Action" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select photo from gallery" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // Distructive button tapped.
        [self dismissViewControllerAnimated:YES completion:^{
            
            if (self->_imageViewArray.count>=3) {
                MDToast *t = [[MDToast alloc]
                              initWithText:[NSString stringWithFormat:@""
                                            ]
                              duration:kMDToastDurationShort];
                [t show];
                
                return;
            }
            ZCImagePickerController *imagePickerController = [[ZCImagePickerController alloc] init];
            
            imagePickerController.imagePickerDelegate = self;
            imagePickerController.maximumAllowsSelectionCount = 3;
            imagePickerController.mediaType = ZCMediaAllAssets;
            
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                
                // You should present the image picker in a popover on iPad.
                
                self->_popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
                [self->_popoverController presentPopoverFromRect:self->_launchButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
            else {
                // Full screen on iPhone and iPod Touch.
                
                [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:NULL];
            }
            
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Capture photo form Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // OK button tapped.
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}




-(void)alertFor_imagePicker {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Action" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    
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
                                   
                                   /*
                                   
                                   [self dismissViewControllerAnimated:YES completion:^{
                                       
                                       if (_imageViewArray.count>=3) {
                                           MDToast *t = [[MDToast alloc]
                                                         initWithText:[NSString stringWithFormat:@""
                                                                       ]
                                                         duration:kMDToastDurationShort];
                                           [t show];
                                           
                                           return;
                                       }
                                       ZCImagePickerController *imagePickerController = [[ZCImagePickerController alloc] init];
                                       
                                       imagePickerController.imagePickerDelegate = self;
                                       imagePickerController.maximumAllowsSelectionCount = 3;
                                       imagePickerController.mediaType = ZCMediaAllAssets;
                                       
                                       if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                                           
                                           // You should present the image picker in a popover on iPad.
                                           
                                           _popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
                                           [_popoverController presentPopoverFromRect:_launchButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                                       }
                                       else {
                                           // Full screen on iPhone and iPod Touch.
                                           
                                           [self.view.window.rootViewController presentViewController:imagePickerController animated:YES completion:NULL];
                                       }
                                       
                                   }];
                                   
                                   */
                                   
                               }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancel];
    
    [alert addAction:camera];
    
    [alert addAction:gallery];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
