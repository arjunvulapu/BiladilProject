//
//  SubscriptionVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SubscriptionVC;
@protocol CustomDelegate <NSObject>
//@optional
-(void)dismissVC;
@end

@interface SubscriptionVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *activatedPlanView;
@property (weak, nonatomic) IBOutlet UILabel *lblPlanName;
@property (weak, nonatomic) IBOutlet UILabel *lblValidDate;
@property (weak, nonatomic) IBOutlet UICollectionView *subcriptionCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lblPlanDescription;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *tvDescription;

@property (weak, nonatomic) NSString *commingFrom;
@property (nonatomic) BOOL isFirstTime;

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UIButton *btn_Back;
@property (weak, nonatomic) IBOutlet UIButton *btn_Skip;

@property (nonatomic, weak) id<CustomDelegate> delegate;

@end
