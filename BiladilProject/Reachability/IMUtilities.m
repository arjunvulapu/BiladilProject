//
//  IMUtilities.m
//  Project
//
//  Created by Project on 31/1/16.
//  Copyright (c) 2016 Project. All rights reserved.
//

#import "IMUtilities.h"
#import "Reachability.h"


@implementation IMUtilities

+(UIImage *)convertToImageFromByteArray:(NSMutableString*)mutableStr {
    
    return [UIImage imageNamed:@""];
//    NSArray *byteArray = [mutableStr componentsSeparatedByString:@","];
//    
//    unsigned c = byteArray.count;
//    uint8_t *bytes = malloc(sizeof(*bytes) * c);
//    
//    unsigned i;
//    for (i = 0; i < c; i++) {
//        NSString *str = [byteArray objectAtIndex:i];
//        int byte = [str intValue];
//        bytes[i] = (uint8_t)byte;
//    }
//    
//    NSData *data = [NSData dataWithBytes:bytes length:c];
//    
//    return [[UIImage alloc] initWithData:data];
}

+ (BOOL)checkNetworkConnectivity {

    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        //my web-dependent code
        return YES;
    } else {
        //there-is-no-connection warning
        return NO;
    }
}
+(NSString *)imageUrl
{
    //return @"http://stageadmin.kwickcart.com/Images/";
   return @"http://78.47.226.131/fp6/uploads/serviceicons/";

}
+(NSString *)imageUrl1
{
    //return @"http://stageadmin.kwickcart.com/Images/";
    return @"http://78.47.226.131/fp6/uploads/subserviceicons/";
    
}+(NSString *)serviceimageUrl
{
    //return @"http://stageadmin.kwickcart.com/Images/";
    return @"http://78.47.226.131/fp6/uploads/serviceImages/";
    
}
+(NSString *)subServiceimageUrl
{
    //return @"http://stageadmin.kwickcart.com/Images/";
    return @"http://78.47.226.131/fp6/uploads/subservicesImage/";
    
}


+(NSString *)ProfileURL
{
    //return @"http://mizpahsoft.com/frugalpro/uploads/profilePics/";
    return @"http://78.47.226.131/fp6/uploads/profilePics/";
}
+(NSString *)ServiceImage
{
   // return @"http://mizpahsoft.com/frugalpro/uploads/UsersServiceImages/";
    return @"http://78.47.226.131/fp6/uploads/UsersServiceImages/";
}


+ (NSString *)getFileType:(NSString *)fileName {
    NSArray *components = [fileName componentsSeparatedByString:@"."];
    if([components count]) {
        return [[components lastObject] lowercaseString];
    }
    return nil;
}

+ (NSString *)getOnlyFileName:(NSString *)fileName{
    NSArray *components = [fileName componentsSeparatedByString:@"."];
    if([components count]) {
        return [components firstObject];
    }
    return nil;
}

+ (NSString *)getNameFromItemName:(NSString *)itemName{
    NSArray *components = [itemName componentsSeparatedByString:@"."];
    if([components count]) {
        return [components firstObject];
    }
    return nil;
}

+ (NSString*)getImageForFileType:(NSString*)fileType
{
    NSString *imageString = [NSString stringWithFormat:@"icon-file-%@.png",fileType];
    return imageString;
}

+ (NSString *)getDateString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd MMM yyyy hh:mm a";
    NSString *timeStamp = [dateFormatter stringFromDate:date];
    return timeStamp;
}


+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}



+ (NSString *)dateDiff:(NSString *)origDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzzz"];
    NSDate *convertedDate = [df dateFromString:origDate];
    NSDate *todayDate = [NSDate date];
    double ti = [convertedDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        return @"never";
    } else 	if (ti < 60) {
        return @"less than a minute ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%d minutes ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%d hours ago", diff];
    } else if (ti < 2629743) {
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%d days ago", diff];
    } else {
        int diff = round(ti / 60 / 60 / 24 / 30);
        return (diff>1)?[NSString stringWithFormat:@"%d months ago", diff]:[NSString stringWithFormat:@"%d month ago", diff];
    }
}

+ (NSString *)getFolderPathWithTruncation:(NSString *)path {
    
    NSString *truncatedStr = [[NSURL URLWithString:path]absoluteString];
    if ([truncatedStr hasSuffix:@"/"] ) {
        truncatedStr = [truncatedStr substringToIndex:[truncatedStr length]-1];
    }
    return truncatedStr;
}

+(BOOL)deleteFileFromDocumentsDirectory:(NSString *)filePath {
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the database has already been created in the users filesystem
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:&error];
    }
    
    if (error==nil) {
        return YES;
    }
    return NO;
}

+ (BOOL)isDeviceIPhone
{
    if([[UIDevice currentDevice]userInterfaceIdiom] == UIUserInterfaceIdiomPhone ) {
        return YES;
    } else {
        return NO;
    }
}

+(NSDictionary *)parseQueryString:(NSString *)query {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6] ;
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        
        if(elements.count == 1){
            dict = nil;
            break;
        }
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    
    return dict;
    
}

+ (NSString*)trim:(NSString*)str{
    
    return [str stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
}

+ (void)removeAllCookies{
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(float)deviceVersion{
    
    NSString *ver = [[UIDevice currentDevice] systemVersion];
    float ver_float = [ver floatValue];
    return ver_float;
}


@end
