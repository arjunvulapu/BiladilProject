//
//  ArticlesVC.h
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesVC : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *articlesCollectionView;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIView *articlesHeaderView;

@property (weak, nonatomic) IBOutlet UIButton *btn_AddToReadList;

@property (weak, nonatomic) NSString *commingFrom;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Conunt;


@end
