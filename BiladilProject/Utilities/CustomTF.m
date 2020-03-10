//
//  CustomTF.m
//  BiladilProject
//
//  Created by iPrism on 03/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomTF : UITextField {
    
    
}

@end

@implementation CustomTF

+(UITextField *) textPaddingForTF: (UITextField *) textField
           paddingLength: (double *) length
{
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, *length, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    return textField;
}
@end
