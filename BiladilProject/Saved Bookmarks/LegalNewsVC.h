//
//  LegalNewsVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegalNewsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *legalNewsTableView;

@property (weak, nonatomic) IBOutlet UILabel *lbl_noDataFound;

@end
