//
//  ArticlesVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ArticlesVC.h"
#import "AppDelegate.h"

@interface ArticlesVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * articlesArray;
    NSUInteger pointValue;
    
    NSNumber *presentIndex;
    NSUInteger present_Count;
    NSString * lang;
    NSString *shareLink;
}

@end

@implementation ArticlesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    articlesArray = [NSMutableArray new];
    
    presentIndex = [NSNumber numberWithInteger:0];
    
    _articlesCollectionView.dataSource = self;
    _articlesCollectionView.delegate = self;
    _tfSearch.delegate = self;
    
    if ([lang isEqualToString:@"1"]) {
        [self.tfSearch setLeftPadding:50];
    }else{
        [self.tfSearch setRightPadding:25];
    }
    
    [self.tfSearch setValue:[UIColor blackColor] forKeyPath:@"placeholderLabel.textColor"];
    _searchHeightConstraint.constant = 0;
    _btnClose.hidden = YES;
    _articlesCollectionView.frame = CGRectMake(0, _articlesHeaderView.frame.origin.y+_articlesHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_articlesHeaderView.frame.size.height-5);
    
    [self articleServiceCall:0];
    
    if ([self.commingFrom isEqualToString:@"LegalAdvice"]) {
        self.articlesHeaderView.hidden = NO;
    }else{
        self.articlesHeaderView.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.tfSearch) {
        
        if (textField.text.length > 0) {
            
//            NSString *searchStr = [NSString stringWithFormat:@"%@%@",self.tfSearch.text,string];
            
            NSString * loginParams = [NSString stringWithFormat:@"{\"searchTYPE\":\"%@\",\"keywords\":\"%@\"}",@"ARTICLE",self.tfSearch.text];
            [ServiceApI BiladilApis:@"all_serarch" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (error) {
                        NSLog(@"Error is:%@",[error localizedDescription]);
                        
                    }else{
                        if ([[result valueForKey:@"status"]intValue] == 1) {
                            articlesArray.removeAllObjects;
                            self->articlesArray = [[result valueForKey:@"response"]valueForKey:@"searched_result"];
                            if (self->articlesArray.count>0) {
                                self.articlesCollectionView.hidden = NO;
                                [self.articlesCollectionView reloadData];
                            }else{
                                self.articlesCollectionView.hidden = NO;
                                [self.articlesCollectionView reloadData];
//                                self.articlesCollectionView.hidden = YES;
                            }
                            
                            self.lbl_Conunt.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)self->articlesArray.count];
                            self->shareLink = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[self->articlesArray[0] objectForKey:@"image"]]; //IMAGE_URL [articlesArray[0] objectForKey:@"image"];
                            
                        }else{
//                            self.articlesCollectionView.hidden = YES;
                            articlesArray.removeAllObjects;
                            [self.articlesCollectionView reloadData];
                            self.lbl_Conunt.text = @"0/0";
                            self->shareLink = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[self->articlesArray[0] objectForKey:@"image"]];
                            MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]] duration:kMDToastDurationShort];
                            [t show];
//                            [self articleServiceCall:0];
                        }
                    }
                });
            }];
            
        }else{
            
            [self articleServiceCall:0];
        }

    }
    return YES;
}
-(void)articleServiceCall:(NSInteger )param{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_all_articles" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    articlesArray.removeAllObjects;
                    articlesArray = [[result valueForKey:@"response"]valueForKey:@"article_details"];
                    
//                    NSLog(@"Response : %@",articlesArray);
                    
                    if (articlesArray.count>0) {
                        [self.articlesCollectionView reloadData];
                    }else{
                        
                       [self.articlesCollectionView reloadData];
                    }
                    
//                    NSLog(@"Articles Data --> %@", articlesArray);
                    self.lbl_Conunt.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)articlesArray.count];
                    shareLink = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[articlesArray[0] objectForKey:@"image"]];
                    
//                    pointValue = articlesArray.count;
                    
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                     articlesArray.removeAllObjects;
                    [self.articlesCollectionView reloadData];
                }
                
            }
        });
    }];
}


-(void)service_BookmarkArticle:(NSInteger )param{
    
    NSString *type = @"";
    
    if ([[[articlesArray objectAtIndex:presentIndex.integerValue]valueForKey:@"Bookmarked"]  isEqual: @"YES"]) {
        
        type = @"REMOVE";
        
    }else{
        
        type = @"ADD";
        
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\", \"articleID\":\"%@\", \"bookmarkType\":\"%@\"}",[defaults valueForKey:@"USER_ID"], [[articlesArray objectAtIndex:param]valueForKey:@"id"], type];
    //[articlesArray valueForKey:@"Bookmarked"], [articlesArray valueForKey:@"id"]
    [ServiceApI BiladilApis:@"bookmark_article" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                    articlesArray.removeAllObjects;
                    [self articleServiceCall:0];
                }else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                }
            }
        });
    }];
}


-(void)btn_ShareAction: (UIButton *) btn {
    
    //    NSString *str=[NSString stringWithFormat:@"%@",@"https://itunes.apple.com/in/app/harfan-professionals/id1423064424?mt=8"];
    NSString *str=[NSString stringWithFormat:@"%@",shareLink]; //@"https://itunes.apple.com/in/app/harfan-professionals/id1423064424?mt=8"
    //[newsDetailArray valueForKey:@"description"];
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    NSString *textToShare =[NSString stringWithFormat:@"%@", @"Share 'Biladl' with your family & friends"];
    NSString *textToShare = [NSString stringWithFormat:@"%@", shareLink]; //[[articlesArray objectAtIndex:presentIndex]valueForKey:@"image"]
    NSURL *myWebsite = [NSURL URLWithString:str];
    
    NSArray *objectsToShare = @[textToShare]; //, myWebsite
    
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

#pragma CollectionView DataSource Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return articlesArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        ArticlesCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticlesCollectionCell" forIndexPath:indexPath];
        cell.articleImageView.layer.cornerRadius = 8.0f;
        cell.articleImageView.clipsToBounds = YES;
        
//            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            NSString *dateStr1 = [[homeNewsScrollingArray objectAtIndex:indexPath.row]valueForKey:@"created_at"];
//            //  NSString *dateStr2 = @"2018-09-24 05:27";
//            NSDate *date1 = [dateFormat dateFromString:dateStr1];
//            NSDate *date2 = [NSDate date];
//
//            NSString *str = [ServiceApI remaningTime:date1 endDate:date2 previousDate:dateStr1];
//            NSLog(@"STR is %@",str);
    
            cell.lblTime.text = @"22 may 2018";//[NSString stringWithFormat:@" %@",[[articlesArray objectAtIndex:indexPath.row]valueForKey:@"created_on"]];
    if ([lang isEqualToString:@"1"]) {
        cell.lblDescription.text = [NSString stringWithFormat:@" %@",[[articlesArray objectAtIndex:indexPath.row]valueForKey:@"title"]];
    }else{
        cell.lblDescription.text = [NSString stringWithFormat:@" %@",[[articlesArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"]];
    }
    
    
    
    
            //cell.lblNewsPostedTime.text = str;
         
            [cell.articleImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[articlesArray objectAtIndex:indexPath.row]valueForKey:@"image"]]]];
    
    presentIndex = [NSNumber numberWithInteger:indexPath.row];
    
//    NSLog(@"BookMarked --> %@",[[articlesArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"]);
    
    if ([[[articlesArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"]  isEqual: @"YES"]) {
        
        [self.btn_AddToReadList setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.btn_AddToReadList setImage:[UIImage imageNamed:@"bookmark"] forState:UIControlStateNormal];
    }
    
        return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    for (UICollectionViewCell *cell in [self.articlesCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.articlesCollectionView indexPathForCell:cell];
        NSLog(@"%@",indexPath);
        presentIndex = [NSNumber numberWithInteger:indexPath.row];
//        if ([self.articlesCollectionView visibleCells].count == articlesArray.count - 1){
        
//             presentIndex = [NSNumber numberWithInteger:indexPath.row];
        
        
        CGRect visibleRect = (CGRect){.origin = self.articlesCollectionView.contentOffset, .size = self.articlesCollectionView.bounds.size};
        CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        NSIndexPath *visibleIndexPath = [self.articlesCollectionView indexPathForItemAtPoint:visiblePoint];

            present_Count = visibleIndexPath.row + 1;
            self.lbl_Conunt.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)present_Count,(unsigned long)articlesArray.count];
        shareLink = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[articlesArray[visibleIndexPath.row] objectForKey:@"image"]];
        
        [self.articlesCollectionView reloadData];
        
        
            //NSLog(@"isBookMarked --> %@",[[articlesArray objectAtIndex:presentIndex.integerValue]valueForKey:@"Bookmarked"]);
            
            
//            if ([[[articlesArray objectAtIndex:presentIndex.integerValue]valueForKey:@"Bookmarked"]  isEqual: @"YES"]) {
//
//                [self.btn_AddToReadList setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
//
//            }else{
//                [self.btn_AddToReadList setImage:[UIImage imageNamed:@"bookmark"] forState:UIControlStateNormal];
//            }//bookmark
//
//            break;
//        }
        //        self.tvDescription.text = [[plansArray objectAtIndex: indexPath.row] valueForKey:@"about"];
        
        
    }
}


#pragma CollectionView Delegate Methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[UIScreen mainScreen].bounds.size.width
    return CGSizeMake(self.articlesCollectionView.frame.size.width - 10,self.articlesCollectionView.frame.size.height);//[UIScreen mainScreen].bounds.size.height-140
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleDetailVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailVC"];
    viewObj.idStr = [[articlesArray objectAtIndex:indexPath.row]valueForKey:@"id"];
    viewObj.isBookMarked = [[articlesArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"];
    [self.navigationController pushViewController:viewObj animated:YES];
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnAddtoReadingListAction:(UIButton *)sender {
    
//    NSLog(@"Selected Index --> %@", presentIndex);
    [self service_BookmarkArticle:presentIndex.integerValue];
}
- (IBAction)btnArticleShareAction:(UIButton *)sender {
    
    NSString *str=[NSString stringWithFormat:@"%@",shareLink]; //@"https://itunes.apple.com/in/app/harfan-professionals/id1423064424?mt=8"
    //[newsDetailArray valueForKey:@"description"];
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    NSString *textToShare =[NSString stringWithFormat:@"%@", @"Share 'Biladl' with your family & friends"];
    NSString *textToShare = [NSString stringWithFormat:@"%@", shareLink]; // [[articlesArray objectAtIndex:presentIndex.integerValue]valueForKey:@"image"]
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
- (IBAction)btnSearchAction:(UIButton *)sender {
    if (_btnClose.isHidden) {
        
        self.tfSearch.text = @"";
        
        _searchHeightConstraint.constant = 50;
        _btnClose.hidden = NO;
        self.lbl_Conunt.frame = CGRectMake(0, _tfSearch.frame.origin.y+_tfSearch.frame.size.height+0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_tfSearch.frame.size.height-5);
        //    _articlesCollectionView.frame = CGRectMake(0, _tfSearch.frame.origin.y+_tfSearch.frame.size.height+0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_tfSearch.frame.size.height-5);
//        [self articleServiceCall:0];
//        self.lbl_Conunt.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)articlesArray.count];
    }else{
        
    }
    
}
- (IBAction)btnSearchViewCloseAction:(UIButton *)sender {
    _searchHeightConstraint.constant = 0;
    
    _btnClose.hidden = YES;
//    self.lbl_Conunt.frame = CGRectMake(0, _articlesHeaderView.frame.origin.y+_articlesHeaderView.frame.size.height+0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_articlesHeaderView.frame.size.height-5);
//    _articlesCollectionView.frame = CGRectMake(0, _articlesHeaderView.frame.origin.y+_articlesHeaderView.frame.size.height+0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_articlesHeaderView.frame.size.height-5);
//    articlesArray.removeAllObjects;
    [self articleServiceCall:0];
}


@end
