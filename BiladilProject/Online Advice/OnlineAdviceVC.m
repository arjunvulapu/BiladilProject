//
//  OnlineAdviceVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "OnlineAdviceVC.h"
#import "AppDelegate.h"

@interface OnlineAdviceVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZCImagePickerControllerDelegate>
{
    NSArray * adviceArray;
    NSArray * chooseTopicArray;
    NSString * cityId;
    NSString * topicId;
    NSString * cityStr;
    NSString * topicStr;
    
    NSMutableArray *_imageViewArray;
    UIPopoverController *_popoverController;
    UIButton *_launchButton;
    NSString *profileImg;
    NSString *img1;
    NSString *img2;
    NSString *img3;
    
    NSString * lang;
}

@end

@implementation OnlineAdviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    _imageViewArray = [[NSMutableArray alloc]init];
    _imagesCollectionView.dataSource = self;
    
    if ([lang isEqualToString:@"1"]) {
        _tvDescription.text = @"Write text here";
    }else{
        _tvDescription.text = @"اكتب النص هنا";
    }
    
    _imagesCollectionView.delegate = self;
    
    _collectionViewHeightConstraint.constant = 0;
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        self->_mailMobileView.frame = CGRectMake(10, self->_btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
//    });
    
    
//    [self.adviceView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.adviceView.frame.size.height)];
//    [self.scrollView addSubview:self.adviceView];
//    [self.scrollView setContentSize:CGSizeMake(0, self.adviceView.frame.size.height)];

    _btnBlur.hidden = YES;
    _cityTableView.hidden = YES;
    _chooseTopicTableView.hidden = YES;
    _cityTableView.dataSource = self;
    _cityTableView.delegate = self;
    _chooseTopicTableView.dataSource = self;
    _chooseTopicTableView.delegate = self;
    _tfHeadLine.delegate = self;
    _tfMobileNumber.delegate = self;
    _tfEmailId.delegate = self;
    _tvDescription.delegate = self;
    
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
        return newLength <= 10;
        return YES;
    }
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
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _tvDescription.text = @"";
    _tvDescription.textColor = [UIColor blackColor];
    return YES;
}
-(void) textViewDidChange:(UITextView *)textView
{
    if(_tvDescription.text.length == 0){
        _tvDescription.textColor = [UIColor lightGrayColor];
        if ([lang isEqualToString:@"1"]) {
            _tvDescription.text = @"Write text here";
        }else{
            _tvDescription.text = @"اكتب النص هنا";
        }
        [_tvDescription resignFirstResponder];
    }
}
-(void) textViewShouldEndEditing:(UITextView *)textView
{
    if(_tvDescription.text.length == 0){
        _tvDescription.textColor = [UIColor lightGrayColor];
        if ([lang isEqualToString:@"1"]) {
            _tvDescription.text = @"Write text here";
        }else{
            _tvDescription.text = @"اكتب النص هنا";
        }
        [_tvDescription resignFirstResponder];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tfResignResponderMethod];
    return YES;
}
//-(void)regionServiceCall{
//    NSString * loginParams = [NSString stringWithFormat:@"{\"CountryID\":\"%@\"}",cityId];
//    [ServiceApI BiladilApis:@"citylist" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            if (error) {
//                NSLog(@"Error is:%@",[error localizedDescription]);
//
//            }else{
//                if ([[result valueForKey:@"status"]intValue] == 1) {
//                    cityArray = [result valueForKey:@"response"];
//                    [self.cityTableView reloadData];
//
//
//                }else{
//                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
//                    [t show];
//                }
//            }
//        });
//    }];
//}
-(void)chooseTopicServiceCall{
  //  NSString * loginParams = [NSString stringWithFormat:@"{\"CountryID\":\"%@\"}",cityId];
    [ServiceApI BiladilApis:@"get_all_topic" ItemStr:@"" withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    chooseTopicArray = [[result valueForKey:@"response"]valueForKey:@"get_topics"];
                    [self.chooseTopicTableView reloadData];
                    
                    self.TV_Height.constant = self.chooseTopicTableView.contentSize.height;
                    
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
//    if (tableView == self.cityTableView) {
//        return cityArray.count;
//    }if (tableView == self.chooseTopicTableView) {
        return chooseTopicArray.count;
//    }
//    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    
    if ([lang isEqualToString:@"1"]) {
        cell.textLabel.text = [[chooseTopicArray objectAtIndex:indexPath.row]valueForKey:@"topics"];
    }else{
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.textLabel.text = [[chooseTopicArray objectAtIndex:indexPath.row]valueForKey:@"topics_arbic"];
    }
    

    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:15.0];
    return cell;
}

#pragma TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    if (tableView == _cityTableView) {
//        [_btnCity setTitle:[cityArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//        cityId = [cityArray objectAtIndex:indexPath.row];
//        self.cityTableView.hidden = YES;
//    }if (tableView == _chooseTopicTableView) {
        _btnBlur.hidden = YES;
    
    
    if ([lang isEqualToString:@"1"]) {
        [_btnChooseTopic setTitle:[[chooseTopicArray objectAtIndex:indexPath.row]valueForKey:@"topics"] forState:UIControlStateNormal];
    }else{
        [_btnChooseTopic setTitle:[[chooseTopicArray objectAtIndex:indexPath.row]valueForKey:@"topics_arbic"] forState:UIControlStateNormal];
    }
    
    topicStr = [[chooseTopicArray objectAtIndex:indexPath.row]valueForKey:@"topics"];
        topicId =  [[chooseTopicArray objectAtIndex:indexPath.row]valueForKey:@"id"];
        self.chooseTopicTableView.hidden = YES;
//    }
}

- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnChooseTopicAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _btnBlur.hidden = NO;
    _cityTableView.hidden = YES;
    _chooseTopicTableView.hidden = NO;
    [self chooseTopicServiceCall];
}
- (IBAction)btnSelectCityAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    _btnBlur.hidden = NO;
    _cityTableView.hidden = YES;
    _chooseTopicTableView.hidden = YES;
}
- (IBAction)btnUploadDocumentsAction:(UIButton *)sender {
    [self tfResignResponderMethod];
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
    
    [self dismissViewControllerAnimated:true completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // [self showLoadingIndicator];
            
            // self.profileImg.image = image;
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
            profileImg = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        });
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - ZCImagePickerControllerDelegate

- (void)zcImagePickerController:(ZCImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(NSArray *)info {
    _collectionViewHeightConstraint.constant = 120;
    _imagesCollectionView.hidden = NO;
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self->_mailMobileView.frame = CGRectMake(10, _imagesCollectionView.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
        [self dismissPickerView];
//    });
    
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
    
//    _mailMobileView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageViewArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OnlineAdviceCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnlineAdviceCollectionCell" forIndexPath:indexPath];
    cell.adviceImageView.clipsToBounds=YES;
    cell.adviceImageView.image=[_imageViewArray objectAtIndex:indexPath.row];
    [cell.btnImageClose addTarget:self action:@selector(CancelAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnImageClose.tag=indexPath.row;
    return cell;
    
}
-(void)CancelAction:(UIButton *)sender{
    [_imageViewArray removeObjectAtIndex:sender.tag];
    if (_imageViewArray.count>0) {
        [_imagesCollectionView reloadData];
    }else{
        _collectionViewHeightConstraint.constant = 0;
//        _imagesCollectionView.hidden = YES;
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self->_mailMobileView.frame = CGRectMake(10, _btnUploadDocuments.frame.origin.y+10, [[UIScreen mainScreen] bounds].size.width-20, 130);
//        });
    }
}
- (IBAction)btnSubmitQuestionAction:(UIButton *)sender {
    [self tfResignResponderMethod];
    if ([_tvDescription.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Query" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfHeadLine.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Query head" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([topicStr isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Select Topic" duration:kMDToastDurationShort];
        [t show];
        return;
    }if ([_tfCity.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter City" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (_imageViewArray.count == 0) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Upload Atleast One Document" duration:kMDToastDurationShort];
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
    }if ([_tfMobileNumber.text isEqualToString:@""]) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }if (self.tfMobileNumber.text.length<10) {
        MDToast *t = [[MDToast alloc]initWithText:@"Please Enter Valid Mobile Number" duration:kMDToastDurationShort];
        [t show];
        return;
    }
    [self onlineAdviceServiceCall];
    
}
-(void)onlineAdviceServiceCall{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * params = [NSString stringWithFormat:@"{\"userID\":\"%@\",\"email_ID\":\"%@\",\"mobile\":\"%@\",\"topicID\":\"%@\",\"topic\":\"%@\",\"questionHEAD\":\"%@\",\"city\":\"%@\",\"Description\":\"%@\",\"userDocuments\":\"%@\",\"userDocuments1\":\"%@\",\"userDocuments2\":\"%@\"}",[defaults valueForKey:@"USER_ID"],_tfEmailId.text,_tfMobileNumber.text,topicId,topicStr,_tfHeadLine.text,_tfCity.text,_tvDescription.text,img1,img2,img3];
    
//    mobile,email_ID,userID,topicID,topic,questionHEAD,city,Description,userDocuments,userDocuments1,userDocuments2
    
    [ServiceApI BiladilApis:@"ask_advice" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                    HomeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                    [self.navigationController pushViewController:viewObj animated:YES];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
-(void)tfResignResponderMethod{
    _tfHeadLine.delegate = self;
    _tfMobileNumber.delegate = self;
    _tfEmailId.delegate = self;
}
- (IBAction)btnBlurAction:(UIButton *)sender {
    self.chooseTopicTableView.hidden = YES;
        self.btnBlur.hidden = YES;
}
@end
