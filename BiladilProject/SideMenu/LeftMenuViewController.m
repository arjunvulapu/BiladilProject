//
//  LeftMenuViewController.m
//  BiladilProject
//
//  Created by mac on 16/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "BiladilProject-Bridging-Header.h"

#define My_Profile @"الملف الشخصي"
#define Change_Language @"غير اللغة"
#define Saved_Bookmark @"المرجعية المحفوظة"
#define Subscriptions @"خطة الاشتراك"
#define Share @"شارك"
#define Rate_Us @"قيمنا"
#define Contact_Us @"اتصل بنا"
#define About_Us @"معلومات عنا"
#define Logout @"الخروج"

#define SocialMedia @"صفحات وسائل التواصل الاجتماعي"


@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * nameArr;
    NSArray * arabicNamesArray;
    NSArray * imagesArr;
    int selectedIndex;
    NSString * lang;
}

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    nameArr=[NSArray arrayWithObjects:@"My Profile", @"Change Language", @"Saved Bookmarks", @"Subscriptions", @"Share", @"Rate us", @"Contact us", @"Social Media Pages", @"About us", @"Logout", nil];
    
    arabicNamesArray = @[My_Profile,Change_Language,Saved_Bookmark,Subscriptions,Share,Rate_Us,Contact_Us, SocialMedia,About_Us,Logout];
    imagesArr=[NSArray arrayWithObjects:@"my_profile",@"change_language",@"bookmark",@"subscription",@"share",@"rate_us",@"contact_us", @"socialMedia", @"info",@"logout",nil];
    _lblUserName.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER_NAME"];//@"Supritha Choudiny";
    
    _profileImageView.layer.cornerRadius = _profileImageView.frame.size.width/2;
    _profileImageView.layer.masksToBounds = YES;
    
    
//    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults]valueForKey:@"profile_pic"]] placeholderImage:@"profile.png"];//[UIImage imageNamed:@"profile.png"];
    _menuTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.opaque = NO;
    //    _tableView.backgroundColor = [UIColor blackColor];
   // _menuTableView.backgroundView = nil;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _menuTableView.bounces = NO;
    _menuTableView.scrollsToTop = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSString *img = [[NSUserDefaults standardUserDefaults]valueForKey:@"profile_pic"];
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:img]
                         placeholderImage:[UIImage imageNamed:@"profile.png"]];
    
}


#pragma mark -
#pragma mark UITableView Delegates and Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return nameArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
   // cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    if (indexPath.row == selectedIndex) {
        cell.contentView.backgroundColor = [UIColor clearColor];
    } else {
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    if ([lang isEqualToString:@"1"]){
//        cell.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
        UIImageView *imgSide = [[UIImageView alloc]initWithFrame:CGRectMake(20,25, 20, 20)];
        imgSide.image =[UIImage imageNamed:[imagesArr objectAtIndex:indexPath.row]];
        imgSide.clipsToBounds=YES;
        [cell addSubview:imgSide];
        
        UILabel *lblname =[[UILabel alloc]initWithFrame:CGRectMake(50,12,190,45)];
        lblname.font=[UIFont fontWithName:@"Montserrat-Regular" size:15];
        lblname.textColor=[UIColor darkTextColor];
        lblname.textAlignment=NSTextAlignmentLeft;
        if ([lang isEqualToString:@"2"]) {
            lblname.text=[arabicNamesArray objectAtIndex:indexPath.row];
        }else{
            lblname.text=[nameArr objectAtIndex:indexPath.row];
        }
        lblname.numberOfLines=0;
        [cell addSubview:lblname];
        
    }else{
        
        
//        UIImageView *imgSide = [[UIImageView alloc]initWithFrame:CGRectMake(100,25, 20, 20)];
//        imgSide.image =[UIImage imageNamed:[imagesArr objectAtIndex:indexPath.row]];
//        imgSide.clipsToBounds=YES;
//
//
//        UILabel *lblname =[[UILabel alloc]initWithFrame:CGRectMake(50,12,190,45)];
//        lblname.font=[UIFont fontWithName:@"Montserrat-Regular" size:15];
//        lblname.textColor=[UIColor darkTextColor];
//        lblname.textAlignment=NSTextAlignmentLeft;
//
//
//
//        if ([lang isEqualToString:@"2"]) {
//            lblname.text=[arabicNamesArray objectAtIndex:indexPath.row];
//        }else{
//            lblname.text=[nameArr objectAtIndex:indexPath.row];
//        }
//        lblname.numberOfLines=0;
//        [cell addSubview:lblname];
//
////        cell.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
//        [cell addSubview:imgSide];
        
        
       
        
        
        UILabel *lblname =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 350,12,160,45)]; //self.view.frame.size.width - 290
        lblname.font=[UIFont fontWithName:@"Montserrat-Regular" size:15];
        lblname.textColor=[UIColor darkTextColor];
        lblname.textAlignment=NSTextAlignmentRight;
        
        UIImageView *imgSide = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 170,25, 20, 20)]; // cell.contentView.frame.size.width - 120
        imgSide.image =[UIImage imageNamed:[imagesArr objectAtIndex:indexPath.row]];
        imgSide.clipsToBounds=YES;
        
        if ([lang isEqualToString:@"2"]) {
            lblname.text=[arabicNamesArray objectAtIndex:indexPath.row];
        }else{
            lblname.text=[nameArr objectAtIndex:indexPath.row];
        }
        lblname.numberOfLines=0;
        [cell addSubview:lblname];
        [cell addSubview:imgSide];
        
        
    }
    
    
    
    return cell;
    
}


    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    UITableViewCell *cell = [_menuTableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    selectedIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
    
    
    if (indexPath.row == 0) {
        ProfieVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfieVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }if (indexPath.row == 1) {
        ChangeLanguageVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeLanguageVC"];
        viewObj.fromPage = @"MENU";
        [self.navigationController pushViewController:viewObj animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }if (indexPath.row == 2) {
        SavedBookmarksVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedBookmarksVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }if (indexPath.row == 3) {
        SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }if (indexPath.row == 4) {
        {
            //  NSString *userID=[[NSUserDefaults standardUserDefaults]valueForKey:@"UserID"];
            
            //   NSString *str=[NSString stringWithFormat:@"%@",@"http://onelink.to/k9ymd"];
            NSString *str=[NSString stringWithFormat:@"%@",@"https://itunes.apple.com/us/app/biladl/id1462257989?mt=8&ign-mpt=uo%3D2"];
            //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            NSString *textToShare =[NSString stringWithFormat:@"%@", @"Share 'Biladl' with your family & friends"];
            NSURL *myWebsite = [NSURL URLWithString:str];
            
            NSArray *objectsToShare = @[textToShare, myWebsite];
            
            UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
            
            NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                           UIActivityTypePrint,
                                           UIActivityTypeAssignToContact,
                                           UIActivityTypeSaveToCameraRoll,
                                           UIActivityTypeAddToReadingList,
                                           UIActivityTypePostToFlickr,
                                           UIActivityTypePostToVimeo];
            
            activityVC.excludedActivityTypes = excludeActivities;
            
            [self presentViewController:activityVC animated:YES completion:nil];
        }
    }if (indexPath.row == 5) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/biladl/id1462257989?mt=8&ign-mpt=uo%3D2"]];
        
//        NSString *iTunesLink = @"https://itunes.apple.com/us/app/biladl/id1462257989?mt=8&ign-mpt=uo%3D2";
//        [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:iTunesLink]];
    }if (indexPath.row == 6) {
        
        ContactUsVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 7) {
     
        SocialMediaVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SocialMediaVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }
    
    if (indexPath.row == 8) {
        AboutUsVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
        [self.sideMenuViewController hideMenuViewController];
    }if (indexPath.row == 9) {
        NSString * userId = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER_ID"];
        if (userId.length>0) {
            
            
            NSString *confirm;
            
            NSString *msg;
            NSString *no;
            NSString *yes;
            if ([lang isEqualToString:@"2"]) {
                msg=@"متأكد تبي تطلع ؟";
                no=@"لا";
                yes=@"ايه";
                confirm=@"التأكيد";
                
            }
            else{
                msg=@"Are you sure you want to logout?";
                no=@"NO";
                yes=@"YES";
                confirm=@"Confirmation";
            }
            UIAlertController * alert= [UIAlertController
                                        alertControllerWithTitle:confirm
                                        message:msg
                                        preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:no
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action) {
                                           //Handle no, thanks button
                                       }];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:yes
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            
                                            // navTo.fromPage=@"menu";
                                            
                                            //   [self UpdateDeviceToken];
                                            LoginVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                                            [defaults setObject:@"" forKey:@"USER_ID"];
                                            
                                            [self.navigationController pushViewController:viewObj animated:YES];
                                            
                                        }];
            [yesButton setValue:[UIColor greenColor] forKey:@"titleTextColor"];
            [noButton setValue:[UIColor redColor] forKey:@"titleTextColor"];
            //    [alert setValue:@(Radius) forKey:@"cornerRadius"];
            [alert.view setBackgroundColor:[UIColor whiteColor]];
            [alert addAction:noButton];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
        }
        
    }
}


@end
