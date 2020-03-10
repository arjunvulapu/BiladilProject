//
//  SignUpMemberVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SignUpMemberVC.h"
#import "AppDelegate.h"
#import "BiladilProject-Bridging-Header.h"


@interface SignUpMemberVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MDDatePickerDialogDelegate>
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
    NSArray * regionArray;
    NSString * genderId;
    NSString * nationalityId;
    NSString * countryId;
    NSString * regionId;
    NSString * genderStr;
    NSString * nationalityStr;
    NSString * countryStr;
    NSString * regionStr;
    NSString * dobStr;
    NSMutableArray * selectedImagesArray;
    
    NSArray * signUpMemArray;
    MDDatePickerDialog * mdDatePicker;
    
    BOOL isChecked;
}
@property BOOL *selected;
@end

@implementation SignUpMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _selected = NO;
    mdDatePicker = [[MDDatePickerDialog alloc]init];
    selectedImagesArray = [[NSMutableArray alloc]init];
    mdDatePicker.delegate = self;
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _CountryTableView.hidden = YES;
    _regionTableView.hidden = YES;
    _btnBlur.hidden = YES;
//    _imagesCollectionView.hidden = YES;
    self.collectionViewHeightConstraint.constant = 0;
    _genderTableView.dataSource = self;
    _genderTableView.delegate = self;
    _regionTableView.dataSource = self;
    _regionTableView.delegate = self;
    _CountryTableView.dataSource = self;
    _CountryTableView.delegate = self;
    _nationalityTableView.dataSource = self;
    _nationalityTableView.delegate = self;
    _imagesCollectionView.dataSource = self;
    _imagesCollectionView.delegate = self;
    _tfFullName.delegate = self;
    _tfIdentitynumber.delegate = self;
    _tfCountryCode.delegate = self;
    _tfEmailId.delegate = self;
    _tfMobileNumber.delegate = self;
    _tfPassword.delegate = self;
    _tfConfirmPassword.delegate = self;
    _tfPassword.delegate = self;
    _imageViewArray = [[NSMutableArray alloc]init];
//    _collectionViewHeightConstraint.constant = 0;
//    _termsView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
    [self.memberView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.memberView.frame.size.height)];
    [self.scrollView addSubview:self.memberView];
    [self.scrollView setContentSize:CGSizeMake(0, self.memberView.frame.size.height)];
   
    genderArray = @[@"Male",@"Female"];
//    nationalityArray = @[@"India",@"Saudi Arabia"];
    
    [_tfFullName setValue:[UIColor blackColor]
                    forKeyPath:@"placeholderLabel.textColor"];
    [_tfIdentitynumber setValue:[UIColor blackColor]
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
    
    [self countryServiceCall];
    [self service_Nationality];
    
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
    if (textField == self.tfMobileNumber) {
        
        if(range.length + range.location > self.tfMobileNumber.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.tfMobileNumber.text length] + [string length] - range.length;
        return newLength <= 15;
        return YES;
    }if (textField == self.tfIdentitynumber)
    {
        if(range.length + range.location > self.tfIdentitynumber.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [self.tfIdentitynumber.text length] + [string length] - range.length;
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
//
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
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * loginParams = [NSString stringWithFormat:@"{\"\":\"%@\"}",@""];
    [ServiceApI BiladilApis:@"countrylist" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->countryArray = [result valueForKey:@"response"];
                    [self.CountryTableView reloadData];
                    
                    NSString *lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
                    if ([lang isEqualToString:@"1"]){
                        self->_btnRegion.titleLabel.text = @"City";
                    }else{
                        self->_btnRegion.titleLabel.text = @"مدينة";
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
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //    NSString * loginParams = [NSString stringWithFormat:@"{\"\":\"%@\"}",@""];
    [ServiceApI BiladilApis:@"nationality" ItemStr:@"" withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->nationalityArray = [result valueForKey:@"response"];
                    NSLog(@"Nationality Array --> %@",self->nationalityArray);
                    [self.nationalityTableView reloadData];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

-(void)regionServiceCall{
    if (countryStr == nil) {
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
                    self->regionArray = [result valueForKey:@"response"];
                    [self.regionTableView reloadData];
                   
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
#pragma mark- TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.genderTableView) {
        return genderArray.count;
    }if (tableView == self.nationalityTableView) {
        return nationalityArray.count;
    }if (tableView == self.CountryTableView) {
        return countryArray.count;
    }if (tableView == self.regionTableView) {
        return regionArray.count;
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
    }if (tableView == _CountryTableView) {
        cell.textLabel.text = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"];
    }if (tableView == _regionTableView) {
        cell.textLabel.text = [[regionArray objectAtIndex:indexPath.row]valueForKey:@"name"];
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
    }if (tableView == _CountryTableView) {
        [_btnCountry setTitle:[[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"] forState:UIControlStateNormal];
        countryId =  [[countryArray objectAtIndex:indexPath.row]valueForKey:@"id"];
        countryStr = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"country_name"];
        //mob_code
        self.tfCountryCode.text = [[countryArray objectAtIndex:indexPath.row]valueForKey:@"mob_code"];
        _btnBlur.hidden = YES;
        self.CountryTableView.hidden = YES;
        [self regionServiceCall];
    }if (tableView == _regionTableView) {
        [_btnRegion setTitle:[[regionArray objectAtIndex:indexPath.row]valueForKey:@"name"] forState:UIControlStateNormal];
        regionId =  [[regionArray objectAtIndex:indexPath.row]valueForKey:@"id"];
        regionStr = [[regionArray objectAtIndex:indexPath.row]valueForKey:@"name"];
        _btnBlur.hidden = YES;
        self.regionTableView.hidden = YES;
    }
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnNationalityAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _CountryTableView.hidden = YES;
    _regionTableView.hidden = YES;
    _btnBlur.hidden = NO;
    _nationalityTableView.hidden = NO;
    
    self.TV_NationalityHeight.constant = nationalityArray.count * 45;
}
- (IBAction)btnCountryAction:(UIButton *)sender {
    
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _regionTableView.hidden = YES;
    _btnBlur.hidden = NO;
    _CountryTableView.hidden = NO;
    [self countryServiceCall];
    
    self.TV_CountryHeight.constant = _CountryTableView.contentSize.height;
   
}
- (IBAction)btnRegionAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _CountryTableView.hidden = YES;
    _btnBlur.hidden = NO;
    _regionTableView.hidden = NO;
    
    if (regionArray.count == 0) {
        _btnBlur.hidden = YES;
        MDToast *t = [[MDToast alloc]initWithText:@"No Data Available" duration:kMDToastDurationShort];
        [t show];
    }
    
    self.TV_RegionHeight.constant = _regionTableView.contentSize.height;
}
- (IBAction)btnDateOfBirthAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    [self.view bringSubviewToFront:mdDatePicker];
    [mdDatePicker show];
}

//- (void)setMinimumDate:(NSDate *)minimumDate {
//    self.calendar.minimumDate = minimumDate;
//}

- (void)datePickerDialogDidSelectDate:(nonnull NSDate *)date{
    NSDateFormatter * dateFormatter_1 = [[NSDateFormatter alloc] init];
    dateFormatter_1.dateFormat = @"dd-MMM-yyyy";
    [_btnDateOfBirth setTitle:[dateFormatter_1 stringFromDate:date] forState:UIControlStateNormal];
    dobStr = [dateFormatter_1 stringFromDate:date];
}

- (IBAction)btnGenderAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _nationalityTableView.hidden = YES;
    _CountryTableView.hidden = YES;
    _regionTableView.hidden = YES;
    _btnBlur.hidden = NO;
    _genderTableView.hidden = NO;
//    [_genderTableView reloadData];
    self.TV_GenderHeight.constant = genderArray.count * 50;
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
    
    
    /*
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
    
//    for (UIView *subview in _imageViewArray) {
//        // [subview removeFromSuperview];
//    }
    
    
    
    for (NSDictionary *imageDic in info) {
        
        if(_imageViewArray.count > 3){
            MDToast *t = [[MDToast alloc]initWithText:@"Please upto 3 Documents" duration:kMDToastDurationShort];
            [t show];
        }else{
            [_imageViewArray addObject:[imageDic objectForKey:UIImagePickerControllerOriginalImage]];
        }
        
        
        
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
    
         
//    [_imageViewArray addObject:[NSString stringWithFormat:@"",];
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
    ImagesCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImagesCollectionViewCell" forIndexPath:indexPath];
           cell.multipleImageView.clipsToBounds=YES;
        cell.multipleImageView.image=[_imageViewArray objectAtIndex:indexPath.row];
        [cell.btnClose addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnClose.tag=indexPath.row;
  return cell;
    
}
-(void)CancelAction:(UIButton *)sender{
    [_imageViewArray removeObjectAtIndex:sender.tag];
    if (_imageViewArray.count>0) {
        [_imagesCollectionView reloadData];
    }else{
    _collectionViewHeightConstraint.constant = 0;
//    _imagesCollectionView.hidden = YES;
//    _termsView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
    
    }
}
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
//{
//    return 1;
//}
- (IBAction)btnPrivacyPolicyAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    NSURL* url = [[NSURL alloc] initWithString: @"https://www.google.co.in/?client=safari&channel=iphone_bm"];
    [[UIApplication sharedApplication] openURL: url];
//    NSURL* url = [[NSURL alloc] initWithString: @"https://stackoverflow.com/questions/tagged/iOS"];
//    [[UIApplication sharedApplication] canOpenURL: url];
}

#pragma mark- Buttons Actions

- (IBAction)btnSignUpAction:(UIButton *)sender {
    
    [self tfResignResponderMethod];
    
    if ([_tfFullName.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Full Name" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    if ([_tfIdentitynumber.text isEqualToString:@""]) {
        _tfIdentitynumber.text = @"";
        
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Identity Number" duration:kMDToastDurationShort];
//        [t show];
    }
    
    if (countryStr == nil) { //countryStr
//        countryStr = @"";
        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Country" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if (regionStr == nil) {
//        regionStr = @"";
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
    }
    if ([_tfMobileNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }else if (_tfMobileNumber.text.length < 5) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    if ([_tfEmailId.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Email_Id" duration:kMDToastDurationShort];
        [t show];
        return;
    }else if (![self NSStringIsValidEmail:self.tfEmailId.text]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Email_Id" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    
    if ([_tfPassword.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }else if (_tfPassword.text.length < 6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter minimum 6 characters of Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }else if ([_tfConfirmPassword.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Confirm Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }else if (_tfConfirmPassword.text.length < 6) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter minimum 6 characters of Confirm Password" duration:kMDToastDurationShort];
        [t show];
        return;
    }else if (![_tfPassword.text isEqualToString:_tfConfirmPassword.text]){
        MDToast *t = [[MDToast alloc]initWithText:@"Password and Confirm Password not matched" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    if (nationalityStr == nil) {
        nationalityStr = @"";
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Nationality" duration:kMDToastDurationShort];
//        [t show];
    }
    if (dobStr == nil) {
        dobStr = @"";
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Date Of Birth" duration:kMDToastDurationShort];
//        [t show];
    }
    if (genderStr == nil) {
        genderStr = @"";
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Gender" duration:kMDToastDurationShort];
//        [t show];
    }
    if (!isChecked) {
        
        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Terms and Conditions" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    else  {
        [self memberSignUpServiceCall];
    }
//    if (_imageViewArray.count == 0) {
//        MDToast *t = [[MDToast alloc]initWithText:@"Please Upload Atleast One Document" duration:kMDToastDurationShort];
//        [t show];
//        return;
//    }
    
}

//MARK:- Service Calls

-(void)memberSignUpServiceCall{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([_tfPassword.text isEqualToString:_tfConfirmPassword.text]) {
//        _loader.hidden = NO;
//        _btnBlur.hidden = NO; //self.tfMobileNumber.text
        NSString * otpParams = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"email_ID\":\"%@\",\"mob_code\":\"%@\"}",self.tfMobileNumber.text,_tfEmailId.text,self.tfCountryCode.text];//first_time
        [ServiceApI BiladilApis:@"resend_otp" ItemStr:otpParams withCompletionBlock:^(NSArray *result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (error) {
                    NSLog(@"Error is:%@",[error localizedDescription]);
                    
                }else{
                    if ([[result valueForKey:@"status"]intValue] == 1) {
                        
                        OtpVC * verifyObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OtpVC"];
                        verifyObj.otpStr = [[result valueForKey:@"OTP"] valueForKey:@"otp"];
                        verifyObj.fromPage = @"fromSignUpMember";
                        if (self->img1 != nil) {
                            verifyObj.image1 = self->img1;
                        }if (self->img2 != nil) {
                            verifyObj.image2 = self->img2;
                        }if (self->img3 != nil) {
                            verifyObj.image3 = self->img3;
                        }
                      //  verifyObj.imagesArray = selectedImagesArray;
                        [defaults setObject:self.tfFullName.text forKey:@"NAME"];
                        [defaults setObject:self.tfIdentitynumber.text forKey:@"IDENTITY_NUMBER"];
                        [defaults setObject:self->countryStr forKey:@"COUNTRY_STR"];
                        [defaults setObject:self->regionStr forKey:@"CITY_NAME"];
                        
                        [defaults setObject:self->_TF_state.text forKey:@"STATE_NAME"];
                        [defaults setObject:self->_TF_street.text forKey:@"STREET"];
                        [defaults setObject:self->_TF_pincode.text forKey:@"PINCODE"];
                        
                        [defaults setObject:self.tfCountryCode.text forKey:@"COUNTRY_CODE"];
                        [defaults setObject:self.tfMobileNumber.text forKey:@"MOBILE_NUMBER"];
                        [defaults setObject:self.tfEmailId.text forKey:@"EMAIL_ID"];
                        [defaults setObject:self.tfPassword.text forKey:@"PASSWORD"];
                        [defaults setObject:self.tfConfirmPassword.text forKey:@"CONFIRM_PASSWORD"];
                        [defaults setObject:self->nationalityStr forKey:@"NATIONALITY_STR"];
                        [defaults setObject:self->dobStr forKey:@"DOB"];
                        [defaults setObject:self->genderStr forKey:@"GENDER"];
                        
                        [self. navigationController pushViewController:verifyObj animated:YES];
                        
//                        _loader.hidden = YES;
//                        _btnBlur.hidden = YES;

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
    _genderTableView.hidden = YES;
    _nationalityTableView.hidden = YES;
    _CountryTableView.hidden = YES;
    _regionTableView.hidden = YES;
    _btnBlur.hidden = YES;
}
- (IBAction)btnTermsConditionsAction:(UIButton *)sender {
    NSURL* url = [[NSURL alloc] initWithString: @"http://biladl.com/Pages/terms"];
    [[UIApplication sharedApplication] openURL: url];
}
-(void)tfResignResponderMethod{
    [self.tfFullName resignFirstResponder];
    [self.tfIdentitynumber resignFirstResponder];
    [self.tfCountryCode resignFirstResponder];
    [self.tfMobileNumber resignFirstResponder];
    [self.tfEmailId resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    [self.tfConfirmPassword resignFirstResponder];
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
