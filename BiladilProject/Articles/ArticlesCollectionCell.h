//
//  ArticlesCollectionCell.h
//  BiladilProject
//
//  Created by mac on 30/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPagesCount;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@end
