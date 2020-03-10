//
//  NotificationVC.m
//  BiladilProject
//
//  Created by mac on 27/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "NotificationVC.h"
#import "AppDelegate.h"
#import "NotificationsCell.h"

@interface NotificationVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *notifications_Arr;
}

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notificationsTableView.delegate = self;
    self.notificationsTableView.dataSource = self;
    
    [self service_Notifications];
    
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Tableview Dalegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return notifications_Arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotificationsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationsCell" forIndexPath:indexPath];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    dict = notifications_Arr[indexPath.row];
    cell.lblTitle.text = [dict objectForKey:@"send_to"];
    cell.lblDescription = [dict objectForKey:@"description"];
    cell.lblTime.text = [dict objectForKey:@"created_on"];
    
    return  cell;
}


#pragma mark - Functions
-(void)service_Notifications{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * params = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_more_notification" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1)
                {
                    self->notifications_Arr = [[result valueForKey:@"response"]valueForKey:@"more_notify"];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    //                    [activityIndicator stopAnimating];
                    
                        [self.notificationsTableView reloadData];
                    
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
