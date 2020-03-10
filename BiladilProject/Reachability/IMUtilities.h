//
//  IMUtilities.h
//  Project
//
//  Created by Project on 31/1/16.
//  Copyright (c) 2016 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  IMUtilities is a class to have all uititlity functions .
 */

@interface IMUtilities : NSObject

/**
 * This method to convert string formatted json data into imege.
 *
 
 *
 * @return UIImage.
 */

+(UIImage *)convertToImageFromByteArray:(NSMutableString*)mutableStr;

/**
 * This method to check the availability of internet connection .
 */
+ (BOOL)checkNetworkConnectivity;

/**
 * This method to get the specified file type.
 *
 * @param fileType in NSString formate .
 *
 * @return NSString.
 */

+ (NSString *)getFileType:(NSString *)fileName;

/**
 * This method to get the image for the specified file type.
 *
 * @param fileType in NSString formate .
 *
 * @return NSString.
 */

/**
 * This method to check the device type using interface idiom;
 */

+ (BOOL)isDeviceIPhone;


+ (NSString *)getNameFromItemName:(NSString *)itemName;
+ (NSString*)getImageForFileType:(NSString*)fileType;
+ (NSString *)getDateString:(NSDate *)date;
+ (NSString *)ISO8601StringFromDate:(NSDate *)date;
+ (NSString *)dateDiff:(NSString *)origDate;
+ (NSString*)base64forData:(NSData*)theData;
+ (NSString *)getFolderPathWithTruncation:(NSString *)path;
+(BOOL)deleteFileFromDocumentsDirectory:(NSString *)filePath;
+(NSDictionary *)parseQueryString:(NSString *)query;
+ (NSString*)trim:(NSString*)str;
+ (void)removeAllCookies;
+ (NSString *)getOnlyFileName:(NSString *)fileName;
+(float)deviceVersion;
+(NSString *)imageUrl;
+(NSString *)imageUrl1;
+(NSString *)ProfileURL;
+(NSString *)ServiceImage;
+(NSString *)serviceimageUrl;
+(NSString *)subServiceimageUrl;

@end
