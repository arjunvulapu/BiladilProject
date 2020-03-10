//
//  ServiceApI.m
//  FrugalPro
//
//  Created by Sireesha T on 21/09/16.
//  Copyright © 2016 Sireesha T. All rights reserved.
//

#import "ServiceApI.h"
#import "AppDelegate.h"
#define kGOOGLE_API_KEY @""

@implementation ServiceApI
+(ServiceApI *)sharedInstance
{
    static ServiceApI *serviceApi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serviceApi = [[ServiceApI alloc]init];
    });
    
    return serviceApi;
}
+(void)BiladilApis:(NSString*)Parameter ItemStr:(NSString*)Itemdetails withCompletionBlock:(getAllCategories)completionBlock{
   
    [SVProgressHUD show];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",COMMON_URL,Parameter];
    
    NSString *tokenAuthenication = @"Basic QklMQURJTDpCSUxBRElMQDIwMTg==";
    
    NSData *postData = [Itemdetails dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:tokenAuthenication forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:postData];
   

    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:postData completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                                   //(@"result:%@",response);
                                                                   if(error){
                                                                       [SVProgressHUD dismiss];
                                                                       completionBlock(nil,error);
                                                                   }
                                                                   
                                                                   NSArray* jsonRspnce = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                                                                   NSError *error1;
                                                                   
                                                                   if(error1){
                                                                       [SVProgressHUD dismiss];
                                                                       completionBlock(nil,error1);
                                                                   }
                                                                   
                                                                   else{
                                                                       [SVProgressHUD dismiss];
                                                                       completionBlock(jsonRspnce,error);
                                                                   }
                                                                   
                                                               }];
    [uploadTask resume];
    

}

+(void)GetBiladilApis:(NSString*)Parameter withCompletionBlock:(getAllCategories)completionBlock{
   
    [SVProgressHUD show];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",COMMON_URL,Parameter];
   
    NSString *tokenAuthenication = @"Basic QklMQURJTDpCSUxBRElMQDIwMTg==";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:tokenAuthenication forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            [SVProgressHUD dismiss];
            completionBlock(nil,error);
        }
    
        NSArray* jsonRspnce = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSError *error1;
        
        if(error1){
            [SVProgressHUD dismiss];
            completionBlock(nil,error1);
        }
        else{
            [SVProgressHUD dismiss];
            completionBlock(jsonRspnce,error);
        }
    }];
    
   [postDataTask resume];

}

/*+(NSString*)remaningTime:(NSDate*)startDate endDate:(NSDate*)endDate previousDate:(NSString *)oldDate{
    NSDateComponents *components;
    NSInteger days;
    NSInteger hour;
    NSInteger minutes;
    NSString *durationString;
    
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:startDate toDate: endDate options: 0];
    
    days = [components day];
    hour = [components hour];
    minutes = [components minute];
    
    if(days>0)
    {
        if(days>1){
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *convertDate = [dateFormat dateFromString:oldDate];
//            NSDateFormatter *outputFormatter1 = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd MMM 'at' hh:mm a"];
            NSString * preDate =[dateFormat stringFromDate:convertDate];
            durationString = preDate;
        }
        else{
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *convertDate = [dateFormat dateFromString:oldDate];
        //            NSDateFormatter *outputFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd MMM 'at' hh:mm a"];
        NSString * preDate =[dateFormat stringFromDate:convertDate];
        durationString = preDate;
        
        }
        return durationString;
    }
    else if(hour>0)
    {
        if(hour>1){
            //  durationString=[NSString stringWithFormat:@"%d hours",hour];
            durationString=[NSString stringWithFormat:@"%ld hours ago",(long)hour];
        }
        else{
            // durationString=[NSString stringWithFormat:@"%d hour",hour];
            durationString=[NSString stringWithFormat:@"%ld hours ago",(long)hour];
        }
        return durationString;
    }else{
    if(minutes>0)
    {
        if(minutes>1){
            durationString = [NSString stringWithFormat:@"%ld  minutes ago",(long)minutes];
        }
        else{
            durationString = [NSString stringWithFormat:@"%ld  minutes ago",(long)minutes];
        }
        
        return durationString;
    }
    }
    return @"";
        
} */


+(NSString *) removeHTMLTagsFromString: (NSString *)string {
    NSRange r;
    NSString *s = [[NSString alloc]init];
    s = string;
    while ((r = [s rangeOfString:@"<[^>]+>\\s*" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    
    s = [s stringByReplacingOccurrencesOfString:@"&nbsp;"
                                               withString:@""];
    
    // /(<([^>]+)>)/ig
    // <[^>]+>
    // <[^>]+>\\s*
    return s;
}

+(NSAttributedString *) displayHTMLContent: (NSString *)string {
    
    NSString * htmlString = string;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
//    UIFont *font = [UIFont fontWithName:@"Montserrat Regular" size:24.0];
//    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
//                                                                forKey:NSFontAttributeName];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@", attrStr] attributes:attrsDictionary];
    
    

    
    return attrStr;
//    return attrString;
}

@end
