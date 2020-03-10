//
//  ChatVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ChatVC.h"
#import "AppDelegate.h"


@interface ChatVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * chatArray;
    NSString * lang;
    NSTimer *timer;
    BOOL chatSearch;
    NSMutableArray * searchchatArray;
    
}

@end

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    chatSearch = NO;
    timer = [[NSTimer alloc]init];
    
    chatArray = [NSMutableArray new];
    searchchatArray = [NSMutableArray new];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    _chatTableView.dataSource = self;
    _chatTableView.delegate = self;
    _tfSearch.delegate = self;
    
    if ([lang isEqualToString:@"1"]) {
        [self.tfSearch setLeftPadding:50];
    }else{
        [self.tfSearch setRightPadding:25];
    }
    
    [self.tfSearch setValue:[UIColor blackColor] forKeyPath:@"placeholderLabel.textColor"];
    _searchHeightConstraint.constant = 0;
    self.imgView_Search.hidden = YES;
    _btnClose.hidden = YES;
    
    
    if ([lang isEqualToString:@"1"]) {
        [self.tfComment setLeftPadding:8];
    }else{
        [self.tfComment setRightPadding:8];
    }
    
    //    [NSTimer scheduledTimerWithTimeInterval:10.0
    //                                     target:self
    //                                   selector:@selector(chatServiceCall)
    //                                   userInfo:nil
    //                                    repeats:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self chatServiceCall];
    [self service_checkSubscribe];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    timer = nil;
}


#pragma mark - Functions

-(void)service_checkSubscribe{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_current_package" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                
                if ([[result valueForKey:@"status"]intValue] == 0)
                {
                    /*
                     SubscribePopUpVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscribePopUpVC"];
                     
                     viewObj.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                     viewObj.modalPresentationStyle = UIModalPresentationOverCurrentContext;//UIModalPresentationPopover;
                     
                     [self presentViewController:viewObj animated:YES completion:nil];
                     //                    [self.navigationController pushViewController:viewObj animated:NO];
                     
                     */
                    
                    NSString* lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
                    if ([lang isEqualToString:@"1"]){
                        
                        [self subscriptionAlert_English];
                    }else{
                        [self subscriptionAlert_Arabic];
                    }
                    
                }
                
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    //                    selectPlanArray = [[result valueForKey:@"response"]valueForKey:@"package_details"];
                    
                    //                    NSLog(@"Package details array --> %@",selectPlanArray);
                    
                    //                    if (selectPlanArray.count>0) {
                    //                        //                        [self.subcriptionCollectionView reloadData];
                    //                    }
                    //
                    //                    NSLog(@"Subscription Data---> %@",selectPlanArray);
                    //
                    //                    self.txtView_AboutPlan.text = [selectPlanArray valueForKey:@"description"];
                    
                }else{
                    //                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    //                    [t show];
                }
            }
        });
    }];
}

-(void)chatServiceCall{
    chatSearch = NO;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"Sender_ID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    //    NSLog(@"Sender_ID --> %@",usefulParams);
    [ServiceApI BiladilApis:@"my_current_chat" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                //                NSLog(@"response --> %@",result);
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    
                    
                    [self->chatArray removeAllObjects];
                    
                    self->chatArray = [result valueForKey:@"response"];
                    if (self->chatArray.count>0) {
                        [self.chatTableView reloadData];
                        [self srcollBottom];
                    }
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

-(void)msgSendServiceCall{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"Sender_ID\":\"%@\",\"Message\":\"%@\"}",[defaults valueForKey:@"USER_ID"],_tfComment.text];
    [ServiceApI BiladilApis:@"chat_message" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    
                    [self->chatArray removeAllObjects];
                    
                    self->chatArray = [result valueForKey:@"response"];
                    if (self->chatArray.count>0) {
                        [self.chatTableView reloadData];
                        [self srcollBottom];
                        self->_tfComment.text = @"";
                        
                        
                        
                        self->timer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                                       target:self
                                                                     selector:@selector(chatServiceCall)
                                                                     userInfo:nil
                                                                      repeats:YES];
                        
                        
                    }
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}

#pragma mark - TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if(chatSearch){
        return searchchatArray.count;
    }else{
        return chatArray.count;
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(chatSearch){
        if ([[searchchatArray objectAtIndex:indexPath.row]valueForKey:@"My_message"]) {
            ChatCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell1"];
            if (cell == nil) {
                cell = [[ChatCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatCell1"];
            }
            
            cell.lblUserChat.text = [[searchchatArray objectAtIndex:indexPath.row]valueForKey:@"My_message"];
            
            cell.lblUserTime.text = [[searchchatArray objectAtIndex:indexPath.row]valueForKey:@"created_at"];
            return cell;
        }else{
            ChatCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell2"];
            if (cell == nil) {
                cell = [[ChatCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatCell2"];
            }
            cell.lblAdminChat.text = [[searchchatArray objectAtIndex:indexPath.row]valueForKey:@"Ur_message"];
            cell.lblAdminTime.text = [[searchchatArray objectAtIndex:indexPath.row]valueForKey:@"created_at"];
            return cell;
        }
    }else{
        if ([[chatArray objectAtIndex:indexPath.row]valueForKey:@"My_message"]) {
            ChatCell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell1"];
            if (cell == nil) {
                cell = [[ChatCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatCell1"];
            }
            
            cell.lblUserChat.text = [[chatArray objectAtIndex:indexPath.row]valueForKey:@"My_message"];
            
            cell.lblUserTime.text = [[chatArray objectAtIndex:indexPath.row]valueForKey:@"created_at"];
            return cell;
        }else{
            ChatCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell2"];
            if (cell == nil) {
                cell = [[ChatCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChatCell2"];
            }
            cell.lblAdminChat.text = [[chatArray objectAtIndex:indexPath.row]valueForKey:@"Ur_message"];
            cell.lblAdminTime.text = [[chatArray objectAtIndex:indexPath.row]valueForKey:@"created_at"];
            return cell;
        }
    }
    
    
    
}
- (IBAction)btnBackAction:(UIButton *)sender {
    
    //    RootViewController * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
    //    [self.navigationController pushViewController:viewObj animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnCommentSendAction:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    [self msgSendServiceCall];
}


-(void)srcollBottom {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self->chatArray.count-1 inSection:0];
        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition: UITableViewScrollPositionBottom animated:YES];
        
    });
}

-(void)subscriptionAlert_English{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Subscription"
                                                                   message:@"Your package is expired or your not subscribed any package yet!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action_JoinNow = [UIAlertAction actionWithTitle:@"Join Now" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
        SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
        viewObj.delegate = self;
        viewObj.commingFrom = @"POP_UP";
        
        [self.navigationController pushViewController:viewObj animated:YES];
        
    }];
    
    UIAlertAction* action_Close = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
        
        HomeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }];
    [alert addAction:action_Close];
    [alert addAction:action_JoinNow];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)subscriptionAlert_Arabic{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"اشتراك"
                                                                   message:@"انتهت صلاحية الحزمة الخاصة بك أو لم تقم بالاشتراك في أي حزمة حتى الآن!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action_JoinNow = [UIAlertAction actionWithTitle:@"نضم الان" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
        SubscriptionVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SubscriptionVC"];
        viewObj.delegate = self;
        viewObj.commingFrom = @"POP_UP";
        
        [self.navigationController pushViewController:viewObj animated:YES];
        
    }];
    
    UIAlertAction* action_Close = [UIAlertAction actionWithTitle:@"قريب" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
        
        HomeVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }];
    [alert addAction:action_Close];
    [alert addAction:action_JoinNow];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)btnSearchViewCloseAction:(UIButton *)sender {
    _searchHeightConstraint.constant = 0;
    self.imgView_Search.hidden = YES;
    _btnClose.hidden = YES;
    //    _legalDocTableView.frame = CGRectMake(0, _legalDocHeaderView.frame.origin.y+_legalDocHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_legalDocHeaderView.frame.size.height-5);
    [self chatServiceCall];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.tfSearch) {
        NSString *searchStr =[NSString stringWithFormat:@"%@",self.tfSearch.text];
//        if (textField.text.length > 0) {
            
        if([string  isEqual: @""]){
                if ([searchStr length] > 0) {
                    searchStr = [searchStr substringToIndex:[searchStr length] - 1];
                } else {
                    //no characters to delete... attempting to do so will result in a crash
                }
                
            }else{
                searchStr = [NSString stringWithFormat:@"%@%@",self.tfSearch.text,string];
                
            }
//        }else{
//            chatSearch = NO;
//            [self.chatTableView reloadData];
//            return YES;
//        }
        if(searchStr.length >0){
            chatSearch = YES;
            searchchatArray.removeAllObjects;
            for (NSDictionary* chatObj in chatArray) {
                if ([chatObj valueForKey:@"My_message"]){
                    if ([[chatObj valueForKey:@"My_message"] rangeOfString:searchStr].location == NSNotFound) {
                    } else {
                        [searchchatArray addObject:chatObj];
                        
                    }
                    
                }
                else{
                    if ([[chatObj valueForKey:@"Ur_message"] rangeOfString:searchStr].location == NSNotFound) {
                    } else {
                        [searchchatArray addObject:chatObj];
                        
                    }
                }
            }
            if (searchchatArray.count>0) {
                self.chatTableView.hidden = NO;
                [self.chatTableView reloadData];
            }else{
                self.chatTableView.hidden = YES;
            }
            //               NSString * loginParams = [NSString stringWithFormat:@"{\"searchTYPE\":\"%@\",\"keywords\":\"%@\",\"userID\":\"%@\"}",@"CHAT",searchStr,[defaults valueForKey:@"USER_ID"]];
            
            //                [ServiceApI BiladilApis:@"all_serarch" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
            //                    dispatch_async(dispatch_get_main_queue(), ^{
            //
            //                        if (error) {
            //                            NSLog(@"Error is:%@",[error localizedDescription]);
            //
            //                        }else{
            //                            NSLog(@"Responce is:%@",[result valueForKey:@"response"]);
            //                            if ([[result valueForKey:@"status"]intValue] == 1) {
            //                                chatArray.removeAllObjects;
            //                                chatArray = [[result valueForKey:@"response"]valueForKey:@"searched_result"];
            //                                if (chatArray.count>0) {
            //                                    self.chatTableView.hidden = NO;
            //                                    [self.chatTableView reloadData];
            //                                }else{
            //                                    self.chatTableView.hidden = YES;
            //                                }
            //                            }else{
            //                                self.chatTableView.hidden = YES;
            //                                chatArray.removeAllObjects;
            //    //                            [self newsServiceCall:0];
            //                                MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]] duration:kMDToastDurationShort];
            //                                [t show];
            //                            }
            //                        }
            //                    });
            //                }];
        }else{
            // chatArray.removeAllObjects;
            //[self chatServiceCall];
            chatSearch = NO;
            [self.chatTableView reloadData];
        }
        
        
    }
    return YES;
}
- (IBAction)btnSeachAction:(UIButton *)sender {
    self.tfSearch.text = @"";
    _searchHeightConstraint.constant = 55;
    self.imgView_Search.hidden = NO;
    _btnClose.hidden = NO;
    //    _legalDocTableView.frame = CGRectMake(0, _tfSearch.frame.origin.y+_tfSearch.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_tfSearch.frame.size.height-5);
}
@end
