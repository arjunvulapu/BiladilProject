//
//  ServiceApI.h
//  FrugalPro
//
//  Created by Sireesha T on 21/09/16.
//  Copyright © 2016 Sireesha T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceApI : NSObject
//#define COMMON_URL @"http://biladl.com/app/Ws/"
#define COMMON_URL @"http://techtinderbox.com/biladl/app/Ws/"
#define IMAGE_URL @"http://techtinderbox.com/"
typedef void (^getAllServices)(NSArray *result, NSError *error);
typedef void (^getStringResponse)(NSString *result, NSError *error);
typedef void (^getResponse)(NSDictionary *result, NSError *error);
typedef void (^getAllCategories)(NSArray *result, NSError *error);
+(void)BiladilApis:(NSString*)Parameter ItemStr:(NSString*)Itemdetails withCompletionBlock:(getAllCategories)completionBlock;
+(void)GetBiladilApis:(NSString*)Parameter withCompletionBlock:(getAllCategories)completionBlock;
//+(void)getAllCategoriesWithCompletionBlock:(NSString *)itemDetails withCompletionBlock:(getAllServices)completionBlock;
//+(void)setBottomLine:(UITextField *)TF;  ---- this is NSObject class,because of this (UITextField *) we need a textfield category class then only it will allow;
//+(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate previousDate:(NSString *)oldDate;

+(NSString *) removeHTMLTagsFromString: (NSString *)string;
+(NSAttributedString *) displayHTMLContent: (NSString *)string;

@end
