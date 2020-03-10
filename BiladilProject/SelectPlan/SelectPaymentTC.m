//
//  SelectPaymentTC.m
//  BiladilProject
//
//  Created by S2TechCorp78 on 2/25/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "SelectPaymentTC.h"

@implementation SelectPaymentTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectBtnAction:(id)sender {
    if(self.selectPayment)
    {
        self.selectPayment();
    }
}
@end
