//
//  LegalDocumentsVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegalDocumentsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *legalDocTableView;
@property (weak, nonatomic) IBOutlet UIView *legalDocHeaderView;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_Search;
@end
