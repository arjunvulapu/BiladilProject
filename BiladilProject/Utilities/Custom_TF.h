//
//  Custom_TF.h
//  BiladilProject
//
//  Created by iPrism on 03/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Custom_TF : UITextField

+(UITextField *) textPaddingForTF: (UITextField *) textField
                    paddingLength: (double *) length;

@end

NS_ASSUME_NONNULL_END
