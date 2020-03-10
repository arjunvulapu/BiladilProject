//
//  ChangeLanguageVC.h
//  BiladilProject
//
//  Created by mac on 16/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeLanguageVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIImageView *arabicTickImageView;
@property (weak, nonatomic) IBOutlet UIImageView *englishTickImageView;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UIView *languageView;

@property (strong, nonatomic) NSString * fromPage;

@end
