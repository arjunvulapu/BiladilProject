//
//  FaqVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaqVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *faqHeaderView;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UITableView *faqTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIImageView *search_img;

@end
