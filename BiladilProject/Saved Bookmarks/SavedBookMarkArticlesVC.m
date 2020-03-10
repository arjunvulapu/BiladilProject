//
//  SavedBookMarkArticlesVC.m
//  BiladilProject
//
//  Created by iPrism on 15/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SavedBookMarkArticlesVC.h"
#import "SavedBookArticlesTVCell.h"
#import "AppDelegate.h"


@interface SavedBookMarkArticlesVC () <UITableViewDelegate, UITableViewDataSource>
{
        NSArray * articleArray;
    NSString * lang;
}

@end

@implementation SavedBookMarkArticlesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    self.TV_Articles.delegate = self;
    self.TV_Articles.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.lbl_noDataFound.hidden = YES;
    [self service_SavedBookArticle];
}

#pragma mark - TableviewDelegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return articleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SavedBookArticlesTVCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SavedBookArticlesTVCell"];
    
        
//        cell = [[SavedBookArticlesTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SavedBookArticlesTVCell"];
    
        NSLog(@"Date & Time --> %@",[NSString stringWithFormat:@" %@",[[articleArray objectAtIndex:indexPath.row]valueForKey:@"created_on"]]);
    
     [cell.imgView_Article sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[articleArray objectAtIndex:indexPath.row]valueForKey:@"image"]]]];
        
        cell.lbl_DateTime.text = [NSString stringWithFormat:@" %@",[[articleArray objectAtIndex:indexPath.row]valueForKey:@"created_on"]];
    
    if ([lang isEqualToString:@"1"]) {
        cell.lbl_Article.text = [NSString stringWithFormat:@" %@",[[articleArray objectAtIndex:indexPath.row]valueForKey:@"title"]];
    }else{
        cell.lbl_Article.text = [NSString stringWithFormat:@" %@",[[articleArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"]];
    }
    
    
        //cell.lblNewsPostedTime.text = str;
        
    
        
        //        if ([[[articleArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"]  isEqual: @"YES"]) {
        //            [cell.imgView_BookMark setImage: [UIImage imageNamed:@"yellow_bookmark"]];
        //        }else{
        //            [cell.imgView_BookMark setImage: [UIImage imageNamed:@"bookmark"]];

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - Functions

-(void)service_SavedBookArticle {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    
    [ServiceApI BiladilApis:@"all_article_bookmarks" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        //get_all_articles
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    self->articleArray = [[result valueForKey:@"response"]valueForKey:@"get_article"];
                    if (self->articleArray.count>0) {
                        [self.TV_Articles reloadData];
                    }else {
                        self.lbl_noDataFound.hidden = NO;
                    }
//                    pointValue = articleArray.count;
                }else{
                    self.lbl_noDataFound.hidden = NO;
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
