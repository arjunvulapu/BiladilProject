//
//  SavedBookmarkArticleVC.h
//  BiladilProject
//
//  Created by mac on 02/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedBookmarkArticleVC : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *savedBookmarkArticleCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *btn_AddToReadList;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) NSString *commingFrom;
//LegalAdvice
@end
