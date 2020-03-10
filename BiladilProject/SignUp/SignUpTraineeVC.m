//
//  SignUpTraineeVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SignUpTraineeVC.h"
#import "AppDelegate.h"

@interface SignUpTraineeVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MDDatePickerDialogDelegate>
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

@implementation SignUpTraineeVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    mdDatePicker = [[MDDatePickerDialog alloc]init];
    mdDatePicker.delegate = self;
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _currentCityTableView.hidden = YES;
    _countryTableView.hidden = YES;
    _btnBlur.hidden = YES;
//    _traineeCollectionView.hidden = YES;
    self.collectionViewHeightConstraint.constant = 0;
    _genderTableView.dataSource = self;
    _genderTableView.delegate = self;
    _currentCityTableView.dataSource = self;
    _currentCityTableView.delegate = self;
    _nationalityTableView.dataSource = self;
    _nationalityTableView.delegate = self;
    _countryTableView.dataSource = self;
    _countryTableView.delegate = self;
    _traineeCollectionView.dataSource = self;
    _traineeCollectionView.delegate = self;
    _tfFullName.delegate = self;
    _tfIdentityNumber.delegate = self;
    _tfCountryCode.delegate = self;
    _tfEmailId.delegate = self;
    _tfPhoneNumber.delegate = self;
    _tfPassword.delegate = self;
    _tfConfirmPassword.delegate = self;
    _tfInstitutionName.delegate = self;
    _tfCourseName.delegate = self;
    _tfSpecialization.delegate = self;
    _imageViewArray = [[NSMutableArray alloc]init];
    _collectionViewHeightConstraint.constant = 0;
    _termsView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
    [self.traineeView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.traineeView.frame.size.height)];
    [self.scrollView addSubview:self.traineeView];
    [self.scrollView setContentSize:CGSizeMake(0, self.traineeView.frame.size.height)];
    
    genderArray = @[@"Male",@"Female"];
//    nationalityArray = @[@"India",@"Saudi Arabia"];
    
    [_tfFullName setValue:[UIColor blackColor]
               forKeyPath:@"placeholderLabel.textColor"];
    [_tfIdentityNumber setValue:[UIColor blackColor]
                     forKeyPath:@"placeholderLabel.textColor"];
    [_tfCountryCode setValue:[UIColor blackColor]
                  forKeyPath:@"placeholderLabel.textColor"];
    [_tfPhoneNumber setValue:[UIColor blackColor]
                   forKeyPath:@"placeholderLabel.textColor"];
    [_tfEmailId setValue:[UIColor blackColor]
              forKeyPath:@"placeholderLabel.textColor"];
    [_tfPassword setValue:[UIColor blackColor]
               forKeyPath:@"placeholderLabel.textColor"];
    [_tfConfirmPassword setValue:[UIColor blackColor]
                      forKeyPath:@"placeholderLabel.textColor"];
    [_tfCourseName setValue:[UIColor blackColor]
                      forKeyPath:@"placeholderLabel.textColor"];
    [_tfInstitutionName setValue:[UIColor blackColor]
                 forKeyPath:@"placeholderLabel.textColor"];
    [_tfSpecialization setValue:[UIColor blackColor]
                 forKeyPath:@"placeholderLabel.textColor"];
    
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
    if (textField == self.tfPhoneNumber)
    {
        if(range.length + range.location > self.tfPhoneNumber.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.tfPhoneNumber.text length] + [string length] - range.length;
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
    
//    if(textField==_tfLicenseNumber || textField == _tfLicenseNumber)
//    {
//
//        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
//        for (int i = 0; i < [string length]; i++)
//        {
//            unichar c = [string characterAtIndex:i];
//            if (![myCharSet characterIsMember:c])
//            {
//                return NO;
//            }
//        }
    
//        return YES;
//    }
    
    return YES;
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
-(void)countryServiceCall{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * loginParams = [NSString stringWithFormat:@"{\"\":\"%@\"}",@""];
    [ServiceApI BiladilApis:@"countrylist" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    countryArray = [result valueForKey:@"response"];
                    [self.countryTableView reloadData];
                    
                    NSString *lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
                    if ([lang isEqualToString:@"1"]){
                        _btnCurrentCity.titleLabel.text = @"City";
                    }else{
                        _btnCurrentCity.titleLabel.text = @"مدينة";
                    }
                    
                    
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
-(void)service_Nationality{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSString * loginParams = [NSString stringWithFormat:@"{\"\":\"%@\"}",@""];
    [ServiceApI BiladilApis:@"nationality" ItemStr:@"" withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    nationalityArray = [result valueForKey:@"response"];
                    NSLog(@"Nationality Array --> %@",nationalityArray);
                    [self.nationalityTableView reloadData];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
-(void)cityServiceCall{
    if ([countryId isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please select Country" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    NSString * loginParams = [NSString stringWithFormat:@"{\"CountryID\":\"%@\"}",countryId];
    [ServiceApI BiladilApis:@"citylist" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    cityArray = [result valueForKey:@"response"];
                    [self.currentCityTableView reloadData];
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
#pragma TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.genderTableView) {
        return genderArray.count;
    }if (tableView == self.nationalityTableView) {
        return nationalityArray.count;
    }if (tableView == self.countryTableView) {
        return countryArray.count;
    }if (tableView == self.currentCityTableView) {
        return cityArray.count;
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
    }if (tableView == _countryTableView) {
        cell.textLabel.text = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"];
    }if (tableView == _currentCityTableView) {
        cell.textLabel.text = [[cityArray objectAtIndex:indexPath.row]valueForKey:@"name"];
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
        genderStr = [genderArray objectAtIndex:indexPath.row];
        _btnBlur.hidden = YES;
        self.genderTableView.hidden = YES;
    }if (tableView == _nationalityTableView) {
        [_btnNationality setTitle:[[nationalityArray objectAtIndex:indexPath.row]valueForKey:@"title"] forState:UIControlStateNormal];
        nationalityStr =  [[nationalityArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        _btnBlur.hidden = YES;
        self.nationalityTableView.hidden = YES;
    }if (tableView == _countryTableView) {
        [_btnCountry setTitle:[[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"] forState:UIControlStateNormal];
        countryId =  [[countryArray objectAtIndex:indexPath.row]valueForKey:@"id"];
        countryStr = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"];
        self.tfCountryCode.text = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"mob_code"];
        _btnBlur.hidden = YES;
        self.countryTableView.hidden = YES;
        [self cityServiceCall];
    }if (tableView == _currentCityTableView) {
        [_btnCurrentCity setTitle:[[cityArray objectAtIndex:indexPath.row]valueForKey:@"name"] forState:UIControlStateNormal];
        cityId =  [[cityArray objectAtIndex:indexPath.row]valueForKey:@"id"];
        cityStr = [[cityArray objectAtIndex:indexPath.row]valueForKey:@"name"];
        _btnBlur.hidden = YES;
        self.currentCityTableView.hidden = YES;
    }
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnNationalityAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = NO;
    _currentCityTableView.hidden = YES;
    _countryTableView.hidden = YES;
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
    [_btnDateOfbirth setTitle:[dateFormatter_1 stringFromDate:date] forState:UIControlStateNormal];
    dobStr = [dateFormatter_1 stringFromDate:date];
}
- (IBAction)btnGenderAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = NO;
    _nationalityTableView.hidden = YES;
    _currentCityTableView.hidden = YES;
    _countryTableView.hidden = YES;
    _btnBlur.hidden = NO;
    
    self.TV_GenderHeight.constant = _genderTableView.contentSize.height;
}
- (IBAction)btnUploadDocumentsAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    [self alertFor_imagePicker];
    /*
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
    
    */
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
        [_imageViewArray addObject:image];
        //        self.collectionViewHeightConstraint.constant = 120;
        [_traineeCollectionView reloadData];
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
    
    /*
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //image = [self scaleAndRotateImage:image];
    UIGraphicsBeginImageContext(image.size);
    [image drawAtPoint:CGPointZero];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //[[self delegate] sendImage:image];
    //[self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
    
    /*
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
    _traineeCollectionView.hidden = NO;
//    _termsView.frame = CGRectMake(10, _traineeCollectionView.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
    [self dismissPickerView];
    
    for (UIView *subview in _imageViewArray) {
        // [subview removeFromSuperview];
    }
    
    for (NSDictionary *imageDic in info) {
        
       [_imageViewArray addObject:[imageDic objectForKey:UIImagePickerControllerOriginalImage]];
        
    }
    if (_imageViewArray.count>=1) {
        NSData *imageData1 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:0], 0.2);
        img1 = [imageData1 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        img1 = [NSString stringWithFormat:@"data:image/png;base64,%@",img1];
    }
    
    if (_imageViewArray.count>=2) {
        NSData *imageData2 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:1], 0.2);
        img2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        img2 = [NSString stringWithFormat:@"data:image/png;base64,%@",img2];
    }
    if (_imageViewArray.count>=3) {
        NSData *imageData3 = UIImageJPEGRepresentation([_imageViewArray objectAtIndex:2], 0.2);
        img3 = [imageData3 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        img3 = [NSString stringWithFormat:@"data:image/png;base64,%@",img3];
    }
    [_traineeCollectionView reloadData];
    
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
    TraineeCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TraineeCollectionCell" forIndexPath:indexPath];
    cell.traineeImageView.clipsToBounds=YES;
    cell.traineeImageView.image=[_imageViewArray objectAtIndex:indexPath.row];
    [cell.btnImageClose addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnImageClose.tag=indexPath.row;
    return cell;
    
}
-(void)CancelAction:(UIButton *)sender{
    [_imageViewArray removeObjectAtIndex:sender.tag];
    if (_imageViewArray.count>0) {
        [_traineeCollectionView reloadData];
    }else{
        _collectionViewHeightConstraint.constant = 0;
//        _traineeCollectionView.hidden = YES;
//        _termsView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
        
    }
}
- (IBAction)btnAgreeAction:(UIButton *)sender {
}

#pragma mark- SignUp Action

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
    }if (cityStr == nil) {
//        cityStr = @"";
        MDToast *t = [[MDToast alloc]initWithText:@"Please Select City" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([self.TF_state.text isEqualToString:@""]) {
        
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter State" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([self.TF_street.text isEqualToString:@""]) {
        
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Street" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([self.TF_pincode.text isEqualToString:@""]) {
        
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Pincode" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([_tfCountryCode.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Country Code" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfPhoneNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (_tfPhoneNumber.text.length < 5) {
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
    }if ([_tfInstitutionName.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Current Institution Name" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfCourseName.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Current Course Name" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfSpecialization.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Specialization" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (_imageViewArray.count == 0) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Upload Atleast One Document" duration:kMDToastDurationShort];
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

-(void)serviceCall{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (self.tfPassword.text == self.tfConfirmPassword.text) {
        //        _loader.hidden = NO;
        //        _btnBlur.hidden = NO;
        NSString * otpParams = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\",\"mob_code\":\"%@\"}",self.tfPhoneNumber.text,_tfEmailId.text,self.tfCountryCode.text];//@"first_time"
        [ServiceApI BiladilApis:@"resend_otp" ItemStr:otpParams withCompletionBlock:^(NSArray *result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    NSLog(@"Error is:%@",[error localizedDescription]);
                    
                }else{
                    if ([[result valueForKey:@"status"]intValue] == 1) {
                        
                        OtpVC * verifyObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OtpVC"];
                        verifyObj.otpStr = [[result valueForKey:@"OTP"] valueForKey:@"otp"];
                        verifyObj.fromPage = @"fromSignUpTrainee";
                        if (self->img1 != nil) {
                            verifyObj.image1 = self->img1;
                        }if (self->img2 != nil) {
                            verifyObj.image2 = self->img2;
                        }if (self->img3 != nil) {
                            verifyObj.image3 = self->img3;
                        }
                        //  verifyObj.imagesArray = selectedImagesArray;
                        
                        [defaults setObject:self.tfPhoneNumber.text forKey:@"MOBILE_NUMBER"];
                        [defaults setObject:self.tfEmailId.text forKey:@"EMAIL_ID"];
                        [defaults setObject:self.tfFullName.text forKey:@"NAME"];
                        [defaults setObject:self.tfPassword.text forKey:@"PASSWORD"];
                        [defaults setObject:self.tfConfirmPassword.text forKey:@"CONFIRM_PASSWORD"];
                        [defaults setObject:self->countryStr forKey:@"COUNTRY_STR"];
                        [defaults setObject:self.tfIdentityNumber.text forKey:@"IDENTITY_NUMBER"];
                        [defaults setObject:self->dobStr forKey:@"DOB"];
                        [defaults setObject:self.tfCountryCode.text forKey:@"COUNTRY_CODE"];
                        [defaults setObject:self->nationalityStr forKey:@"NATIONALITY_STR"];
                        
                        [defaults setObject:self->cityStr forKey:@"CITY_NAME"];
                        [defaults setObject:self->_TF_state.text forKey:@"STATE_NAME"];
                        [defaults setObject:self->_TF_street.text forKey:@"STREET"];
                        [defaults setObject:self->_TF_pincode.text forKey:@"PINCODE"];
                        
                        [defaults setObject:self.tfInstitutionName.text forKey:@"INSTITUTION_NAME"];
                        [defaults setObject:self.tfCourseName.text forKey:@"COURSE_NAME"];
                        [defaults setObject:self.tfSpecialization.text forKey:@"SPECIALIZATION"];
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
    _currentCityTableView.hidden = YES;
    _countryTableView.hidden = YES;
    _btnBlur.hidden = YES;
}
- (IBAction)btnCountryAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _currentCityTableView.hidden = YES;
    _countryTableView.hidden = NO;
    _btnBlur.hidden = NO;
    self.TV_CountryHeight.constant = _countryTableView.contentSize.height;
}
- (IBAction)btnCurrentCityAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _currentCityTableView.hidden = NO;
    _countryTableView.hidden = YES;
    _btnBlur.hidden = NO;
    
    if (cityArray.count == 0) {
        _btnBlur.hidden = YES;
        MDToast *t = [[MDToast alloc]initWithText:@"No Data Available" duration:kMDToastDurationShort];
        [t show];
    }
    
    self.TV_CityHeight.constant = _currentCityTableView.contentSize.height;
}
- (IBAction)btnTermsConditionsAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    NSURL* url = [[NSURL alloc] initWithString:@"http://biladl.com/Pages/terms"];
    [[UIApplication sharedApplication] openURL: url];
}
-(void)tfResignResponderMethod{
    [_tfFullName resignFirstResponder];
    [_tfIdentityNumber resignFirstResponder];
    [_tfCountryCode resignFirstResponder];
    [_tfPhoneNumber resignFirstResponder];
    [_tfEmailId resignFirstResponder];
    [_tfPassword resignFirstResponder];
    [_tfConfirmPassword resignFirstResponder];
    [_tfCourseName resignFirstResponder];
    [_tfInstitutionName resignFirstResponder];
    [_tfSpecialization resignFirstResponder];
    
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
