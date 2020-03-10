//
//  SavedBookMarkArticlesVC.h
//  BiladilProject
//
//  Created by iPrism on 15/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SavedBookMarkArticlesVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *TV_Articles;
@property (weak, nonatomic) IBOutlet UILabel *lbl_noDataFound;

@end

NS_ASSUME_NONNULL_END
