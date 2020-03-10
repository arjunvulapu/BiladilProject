//
//  UITextField+PaddingText.m
//  SeeFood
//
//  Created by Pradeep Dahiya on 06/08/15.
//  Copyright (c) 2015 Amjad. All rights reserved.
//

#import "UITextField+PaddingText.h"

@implementation UITextField (PaddingText)

-(void) setLeftPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
-(void) setRightPadding:(int) paddingValue
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, paddingValue, self.frame.size.height)];
    self.rightView = paddingView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

@end
