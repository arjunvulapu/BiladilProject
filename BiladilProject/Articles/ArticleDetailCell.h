//
//  ArticleDetailCell.h
//  BiladilProject
//
//  Created by mac on 30/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnBookmark;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UIButton *btn_link;

@end
