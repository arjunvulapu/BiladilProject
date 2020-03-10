//
//  LegalNewsDetailVC.h
//  BiladilProject
//
//  Created by mac on 30/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegalNewsDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *legalNewsDetailTableView;

@property(nonatomic,strong) NSString * idStr;
@property(nonatomic,strong) NSString * isBookMarked;
@property(nonatomic,strong) NSString * commingFrom;

@end
