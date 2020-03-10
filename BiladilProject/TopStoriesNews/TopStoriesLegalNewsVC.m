//
//  TopStoriesLegalNewsVC.m
//  BiladilProject
//
//  Created by mac on 30/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "TopStoriesLegalNewsVC.h"
#import "AppDelegate.h"

@interface TopStoriesLegalNewsVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray * legalNewsArray;
    NSUInteger pointValue;
    NSString * news_Id;
     NSString * lang;
}
@property (nonatomic, strong)NSMutableArray *selectedArray;
@end

@implementation TopStoriesLegalNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    legalNewsArray = [[NSMutableArray alloc]init];
    _legalNewsTableView.dataSource = self;
    _legalNewsTableView.delegate = self;
    _tfSearch.delegate = self;
    
    if ([lang isEqualToString:@"1"]) {
        [self.tfSearch setLeftPadding:50];
    }else{
        [self.tfSearch setRightPadding:25];
    }
    
    [self.tfSearch setValue:[UIColor blackColor] forKeyPath:@"placeholderLabel.textColor"];
    _searchHeightConstarint.constant = 0;
    self.imgView_Search.hidden = YES;
    _btnClose.hidden = YES;
    _legalNewsTableView.frame = CGRectMake(0, _newsHeaderView.frame.origin.y+_newsHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_newsHeaderView.frame.size.height-5);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [legalNewsArray removeAllObjects];
    [self newsServiceCall:0];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.tfSearch) {
        
        if (textField.text.length > 0) {
            
            NSString *searchStr = [NSString stringWithFormat:@"%@%@",self.tfSearch.text,string];
            
            NSString * loginParams = [NSString stringWithFormat:@"{\"searchTYPE\":\"%@\",\"keywords\":\"%@\"}",@"NEWS",searchStr];
            [ServiceApI BiladilApis:@"all_serarch" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (error) {
                        NSLog(@"Error is:%@",[error localizedDescription]);
                        
                    }else{
                        if ([[result valueForKey:@"status"]intValue] == 1) {
                            legalNewsArray.removeAllObjects;
                            legalNewsArray = [[result valueForKey:@"response"]valueForKey:@"searched_result"];
                            if (legalNewsArray.count>0) {
                                self.legalNewsTableView.hidden = NO;
                                [self.legalNewsTableView reloadData];
                            }else{
                                self.legalNewsTableView.hidden = YES;
                            }
                        }else{
                            self.legalNewsTableView.hidden = YES;
                            legalNewsArray.removeAllObjects;
//                            [self newsServiceCall:0];
                            MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]] duration:kMDToastDurationShort];
                            [t show];
                        }
                    }
                });
            }];
        }else{
            legalNewsArray.removeAllObjects;
            [self newsServiceCall:0];
        }
        
        
    }
    return YES;
}
#pragma TableView DataSource Methods
-(void)newsServiceCall:(NSInteger )param{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * params = [NSString stringWithFormat:@"{\"statPoint\":\"%ld\",\"userID\":\"%@\"}",(long)param,[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"get_more_legal_news" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1)
                {
                   
                    NSArray * countsArray = [[result valueForKey:@"response"]valueForKey:@"more_news"];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    //                    [activityIndicator stopAnimating];
                    if (countsArray.count>0) {
                        
                        if (pointValue == 0) {
                            legalNewsArray = [countsArray mutableCopy];
                        }else{
                            
                            [legalNewsArray addObjectsFromArray:countsArray];
                        }
//                        self.legalNewsTableView.hidden = NO;
                       
                    }
                    pointValue = legalNewsArray.count;
                     [self.legalNewsTableView reloadData];
                    
                }
                else{
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    [t show];
                    return;
                }
            }
        });
    }];
}
#pragma TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return legalNewsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopStoriesLegalNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TopStoriesLegalNewsCell"];
    if (cell == nil) {
        cell = [[TopStoriesLegalNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TopStoriesLegalNewsCell"];
    }
    cell.newsView.layer.cornerRadius = 3.0f;
    cell.newsView.clipsToBounds = YES;
    cell.lblTime.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"created_on"];
    if ([lang isEqualToString:@"1"]) {
        cell.lblDescription.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    }else{
        cell.lblDescription.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"];
    }
    
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[legalNewsArray objectAtIndex:indexPath.row] valueForKey:@"image"]]]];
    
    if ([[[legalNewsArray objectAtIndex:indexPath.row] valueForKey:@"Bookmarked"]isEqualToString:@"YES"]) {
        [cell.btnBookmark setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
    }else{
        [cell.btnBookmark setImage:[UIImage imageNamed:@"icon_BookmarkGray"] forState:UIControlStateNormal];
    }
    cell.btnBookmark.tag = indexPath.row;
    [cell.btnBookmark addTarget:self action:@selector(bookmarkAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    if ([[[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"]  isEqual: @"YES"]) {
        
        [cell.btnBookmark setImage:[UIImage imageNamed:@"yellow_bookmark"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnBookmark setImage:[UIImage imageNamed:@"icon_BookmarkGray"] forState:UIControlStateNormal];
    }
    
    return cell;
}

-(void)bookmarkAction:(UIButton *)sender{
//    NSLog(@"Selected Index --> %ld",(long)sender.tag);
    [self service_Bookmark:sender.tag];
    
//    UIButton * btn = (UIButton *)sender;
//    NSString * urlStr = [NSString stringWithFormat:@"%@",[[legalNewsArray objectAtIndex:(btn.tag)] valueForKey:@"id"]];
//
//    if ([self.selectedArray containsObject:urlStr]){
//        [self.selectedArray removeObject:urlStr];
//        [self unbookmarkServiceCall];
//    }else{
//        [self.selectedArray addObject:urlStr];
////        [self service_Bookmark];
//    }
//    [self.legalNewsTableView reloadData];
}
#pragma Tableview Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LegalNewsDetailVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalNewsDetailVC"];
    viewObj.idStr = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"id"];
    viewObj.isBookMarked = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"Bookmarked"];
    
    [self.navigationController pushViewController:viewObj animated:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate
{
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = 10;
    
    if(y > h + reload_distance)
    {
        [self newsServiceCall:pointValue+1];
    }
    
}
//-(void)unbookmarkServiceCall{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\",\"newsID\":\"%@\",\"bookmarkType\":\"%@\"}",[defaults valueForKey:@"USER_ID"],urlStr,@"REMOVE"];
//    [ServiceApI BiladilApis:@"bookmark_news" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            if (error) {
//                NSLog(@"Error is:%@",[error localizedDescription]);
//
//            }else{
//                if ([[result valueForKey:@"status"]intValue] == 1) {
//                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
//                    [t show];
//                    [self newsServiceCall:0];
//                }else{
//                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
//                    [t show];
//                }
//            }
//        });
//    }];
//}
-(void)service_Bookmark:(NSUInteger) param{
    
    NSString *type = @"";
    
    if ([[[legalNewsArray objectAtIndex:param]valueForKey:@"Bookmarked"]  isEqual: @"YES"]) {
        
        type = @"REMOVE";
        
    }else{
        
        type = @"ADD";
        
    }
    news_Id = [NSString stringWithFormat:@"%@",[[legalNewsArray objectAtIndex:(param)] valueForKey:@"id"]];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\",\"newsID\":\"%@\",\"bookmarkType\":\"%@\"}",[defaults valueForKey:@"USER_ID"],news_Id,type];
    
    [ServiceApI BiladilApis:@"bookmark_news" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    [t show];
                    [self->legalNewsArray removeAllObjects];
                    [self newsServiceCall:0];
                    
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
- (IBAction)btnSearchAction:(UIButton *)sender {
    self.tfSearch.text = @"";
    _searchHeightConstarint.constant = 55;
    self.imgView_Search.hidden = NO;
    _btnClose.hidden = NO;
    _legalNewsTableView.frame = CGRectMake(0, _tfSearch.frame.origin.y+_tfSearch.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_tfSearch.frame.size.height-5);
}
- (IBAction)btnSearchViewCloseAction:(UIButton *)sender {
    _searchHeightConstarint.constant = 0;
    self.imgView_Search.hidden = YES;
    _btnClose.hidden = YES;
    _legalNewsTableView.frame = CGRectMake(0, _newsHeaderView.frame.origin.y+_newsHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_newsHeaderView.frame.size.height-5);
    legalNewsArray.removeAllObjects;
    [self newsServiceCall:0];
}


@end
