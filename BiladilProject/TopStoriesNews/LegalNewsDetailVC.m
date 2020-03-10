//
//  LegalNewsDetailVC.m
//  BiladilProject
//
//  Created by mac on 30/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LegalNewsDetailVC.h"
#import "AppDelegate.h"

@interface LegalNewsDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * newsDetailArray;
    NSString * lang;
}
@property BOOL selected;

@end

@implementation LegalNewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    self.selected = NO;
    _legalNewsDetailTableView.dataSource = self;
    _legalNewsDetailTableView.delegate = self;
    [self newsDetailServiceCall];
    
}
-(void)newsDetailServiceCall{
    NSString * usefulParams = [NSString stringWithFormat:@"{\"newsID\":\"%@\"}",_idStr];
    [ServiceApI BiladilApis:@"get_full_legal_news" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    newsDetailArray = [[result valueForKey:@"response"]valueForKey:@"news_details"];
                    if (newsDetailArray.count>0) {
                        [self.legalNewsDetailTableView reloadData];
                    }
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
#pragma TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LegalNewsDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LegalNewsDetailsCell"];
    if (cell == nil) {
        cell = [[LegalNewsDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LegalNewsDetailsCell"];
    }
    cell.lblTime.text = [newsDetailArray valueForKey:@"created_on"];
    
    if ([lang isEqualToString:@"1"]) {
        
        cell.lblTitle.text = [newsDetailArray valueForKey:@"title"];
        cell.lblDescription.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [newsDetailArray valueForKey:@"description"]]];
    }else{
        
        cell.lblTitle.text = [newsDetailArray valueForKey:@"title_arbic"];
        cell.lblDescription.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [newsDetailArray valueForKey:@"description_arbic"]]];
    }
    
    //[newsDetailArray valueForKey:@"description"];
    
    [cell.newsDetailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[newsDetailArray valueForKey:@"image"]]]];
    if ([self.isBookMarked isEqualToString:@"YES"]) {
        [cell.btnBookmark setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
        
    }else{
        [cell.btnBookmark setImage:[UIImage imageNamed:@"bookmark_gray.png"] forState:UIControlStateNormal];
        
    }
    [cell.btnBookmark addTarget:self action:@selector(bookmarkAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnBookmark.tag = 1;
    
    cell.btn_link.tag = indexPath.row;
    NSURL *url = [NSURL URLWithString:cell.lblDescription.text];
    if (url && url.scheme && url.host) {
        cell.btn_link.userInteractionEnabled = YES;
        
        [cell.btn_link addTarget:self action:@selector(openLink:) forControlEvents: UIControlEventTouchUpInside];
    }else {
        cell.btn_link.userInteractionEnabled = NO;
    }
    

    
    cell.btnShare.tag = indexPath.row;
    
    [cell.btnShare addTarget:self action:@selector(shareAction:) forControlEvents: UIControlEventTouchUpInside];
    return cell;
}

-(void)shareAction:(UIButton *) btn
{
    NSString *str=[NSString stringWithFormat:@"%@%@",IMAGE_URL,[newsDetailArray valueForKey:@"image"]]; //@"https://itunes.apple.com/in/app/harfan-professionals/id1423064424?mt=8"
    //[newsDetailArray valueForKey:@"description"];
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    NSString *textToShare =[NSString stringWithFormat:@"%@", @"Share 'Biladl' with your family & friends"];
    NSString *textToShare = [NSString stringWithFormat:@"%@%@", IMAGE_URL,[newsDetailArray valueForKey:@"image"]]; // [[articlesArray objectAtIndex:presentIndex.integerValue]valueForKey:@"image"]
    NSURL *myWebsite = [NSURL URLWithString:str];
    
    NSArray *objectsToShare = @[textToShare];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(void)bookmarkAction:(UIButton *)sender{
    if (sender.tag == 1) {
        if (!self.selected) {
            self.selected = YES;
            [self bookmarkServiceCall];
        }else{
            self.selected = NO;
            [self unbookmarkServiceCall];
        }
    }
    [self.legalNewsDetailTableView reloadData];
    
}

-(void)openLink:(UIButton *)sender{
    
    NSURL *url = [NSURL URLWithString:[ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [newsDetailArray valueForKey:@"description"]]]];
    if (url && url.scheme && url.host) {
        
        [[UIApplication sharedApplication] openURL:url];
    }else {
    }
}

/*
-(void)btn_ShareAction: (UIButton *) btn {
    
//    NSString *str=[NSString stringWithFormat:@"%@",@"https://itunes.apple.com/in/app/harfan-professionals/id1423064424?mt=8"];
    NSString *str=[NSString stringWithFormat:@"%@",@"https://itunes.apple.com/in/app/harfan-professionals/id1423064424?mt=8"];
    //[newsDetailArray valueForKey:@"description"];
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    NSString *textToShare =[NSString stringWithFormat:@"%@", @"Share 'Biladl' with your family & friends"];
    NSString *textToShare =[NSString stringWithFormat:@"%@", [newsDetailArray valueForKey:@"description"]];
    NSURL *myWebsite = [NSURL URLWithString:str];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
*/

-(void)unbookmarkServiceCall{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\",\"newsID\":\"%@\",\"bookmarkType\":\"%@\"}",[defaults valueForKey:@"USER_ID"],_idStr,@"REMOVE"];
    [ServiceApI BiladilApis:@"bookmark_news" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
-(void)bookmarkServiceCall{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * params = [NSString stringWithFormat:@"{\"userID\":\"%@\",\"newsID\":\"%@\",\"bookmarkType\":\"%@\"}",[defaults valueForKey:@"USER_ID"],_idStr,@"ADD"];
    [ServiceApI BiladilApis:@"bookmark_news" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
