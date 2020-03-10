//
//  SavedBookmarkArticleCollectionCell.h
//  BiladilProject
//
//  Created by mac on 02/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedBookmarkArticleCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPagesCount;
@property (weak, nonatomic) IBOutlet UIImageView *artcleImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end
