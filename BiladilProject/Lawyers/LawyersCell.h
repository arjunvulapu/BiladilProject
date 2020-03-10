//
//  LawyersCell.h
//  BiladilProject
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LawyersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lawyersView;
@property (weak, nonatomic) IBOutlet UIImageView *lawyersImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDesignation;

@end
