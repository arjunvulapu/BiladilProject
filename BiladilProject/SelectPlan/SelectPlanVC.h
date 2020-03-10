//
//  SelectPlanVC.h
//  BiladilProject
//
//  Created by iPrism on 09/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OPPWAMobile/OPPWAMobile.h>
#import <SafariServices/SafariServices.h>

//NS_ASSUME_NONNULL_BEGIN

@interface SelectPlanVC : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *CV_PlansPics;

@property (weak, nonatomic) IBOutlet UITextView *txtView_AboutPlan;

@property (weak, nonatomic) NSString * packageId;
@property (weak, nonatomic) NSString * packageTitle;

@property (weak, nonatomic) NSString *commingFrom;

@property (weak, nonatomic) IBOutlet UITableView *paymentTableView;
@property NSMutableString * package_amount;
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UILabel *membershipType;
@property (weak, nonatomic) IBOutlet UILabel *durationLbl;
@property (weak, nonatomic) IBOutlet UILabel *costLbl;
@property (weak, nonatomic) IBOutlet UILabel *grandtotalLbl;


@end

