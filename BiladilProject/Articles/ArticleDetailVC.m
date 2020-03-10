//
//  ArticleDetailVC.m
//  BiladilProject
//
//  Created by mac on 30/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ArticleDetailVC.h"
#import "AppDelegate.h"

@interface ArticleDetailVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * articleDetailArray;
    NSString * lang;
}
@end

@implementation ArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    _articleDetailTableView.dataSource = self;
    _articleDetailTableView.delegate = self;
    [self articleDetailServiceCall];
    
}
-(void)articleDetailServiceCall{
    NSString * usefulParams = [NSString stringWithFormat:@"{\"articleID\":\"%@\"}",_idStr];
    [ServiceApI BiladilApis:@"get_full_article" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->articleDetailArray = [[result valueForKey:@"response"]valueForKey:@"article_details"];
                    if (self->articleDetailArray.count>0) {
                        [self.articleDetailTableView reloadData];
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
    ArticleDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleDetailCell"];
    if (cell == nil) {
        cell = [[ArticleDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ArticleDetailCell"];
    }
    cell.lblTime.text = [articleDetailArray valueForKey:@"created_on"];
    cell.lblTitle.text = [articleDetailArray valueForKey:@"title"];
    
    
    
    cell.lblDescription.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [articleDetailArray valueForKey:@"description"]]];
                                //[articleDetailArray valueForKey:@"description"];
    
    cell.btn_link.tag = indexPath.row;
    NSURL *url = [NSURL URLWithString:cell.lblDescription.text];
    if (url && url.scheme && url.host) {
        cell.btn_link.userInteractionEnabled = YES;
        
        [cell.btn_link addTarget:self action:@selector(openLink:) forControlEvents: UIControlEventTouchUpInside];
    }else {
        cell.btn_link.userInteractionEnabled = NO;
    }
    
    [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[articleDetailArray valueForKey:@"image"]]]];
    //    [cell.btnBookmark setTitle:[[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"links"] forState:UIControlStateNormal];
    
    if ([self.isBookMarked isEqual: @"YES"]) {
        
        [cell.btnBookmark setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
        
    }
    else
    {
        [cell.btnBookmark setImage:[UIImage imageNamed:@"bookmark"] forState:UIControlStateNormal];
    }
    cell.btnBookmark.enabled = NO;
//    [cell.btnBookmark addTarget:self action:@selector(bookmarkAction:) forControlEvents:UIControlEventTouchUpInside];
//    cell.btnBookmark.tag = indexPath.row;
    
    [cell.btnShare addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnShare.tag = indexPath.row;
    return cell;
}

-(void)shareAction:(UIButton *) btn
{
    NSString *str=[NSString stringWithFormat:@"%@%@",IMAGE_URL,[articleDetailArray valueForKey:@"image"]]; //@"https://itunes.apple.com/in/app/harfan-professionals/id1423064424?mt=8"
    //[newsDetailArray valueForKey:@"description"];
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    NSString *textToShare =[NSString stringWithFormat:@"%@", @"Share 'Biladl' with your family & friends"];
    NSString *textToShare = [NSString stringWithFormat:@"%@%@", IMAGE_URL,[articleDetailArray valueForKey:@"image"]]; // [[articlesArray objectAtIndex:presentIndex.integerValue]valueForKey:@"image"]
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

- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bookmarkAction:(UIButton *)sender{
//    UIButton * btn = (UIButton *)sender;
//    NSString * urlStr = [NSString stringWithFormat:@"%@",[[legalNewsArray objectAtIndex:(btn.tag)] valueForKey:@"id"]];
//
//    if ([self.selectedArray containsObject:urlStr]){
//        [self.selectedArray removeObject:urlStr];
//        [self unbookmarkServiceCall];
//    }else{
//        [self.selectedArray addObject:urlStr];
//        [self bookmarkServiceCall];
//    }
//    [self.legalNewsTableView reloadData];
}

-(void)openLink:(UIButton *)sender{
    
    NSURL *url = [NSURL URLWithString:[ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [articleDetailArray valueForKey:@"description"]]]]]];
    if (url && url.scheme && url.host) {
        
        [[UIApplication sharedApplication] openURL:url];
    }else {
    }
}

@end
