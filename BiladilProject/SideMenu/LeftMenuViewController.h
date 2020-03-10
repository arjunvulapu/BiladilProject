//
//  LeftMenuViewController.h
//  BiladilProject
//
//  Created by mac on 16/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"


@interface LeftMenuViewController : UIViewController<RESideMenuDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (weak, nonatomic) IBOutlet UIView *myProfileView;



@end
