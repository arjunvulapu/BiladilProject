//
//  HomeVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "HomeVC.h"
#import "AppDelegate.h"
#import <RESideMenu/RESideMenu.h>


#define Call_Center @"مركز الاتصال"
#define Chat @"دردشة"
#define Legal_Help @"مساعدة قانونية"
#define Legal_Advice_Faq @"المشورة القانونية"
#define Cyber_Defamation @"التشهير السيبراني"
#define Your_Lawyers @"الخاص بك"



@interface HomeVC ()<UICollectionViewDataSource,UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    NSArray * imagesArray;
    NSArray * namesArray;
    NSArray * namesArabicArray;
    NSString * lang;
    
    NSMutableArray * legalNewsArray;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    self.TV_Serach.hidden = YES;
    
    self.tfSearch.delegate = self;
    self.TV_Serach.dataSource = self;
    self.TV_Serach.delegate = self;
//    [SVProgressHUD show];
//    [SVProgressHUD dismiss];
    
//    [self showLoader];
    
    
    
    _homeCollectionView.dataSource = self;
    _homeCollectionView.delegate = self;
    
    self.tfSearch.layer.cornerRadius = 8;
    self.tfSearch.layer.masksToBounds = YES;
    
    if ([lang isEqualToString:@"1"]) {
        [self.tfSearch setLeftPadding:50];
    }else{
        [self.tfSearch setRightPadding:25];
    }
    
    
    imagesArray = @[@"call_center.png",@"chat.png",@"legal_advice&faq.png",@"legal_help.png",@"cyber_defamation.png",@"your_lawyers.png"];
    namesArray = @[@"CALL CENTER",@"CHAT",@"LEGAL ADVICE & FAQ'S",@"LEGAL HELP",@"CYBER DEFAMATION",@"YOUR LAWYERS"];//@"LEGAL HELP" //@"LEGAL ADVICE & FAQ'S"
    namesArabicArray = @[Call_Center,Chat,Legal_Help,Legal_Advice_Faq,Cyber_Defamation,Your_Lawyers];
    
    //legal_help.png //legal_advice&faq.png
}
-(void)viewWillAppear:(BOOL)animated{
    
   // [UIColor colorWithRed:255/255 green:211/255 blue:72/255 alpha:1] // yellow colour
   // [UIColor colorWithRed:204/255 green:204/255 blue:204/255 alpha:1]; // gray colour
    _homeImageView.image = [UIImage imageNamed:@"home_active"];
    _btnHome.titleLabel.textColor = [UIColor yellowColor];
    
    _notificationImageView.image = [UIImage imageNamed:@"notification_inactive"];
    _btnNotifications.titleLabel.textColor = [UIColor darkGrayColor]; // gray colour
    
    _chatImageView.image = [UIImage imageNamed:@"chat_inactive"];
    _btnChat.titleLabel.textColor = [UIColor darkGrayColor];
}


#pragma mark - CollectionView Delegates
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return namesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    HomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
    
    cell.homeImageView.image = [UIImage imageNamed:[imagesArray objectAtIndex:indexPath.row]];
    if ([lang isEqualToString:@"2"]) {
        cell.lblNames.text = [namesArabicArray objectAtIndex:indexPath.row];
    }else{
        cell.lblNames.text = [namesArray objectAtIndex:indexPath.row];
    }
        return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake((self.view.frame.size.width/2) - 15,180);
}

#pragma CollectionView Delegate Methods
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//        if (IS_IPHONE_5) {
//            return CGSizeMake(120,110);
//        }else if (IS_IPHONE_6P) {
//            return CGSizeMake(192,160);
//        }else{
//            return CGSizeMake(172,140);
//        }
////    return CGSizeMake(100,100);
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        CallCenterVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"CallCenterVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }if (indexPath.item == 1) {
        ChatVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }if (indexPath.item == 2) {
        LegalAdviceVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalAdviceVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
        
    }if (indexPath.item == 3) {
        LegalHelpVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalHelpVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }if (indexPath.item == 4) {
        CyberDefamationVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"CyberDefamationVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }if (indexPath.item == 5) {
        LawyersVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LawyersVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 1) {
        HomeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }if (item.tag == 2) {
        NotificationVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }if (item.tag == 3) {
        ChatVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }
}
- (IBAction)btnMenuAction:(UIButton *)sender {
//    [self.sideMenuViewController setContentViewController:LeftMenuViewController animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    if ([lang isEqualToString:@"1"]){
//        self.sideMenuViewController.panGestureEnabled = NO;
        [self.sideMenuViewController presentLeftMenuViewController];
    }else{
//        [self.sideMenuViewController presentLeftMenuViewController];
//        self.sideMenuViewController.panGestureEnabled = YES;
        [self.sideMenuViewController presentRightMenuViewController];
    }
    
}
- (IBAction)btnHomeAction:(UIButton *)sender {
    _homeImageView.image = [UIImage imageNamed:@"home_active"];
    _btnHome.titleLabel.textColor = [UIColor yellowColor];
    
    _notificationImageView.image = [UIImage imageNamed:@"notification_inactive"];
    _btnNotifications.titleLabel.textColor = [UIColor darkGrayColor];
    
    _chatImageView.image = [UIImage imageNamed:@"chat_inactive"];
    _btnChat.titleLabel.textColor = [UIColor darkGrayColor];
}
- (IBAction)btnNotificationsAction:(UIButton *)sender {
    _notificationImageView.image = [UIImage imageNamed:@"notification_active"];
    _btnNotifications.titleLabel.textColor = [UIColor yellowColor];
    
    _homeImageView.image = [UIImage imageNamed:@"home_inactive"];
    _btnHome.titleLabel.textColor = [UIColor darkGrayColor];
    
    _chatImageView.image = [UIImage imageNamed:@"chat_inactive"];
    _btnChat.titleLabel.textColor = [UIColor darkGrayColor];
    
    NotificationVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
}
- (IBAction)btnChatAction:(UIButton *)sender {
    _chatImageView.image = [UIImage imageNamed:@"chat_active"];
    _btnChat.titleLabel.textColor = [UIColor yellowColor];
    
    _homeImageView.image = [UIImage imageNamed:@"home_inactive"];
    _btnHome.titleLabel.textColor = [UIColor darkGrayColor];
    
    _notificationImageView.image = [UIImage imageNamed:@"notification_inactive"];
    _btnNotifications.titleLabel.textColor = [UIColor darkGrayColor];
    
    ChatVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
    [self.navigationController pushViewController:viewObj animated:YES];
}
- (IBAction)btnSearchCloseAction:(UIButton *)sender {
    _tfSearch.text = @"";
    self.TV_Serach.hidden = YES;
}

-(void)bookmarkAction:(UIButton *)sender{
    UIButton * btn = (UIButton *)sender;
    LegalNewsDetailVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalNewsDetailVC"];
    viewObj.idStr = [[legalNewsArray objectAtIndex:btn.tag]valueForKey:@"id"];
    viewObj.commingFrom = @"Home";
    viewObj.isBookMarked = [[legalNewsArray objectAtIndex:btn.tag]valueForKey:@"Bookmarked"];
    
    [self.navigationController pushViewController:viewObj animated:YES];
}

-(void)showLoader{
    
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.center = CGPointMake(160, 240);
//    spinner.tag = 12;
//    [self.view addSubview:spinner];
//    [spinner startAnimating];.
    
    UIBlurEffect *blurEffect = [[UIBlurEffect alloc]init];
    blurEffect.accessibilityNavigationStyle = UIBlurEffectStyleDark;
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
//    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    blurView.frame = self.view.frame;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.center = blurView.center;
    [blurView addSubview:spinner];
    [spinner startAnimating];
    [self.view addSubview:blurView];
    
//    let blurEffect: UIBlurEffect = UIBlurEffect(style: .Dark)
//    let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
//    blurView.translatesAutoresizingMaskIntoConstraints = false
//    blurView.frame = self.view.frame
    
//    let spinner = UIActivityIndicatorView(activityIndicatorStyle:.White)
//    spinner.center=blurView.center
//    blurView.addSubview(spinner)
//    spinner.startAnimating()
//
//    self.view.addSubview(blurView)
    
}
#pragma mark - TextField Delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.tfSearch) {
        
        if (textField.text.length > 0) {
            
            NSString *searchStr = [NSString stringWithFormat:@"%@%@",self.tfSearch.text,string];
            
            NSString * loginParams = [NSString stringWithFormat:@"{\"searchTYPE\":\"%@\",\"keywords\":\"%@\",\"userID\":\"%@\"}",@"NEWS",searchStr,[defaults valueForKey:@"USER_ID"]];
            //"userID":"1","searchTYPE":"APP_LAWYER","keywords":"i"} //NEWS
            [ServiceApI BiladilApis:@"all_serarch" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (error) {
                        NSLog(@"Error is:%@",[error localizedDescription]);
                        
                    }else{
                        if ([[result valueForKey:@"status"]intValue] == 1) {
                            legalNewsArray.removeAllObjects;
                            legalNewsArray = [[result valueForKey:@"response"]valueForKey:@"searched_result"];
                            if (legalNewsArray.count>0) {
                                self.TV_Serach.hidden = NO;
                                [self.TV_Serach reloadData];
                            }else{
//                                self.TV_Serach.hidden = YES;
                            }
                        }else{
//                            self.TV_Serach.hidden = YES;
                            legalNewsArray.removeAllObjects;
//                            [self newsServiceCall:0];
                        }
                        
                        [self.TV_Serach reloadData];
                    }
                });
            }];
        }else{
            legalNewsArray.removeAllObjects;
//            [self newsServiceCall:0];
        }
        
        
    }
    return YES;
}

#pragma mark - TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return legalNewsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopStoriesLegalNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TopStoriesLegalNewsCell"];
    if (cell == nil) {
        cell = [[TopStoriesLegalNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TopStoriesLegalNewsCell"];
    }
    cell.newsView.layer.cornerRadius = 3.0f;
    cell.newsView.clipsToBounds = YES;
    cell.lblTime.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"created_on"];
    cell.lblDescription.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[legalNewsArray objectAtIndex:indexPath.row] valueForKey:@"image"]]]];
    
    if ([[[legalNewsArray objectAtIndex:indexPath.row] valueForKey:@"Bookmarked"]isEqualToString:@"YES"]) {
        [cell.btnBookmark setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
    }else{
        [cell.btnBookmark setImage:[UIImage imageNamed:@"bookmark_gray.png"] forState:UIControlStateNormal];
    }

    
    if ([[[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"]  isEqual: @"YES"]) {
        
        [cell.btnBookmark setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnBookmark setImage:[UIImage imageNamed:@"bookmark_gray.png"] forState:UIControlStateNormal];
    }
    
    [cell.btnBookmark addTarget:self action:@selector(bookmarkAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnBookmark.tag = 1;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LegalNewsDetailVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalNewsDetailVC"];
    viewObj.idStr = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"id"];
    viewObj.commingFrom = @"Home";
    viewObj.isBookMarked = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"];
    
    [self.navigationController pushViewController:viewObj animated:YES];
}

#pragma mark - Service call

-(void)newsServiceCall:(NSInteger )param{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * params = [NSString stringWithFormat:@"{\"statPoint\":\"%ld\",\"userID\":\"%@\"}",(long)param,[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_more_legal_news" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1)
                {
                    
                    legalNewsArray= [[result valueForKey:@"response"]valueForKey:@"more_news"];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    //                    [activityIndicator stopAnimating];
//                    if (countsArray.count>0) {
//
//                        if (pointValue == 0) {
//                            legalNewsArray = [countsArray mutableCopy];
//                        }else{
//
//                            [legalNewsArray addObjectsFromArray:countsArray];
//                        }
//                        //                        self.legalNewsTableView.hidden = NO;
                    [self.TV_Serach reloadData];
                    }
                    else{
                    
                        MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    [t show];
                    return;
                }
            }
        });
    }];
}

@end
