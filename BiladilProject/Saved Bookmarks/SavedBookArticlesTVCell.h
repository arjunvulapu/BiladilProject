//
//  SavedBookArticlesTVCell.h
//  BiladilProject
//
//  Created by iPrism on 15/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SavedBookArticlesTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView_Article;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Article;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_BookMark;


@end

NS_ASSUME_NONNULL_END
