//
//  TopStoriesLegalNewsVC.h
//  BiladilProject
//
//  Created by mac on 30/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopStoriesLegalNewsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *legalNewsTableView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_Search;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIView *newsHeaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHeightConstarint;

@end
