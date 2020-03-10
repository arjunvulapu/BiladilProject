//
//  SavedBookmarkArticleVC.m
//  BiladilProject
//
//  Created by mac on 02/12/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SavedBookmarkArticleVC.h"
#import "AppDelegate.h"

@interface SavedBookmarkArticleVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray * articleArray;
    NSUInteger * pointValue;
}

@end

@implementation SavedBookmarkArticleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _savedBookmarkArticleCollectionView.dataSource = self;
    _savedBookmarkArticleCollectionView.delegate = self;
    
    if ([self.commingFrom isEqualToString:@"LegalAdvice"]) {
        self.headerView.hidden = NO;
    }else{
        self.headerView.hidden = YES;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self savedArticleServiceCall:0];
}

- (IBAction)btn_BackAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:NO];
}


-(void)savedArticleServiceCall:(NSInteger )param{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    
    [ServiceApI BiladilApis:@"get_all_articles" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    articleArray = [[result valueForKey:@"response"]valueForKey:@"article_details"];
                    if (articleArray.count>0) {
                        [self.savedBookmarkArticleCollectionView reloadData];
                    }
                    pointValue = articleArray.count;
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}
#pragma CollectionView DataSource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return articleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SavedBookmarkArticleCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SavedBookmarkArticleCollectionCell" forIndexPath:indexPath];
    cell.artcleImageView.layer.cornerRadius = 8.0f;
    cell.artcleImageView.clipsToBounds = YES;
    
    //            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //            NSString *dateStr1 = [[homeNewsScrollingArray objectAtIndex:indexPath.row]valueForKey:@"created_at"];
    //            //  NSString *dateStr2 = @"2018-09-24 05:27";
    //            NSDate *date1 = [dateFormat dateFromString:dateStr1];
    //            NSDate *date2 = [NSDate date];
    //
    //            NSString *str = [ServiceApI remaningTime:date1 endDate:date2 previousDate:dateStr1];
    //            NSLog(@"STR is %@",str);
    
    cell.lblTime.text = [NSString stringWithFormat:@" %@",[[articleArray objectAtIndex:indexPath.row]valueForKey:@"created_on"]];
    cell.lblDescription.text = [NSString stringWithFormat:@" %@",[[articleArray objectAtIndex:indexPath.row]valueForKey:@"title"]];
    //cell.lblNewsPostedTime.text = str;
    
    [cell.artcleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[articleArray objectAtIndex:indexPath.row]valueForKey:@"image"]]]];
    return cell;
}

#pragma CollectionView Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-140);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleDetailVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailVC"];
    viewObj.idStr = [[articleArray objectAtIndex:indexPath.row]valueForKey:@"id"];
    [self.navigationController pushViewController:viewObj animated:YES];
}

- (IBAction)btnAddToReadingListAction:(UIButton *)sender {
    
    
}

- (IBAction)btnShareAction:(UIButton *)sender {
    
}

@end
