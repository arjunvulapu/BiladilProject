//
//  HomeVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface HomeVC : UIViewController<RESideMenuDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;
@property (weak, nonatomic) IBOutlet UITabBarItem *homeTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *notificationsTabBarItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *chatTabBarItem;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
@property (weak, nonatomic) IBOutlet UIButton *btnNotifications;
@property (weak, nonatomic) IBOutlet UIButton *btnChat;
@property (weak, nonatomic) IBOutlet UIImageView *homeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImageView;
@property (weak, nonatomic) IBOutlet UIImageView *chatImageView;

@property (weak, nonatomic) IBOutlet UITableView *TV_Serach;

+(BOOL) needsUpdate;

@end
