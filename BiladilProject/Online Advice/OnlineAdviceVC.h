//
//  OnlineAdviceVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlineAdviceVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *adviceView;
@property (weak, nonatomic) IBOutlet UITextView *tvDescription;
@property (weak, nonatomic) IBOutlet UITextField *tfHeadLine;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseTopic;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIButton *btnUploadDocuments;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *tfEmailId;
@property (weak, nonatomic) IBOutlet UITextField *tfMobileNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmitQuestion;
@property (weak, nonatomic) IBOutlet UIButton *btnBlur;
@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (weak, nonatomic) IBOutlet UITableView *chooseTopicTableView;
@property (weak, nonatomic) IBOutlet UIView *mailMobileView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TV_Height;

@end
