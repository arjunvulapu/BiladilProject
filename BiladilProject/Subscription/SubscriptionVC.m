//
//  SubscriptionVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SubscriptionVC.h"
#import "AppDelegate.h"
#import "SubscriptionCollectionCell.h"
#import <MDToast.h>
#import <RESideMenu.h>



@interface SubscriptionVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray * subscriptionArray;
    NSArray * planImagesArray;
    //    NSMutableArray *plansArray;
    NSString * packageIdStr;
    NSString * packageTitle;
    NSString * packagePrice;
    
    NSAttributedString *empty;
    
    UINavigationController * nav;
    
    NSString *lng;
    
}

@end

@implementation SubscriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lng = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    self.viewHeightConstraint.constant = 0;
    
    _tvDescription.attributedText = [[NSAttributedString alloc]initWithString:@""];
    
    //    plansArray = [NSMutableArray new];
    _subcriptionCollectionView.dataSource = self;
    _subcriptionCollectionView.delegate = self;
    
//    _tvDescription.font = [UIFont fontWithName:@"Montserrat Regular" size:20];
    
    if (self.isFirstTime) {
        self.isFirstTime = NO;
        self.btn_Back.hidden = YES;
        self.btn_Skip.hidden = NO;
    }else{
        self.btn_Back.hidden = NO;
        self.btn_Skip.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _tvDescription.attributedText = [[NSAttributedString alloc]initWithString:@""];
    
    [self service_checkSubscribe];
    [self subscriptionServiceCall];
}



- (IBAction)btn_JoinNow:(id)sender {
    
    SelectPlanVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectPlanVC"];
    
    viewObj.packageId = packageIdStr;
    viewObj.packageTitle = packageTitle;
    viewObj.package_amount = packagePrice;
    
    if ([self.commingFrom isEqualToString:@"POP_UP"]){
        viewObj.commingFrom = @"POP_UP";
        [self presentViewController:viewObj animated:NO completion:nil];
    }else{
        [self.navigationController pushViewController:viewObj animated:YES];
    }
}

- (IBAction)btn_SkipAction:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]) {
        
        UIStoryboard *st=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"LANGUAGE"];
        RootViewController *navTo=[st instantiateViewControllerWithIdentifier:@"RootViewController"];
        [self.navigationController pushViewController:navTo animated:YES];
    }else{
        
        UIStoryboard *st=[UIStoryboard storyboardWithName:@"Arabic" bundle:nil];
        
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"LANGUAGE"];
        RootViewController *navTo=[st instantiateViewControllerWithIdentifier:@"RootViewController"];
        [self.navigationController pushViewController:navTo animated:YES];
    }
    
    
}

- (IBAction)btnBackAction:(UIButton *)sender {
    
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    for (UIViewController *aViewController in allViewControllers)
    {
        if ([aViewController isKindOfClass:[HomeVC class]])
        {
            
            [self.navigationController popToViewController:aViewController animated:YES];
            
            
        }
    }
    
    //    AppDelegate *appdel = AppDelegate.getDelegate;
    //    [appdel sideMenu];
    
    
    
    //    AppDelegate *appdDelRef = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    [AppDelegate sideMenu];
    //    [appdDelRef sideMenu];
    
    
    //    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[HomeVC alloc] init]];
    //    LeftMenuViewController *leftMenuViewController = [[LeftMenuViewController alloc] init];
    //    LeftMenuViewController *rightMenuViewController = [[LeftMenuViewController alloc] init];
    //
    //    // Create side menu controller
    //    //
    //    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
    //                                                                    leftMenuViewController:leftMenuViewController
    //                                                                   rightMenuViewController:rightMenuViewController];
    //
    //    self.window.rootViewController = sideMenuViewController;
    
    
    
    
    //    let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
    //    let homeVC = storyBoard.instantiateViewController(withIdentifier: id_HomeVC) as! HomeVC
    //    let homeVCNav = UINavigationController(rootViewController: homeVC)
    //    let leftVC = storyBoard.instantiateViewController(withIdentifier: id_MenuVC) as! MenuVC
    //
    //    reSideMenu = RESideMenu(contentViewController: homeVCNav, leftMenuViewController: leftVC, rightMenuViewController: nil)
    //
    //    self.window?.rootViewController = reSideMenu
    
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(void)subscriptionServiceCall{
    //  NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",@"2"];
    [ServiceApI BiladilApis:@"get_all_package" ItemStr:@"" withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->subscriptionArray = [[result valueForKey:@"response"]valueForKey:@"packages"];
                    
                    if (self->subscriptionArray.count>0) {
                        [self.subcriptionCollectionView reloadData];
                        
                    self->_tvDescription.hidden = NO;
                        
                    }else {
                        self->_tvDescription.hidden = YES;
                    }
//                    self->_tvDescription.font = [UIFont fontWithName:@"Montserrat Regular" size:20.0];
                    
                    self->packageIdStr = [[self->subscriptionArray objectAtIndex: 0] valueForKey:@"id"];
                    self->packageTitle = [[self->subscriptionArray objectAtIndex: 0] valueForKey:@"title"];
                    self->packagePrice = [[self->subscriptionArray objectAtIndex: 0] valueForKey:@"price"];
                    //price
                    //                    NSLog(@"Subscription Data---> %@",subscriptionArray);
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

-(void)service_checkSubscribe{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_current_package" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    
//                    NSLog(@"%@", result);
//                    NSLog(@"%@", [result valueForKey:@"response"]);
                    
                    if (result.count > 0) {
                        self.activatedPlanView.hidden = NO;
                        self.viewHeightConstraint.constant = 110;
                        
                        NSDictionary *respDict = [result valueForKey:@"response"];
                        
                        if ([self->lng isEqualToString:@"1"]) {
                            
                            self.lblPlanName.text = [NSString stringWithFormat:@"%@ Plan (Subscribed)",respDict[@"title"]];
                            self.lblValidDate.text = [NSString stringWithFormat:@"Valid Upto %@",respDict[@"expires_on"]];
                        }else{
                            NSString *plan = [NSString stringWithFormat:@"%@",respDict[@"title"]];
                            NSString *planStr = @"خطة";
                            //                            NSString *subcribedStr = @"(المشترك)";
                            self.lblPlanName.text = [NSString stringWithFormat:@"(المشترك) %@ %@", planStr, plan];
                            self.lblValidDate.text = [NSString stringWithFormat:@"صالح حتى %@",respDict[@"expires_on"]];
                        }
                    }else {
                        self.viewHeightConstraint.constant = 0;
                    }
                }else{
                    
                    self.activatedPlanView.hidden = YES;
                    
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}


#pragma mark - CollectionView DataSource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;//subscriptionArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SubscriptionCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubscriptionCollectionCell" forIndexPath:indexPath];
    
    //            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //            NSString *dateStr1 = [[homeNewsScrollingArray objectAtIndex:indexPath.row]valueForKey:@"created_at"];
    //            //  NSString *dateStr2 = @"2018-09-24 05:27";
    //            NSDate *date1 = [dateFormat dateFromString:dateStr1];
    //            NSDate *date2 = [NSDate date];
    //
    //            NSString *str = [ServiceApI remaningTime:date1 endDate:date2 previousDate:dateStr1];
    //            NSLog(@"STR is %@",str);
    
    
    
    NSDictionary *dataDict = [NSDictionary new];
    dataDict = subscriptionArray[indexPath.row];
    
    
    //    cell.planImageView = [planImagesArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        
        cell.planImageView.image = [UIImage imageNamed:@"plan_Gold"]; //[planImagesArray objectAtIndex:indexPath.row];
        
    }else if (indexPath.row == 1) {
        cell.planImageView.image = [UIImage imageNamed:@"plan_GoldPlus"];
        
    }else if (indexPath.row == 2) {
        cell.planImageView.image = [UIImage imageNamed:@"plan_Platinum"];
        
    }
    
    //    _lblPlanName.text = [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    //
    //    cell.lbl_PlanStatus.text = [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]){
        
        NSString * htmlString = [NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description"]];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        _tvDescription.attributedText = attrStr;
        
//        _tvDescription.attributedText = [ServiceApI displayHTMLContent:[NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description"]]];
        
    }else{
        
        NSString * htmlString = [NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"]];
        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        _tvDescription.attributedText = attrStr;
        
//        _tvDescription.attributedText = [ServiceApI displayHTMLContent:[NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"]]];
        //[[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"];
    }
    
//    _tvDescription.font = [UIFont fontWithName:@"Montserrat Regular" size:20.0];
    
    self.tvDescription.font = [UIFont fontWithName:@"Montserrat-Regular" size:15.0];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    for (UICollectionViewCell *cell in [self.subcriptionCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.subcriptionCollectionView indexPathForCell:cell];
        //        NSLog(@"%@",indexPath);
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]){
            
            NSString * htmlString = [NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description"]];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            _tvDescription.attributedText = attrStr;
            
//            _tvDescription.attributedText = [ServiceApI displayHTMLContent:[NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description"]]];
        }else{
            
            NSString * htmlString = [NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"]];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            _tvDescription.attributedText = attrStr;
            
//            _tvDescription.attributedText = [ServiceApI displayHTMLContent:[NSString stringWithFormat:@"%@", [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"]]];
        }
//        _tvDescription.font = [UIFont fontWithName:@"Montserrat Regular" size:20.0];
        //        _tvDescription.text = [[subscriptionArray objectAtIndex:indexPath.row]valueForKey:@"description"];
        
        packageIdStr = [[subscriptionArray objectAtIndex: indexPath.row] valueForKey:@"id"];
        packageTitle = [[subscriptionArray objectAtIndex: indexPath.row] valueForKey:@"title"];
        packagePrice = [[subscriptionArray objectAtIndex: indexPath.row] valueForKey:@"price"];
        //price
        
        self.tvDescription.font = [UIFont fontWithName:@"Montserrat-Regular" size:15.0];
        
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // update size accordingly
    //    CGSizeMake(self.view.frame.size.width - 20,180);
    return CGSizeMake(collectionView.frame.size.width,collectionView.frame.size.height);
}

#pragma CollectionView Delegate Methods
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-140);
//}



@end
