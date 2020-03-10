//
//  SelectPaymentTC.h
//  BiladilProject
//
//  Created by S2TechCorp78 on 2/25/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectPaymentTC : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shoeImage;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
- (IBAction)selectBtnAction:(id)sender;
@property(nonatomic) void (^selectPayment)();

@end

NS_ASSUME_NONNULL_END
