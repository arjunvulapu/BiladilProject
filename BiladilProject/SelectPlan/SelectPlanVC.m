//
//  SelectPlanVC.m
//  BiladilProject
//
//  Created by iPrism on 09/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SelectPlanVC.h"
#import "CVCellSelectPlan.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "BiladilProject-Bridging-Header.h"
#import "SelectPaymentTC.h"
@interface SelectPlanVC ()<UICollectionViewDelegate, UICollectionViewDataSource,OPPCheckoutProviderDelegate,SFSafariViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *selectPlanArray;
    NSString * checkoutID;
    OPPPaymentProvider * provider;
    OPPCheckoutProvider * checkoutProvider;
    NSUserDefaults * defaults;
    NSMutableArray *paymentTypeArray;
    NSString *selectedPaymentType;

}

@end

@implementation SelectPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CV_PlansPics.delegate = self;
    self.CV_PlansPics.dataSource = self;
    paymentTypeArray = [[NSMutableArray alloc] initWithObjects:@"Sadad Bills",@"Visa",@"Master", nil];
    selectedPaymentType = paymentTypeArray[0];
    _borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _borderView.layer.borderWidth = 1.0;
    [self service_SelectPlan];
    defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:@"NO" forKey:@"PAYMENT_DONE"];
    [defaults synchronize];

}
- (void)viewWillAppear:(BOOL)animated{
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSString * str = [defaults valueForKey:@"PAYMENT_DONE"];
    if ([str isEqualToString:@"YES"]) {
        [self Service_HyperPayStatus];
    }else{
        
    }
    
    
    
}

-(void)Service_HyperPayStatus{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"transID\":\"%@\",\"packageID\":\"%@\",\"userID\":\"%@\"}",checkoutID,self.packageId,[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"Hyper_Status" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                
                self->selectPlanArray = [[NSMutableArray alloc]init];
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    //                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    //                    [t show];
                    NSString *code = [[[result valueForKey:@"response"] valueForKey:@"result"] valueForKey:@"code"];
                    NSString *description = [[[result valueForKey:@"response"] valueForKey:@"result"] valueForKey:@"description"];

                    if([code  isEqual: @"000.100.112"] || [code  isEqual: @"000.200.100"]){
                        [self service_Subscribe];
                    }else{
                        MDToast *t = [[MDToast alloc]initWithText:description duration:kMDToastDurationShort];
                                           [t show];
                    }
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
- (IBAction)btn_BackTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:false];
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)checkoutIdGettingServiceCall{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * paymentParams = [NSString stringWithFormat:@"{\"userID\":\"%@\",\"packageID\":\"%@\",\"amount\":\"%@\",\"currency\":\"%@\",\"payment_type\":\"%@\"}",[defaults valueForKey:@"USER_ID"],self.packageId,self.package_amount,@"SAR",@"DB"];
    
    [ServiceApI BiladilApis:@"user_package_checkout" ItemStr:paymentParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->checkoutID = [[result valueForKey:@"response"]valueForKey:@"id"];
                    
                    if (![self->checkoutID isEqualToString:@""]) {
                        
                        ViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:self->checkoutID forKey:@"CHECKOUT_ID"];
                        //  vc.checkoutID = checkoutID;
                        [self.navigationController pushViewController:vc animated:true];
                        // [self paymentGatewayMethod];
                    }
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

-(void)paymentGatewayMethod{
    provider = [OPPPaymentProvider paymentProviderWithMode:OPPProviderModeTest];
    
    
    //    OPPCheckoutSettings *checkoutSettings = [[OPPCheckoutSettings alloc] init];
    //    checkoutSettings.shopperResultURL = @"com.iPrism.Biladl.payments.payments://result";
    
    
    OPPCheckoutSettings * checkoutSettings = [[OPPCheckoutSettings alloc] init];
    // Set available payment brands for your shop
    checkoutSettings.paymentBrands = @[@"VISA", @"DIRECTDEBIT_SEPA"];
    
    // Set shopper result URL
    
    checkoutSettings.shopperResultURL = @"com.iPrism.Biladl.payments://result";
    // checkoutSettings.shopperResultURL = @"com.iPrism.Biladl.payments";
    
    OPPCheckoutProvider *checkoutProvider = [OPPCheckoutProvider checkoutProviderWithPaymentProvider:provider checkoutID:checkoutID settings:checkoutSettings];
    
    
    [checkoutProvider presentCheckoutForSubmittingTransactionCompletionHandler:^(OPPTransaction * _Nullable transaction, NSError * _Nullable error) {
        
        
        // Handle transaction submitting result as shown in previous sample
    } paymentBrandSelectedHandler:nil cancelHandler:^{
        
        // Executed if the shopper closes the payment page prematurely
    }];
    checkoutProvider.delegate = self;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.scheme caseInsensitiveCompare:@"com.iPrism.Biladl.payments"] == NSOrderedSame) {
        [checkoutProvider dismissCheckoutAnimated:YES completion:^{
            // request payment status
        }];
        return YES;
    } else {
        return NO;
    }
}

- (void)checkoutProvider:(OPPCheckoutProvider *)checkoutProvider continueSubmitting:(OPPTransaction *)transaction completion:(void (^)(NSString * _Nullable checkoutID, BOOL abort))completion {
    
    NSString *URL = [NSString stringWithFormat:@"http://biladl.com/app/Ws//paymentStatus?resourcePath=%@", [transaction.resourcePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest * merchantServerRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:merchantServerRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle error
        //        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //        BOOL status = [result[@"paymentResult"] boolValue];
    }] resume];
    
    completion(transaction.paymentParams.checkoutID, false);
}

- (IBAction)btn_PurchaseSubscription:(id)sender {
    
//    MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"Payment Comming soon."] duration:kMDToastDurationShort];
//    [t show];
    [self checkoutIdGettingServiceCall];
}

#pragma mark - Functions

-(void)service_SelectPlan{
    NSString * usefulParams = [NSString stringWithFormat:@"{\"packageID\":\"%@\"}",self.packageId];
    [ServiceApI BiladilApis:@"get_full_package" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                
                self->selectPlanArray = [[NSMutableArray alloc]init];
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->selectPlanArray = [[result valueForKey:@"response"]valueForKey:@"package_details"];
                    
                    //                    NSLog(@"Package details array --> %@",self->selectPlanArray);
                    
                    if (self->selectPlanArray.count>0) {
                        //                        [self.subcriptionCollectionView reloadData];
                    }
                    
                    //                    NSLog(@"Subscription Data---> %@",self->selectPlanArray);
                    
                    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]){
                        
                        NSString * htmlString = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [self->selectPlanArray valueForKey:@"description"]]];
                        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                        
                        self.txtView_AboutPlan.attributedText = attrStr;
                        
                        self.membershipType.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [self->selectPlanArray valueForKey:@"title"]]];
                        self.durationLbl.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@ Days", [self->selectPlanArray valueForKey:@"total_days"]]];
                        self.costLbl.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@ SAR", [self->selectPlanArray valueForKey:@"price"]]];
                        self.grandtotalLbl.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"Grand Total: %@ SAR", [self->selectPlanArray valueForKey:@"price"]]];

                        
                        //                        self.txtView_AboutPlan.attributedText = [ServiceApI displayHTMLContent:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [self->selectPlanArray valueForKey:@"description"]]]];
                    }else{
                        
                        NSString * htmlString = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [self->selectPlanArray valueForKey:@"description_arbic"]]];
                        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                        
                        self.txtView_AboutPlan.attributedText = attrStr;
                        self.membershipType.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [self->selectPlanArray valueForKey:@"title_arabic"]]];
                    self.durationLbl.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@ Days", [self->selectPlanArray valueForKey:@"total_days"]]];
                        self.costLbl.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@ SAR", [self->selectPlanArray valueForKey:@"price"]]];
                        self.grandtotalLbl.text = [NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"Grand Total: %@ SAR", [self->selectPlanArray valueForKey:@"price"]]];
                        
                        //                        self.txtView_AboutPlan.attributedText = [ServiceApI displayHTMLContent:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@", [self->selectPlanArray valueForKey:@"description_arbic"]]]];
                    }
                    self.txtView_AboutPlan.font = [UIFont fontWithName:@"Montserrat-Regular" size:15.0];
                    
                    //                    self.txtView_AboutPlan.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [self->selectPlanArray valueForKey:@"description"]]];
                    
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

-(void)service_Subscribe{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"packageID\":\"%@\",\"userID\":\"%@\"}",self.packageId,[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"user_package_subscription" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                
                self->selectPlanArray = [[NSMutableArray alloc]init];
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    [defaults setObject:@"NO" forKey:@"PAYMENT_DONE"];
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isSubscribed"];
                    
                    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]){
                        
                        UIStoryboard *st=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        RootViewController *navTo=[st instantiateViewControllerWithIdentifier:@"RootViewController"];
                        [self.navigationController pushViewController:navTo animated:YES];
                    }
                    else{
                    }
                    
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

#pragma mark - CollectionView Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CVCellSelectPlan *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CVCellSelectPlan" forIndexPath:indexPath];
    
    if ([self.packageTitle isEqualToString:@"GOLD"]) {
        cell.imgView_Plan.image = [UIImage imageNamed:@"plan_Gold"];
    }else if ([self.packageTitle isEqualToString:@"GOLDPLUS"]) {
        cell.imgView_Plan.image = [UIImage imageNamed:@"plan_GoldPlus"];
    }else if ([self.packageTitle isEqualToString:@"PLATINUM"]) {
        cell.imgView_Plan.image = [UIImage imageNamed:@"plan_Platinum"];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // update size accordingly
    //    CGSizeMake(self.view.frame.size.width - 20,180);
    return CGSizeMake(collectionView.frame.size.width,collectionView.frame.size.height);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectPaymentTC * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPaymentTC"];
    if (cell == nil) {
        cell = [[SelectPaymentTC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectPaymentTC"];
    }
    if([selectedPaymentType isEqualToString:[NSString stringWithFormat:@"%@",[paymentTypeArray objectAtIndex:indexPath.row]]]){
        [cell.shoeImage setImage:[UIImage imageNamed:@"checkmark.png"]];
    }else{
        [cell.shoeImage setImage:[UIImage imageNamed:@"checkmark 1.png"]];
    }
    cell.typeLbl.text = [NSString stringWithFormat:@"%@",[paymentTypeArray objectAtIndex:indexPath.row]];
    cell.selectPayment = ^{
        self->selectedPaymentType = [NSString stringWithFormat:@"%@",[paymentTypeArray objectAtIndex:indexPath.row]];
        self->_paymentTableView.reloadData;
    };
    return cell;
}
@end
