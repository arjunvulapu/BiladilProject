//
//  Custom_TF.m
//  BiladilProject
//
//  Created by iPrism on 03/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "Custom_TF.h"

@implementation Custom_TF



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(UITextField *) textPaddingForTF: (UITextField *) textField
                    paddingLength: (double *) length
{
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, *length, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}

@end
