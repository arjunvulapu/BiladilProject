//
//  AppDelegate.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "ServiceApI.h"
#import "MDToast.h"
#import "IMUtilities.h"
#import "ZCImagePickerController.h"
#import "BasicCell.h"
#import "LegalHelpCell.h"
#import "LegalAdviceCell.h"
#import "UseFulLinksVC.h"
#import "UsefulLinksCell.h"
#import "LawyersCell.h"
#import "HomeVC.h"
#import "HomeCollectionViewCell.h"
#import "ProfieVC.h"
#import "ChangeLanguageVC.h"
#import "SavedBookmarksVC.h"
#import "SubscriptionVC.h"
#import "ContactUsVC.h"
#import "AboutUsVC.h"
#import "UITextField+PaddingText.h"
#import "ForgotPasswordVC.h"
#import "UpdatePasswordVC.h"
#import "SignUpHomeVC.h"
#import "SignUpMemberVC.h"
#import "SignUpLawyerrVC.h"
#import "SignUpTraineeVC.h"
#import "LoginVC.h"
#import "RootViewController.h"
#import "CallCenterVC.h"
#import "LegalHelpVC.h"
#import "LegalAdviceVC.h"
#import "CyberDefamationVC.h"
#import "LawyersVC.h"
#import "ImagesCollectionViewCell.h"
#import "TraineeCollectionCell.h"
#import "LawyerCollectionCell.h"
#import "OtpVC.h"
#import <MaterialControls.h>
#import "TopStoriesLegalNewsVC.h"
#import "TopStoriesLegalNewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LegalNewsDetailVC.h"
#import "LegalNewsDetailsCell.h"
#import "LegalDocumentsVC.h"
#import "LegaldocumentsCell.h"
#import "ArticlesVC.h"
#import "ArticleDetailVC.h"
#import "ArticlesCollectionCell.h"
#import "ArticleDetailCell.h"
#import "FaqVC.h"
#import "FaqCell.h"
#import "OnlineAdviceVC.h"
#import <GFPageSlider.h>
#import "LegalNewsVC.h"
#import "LegalNewsCell.h"
#import "SavedBookmarkArticleVC.h"
#import "SavedBookmarkArticleCollectionCell.h"
#import "SubscriptionVC.h"
#import "SubscriptionCollectionCell.h"
#import "ChatVC.h"
#import "ChatCell1.h"
#import "ChatCell2.h"
#import "NotificationVC.h"
#import "ChatVC.h"
#import "OnlineAdviceCollectionCell.h"
#import "LeftMenuViewController.h"
#import "SelectPlanVC.h"
#import "SubscribePopUpVC.h"
#import "SavedBookMarkArticlesVC.h"
#import "SavedBookArticlesTVCell.h"
#import "HomeNavVC.h"
#import <SVProgressHUD.h>
#import "BiladilProject-Bridging-Header.h"
#import "SocialMediaVC.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define IS_HEIGHT_GTE_780 ([[UIScreen mainScreen ] bounds].size.height >= 780.0f)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *isSubscribed;

+(AppDelegate *)getDelegate;
-(void)sideMenu;

@end

