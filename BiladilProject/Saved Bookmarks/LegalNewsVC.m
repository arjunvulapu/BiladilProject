//
//  LegalNewsVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LegalNewsVC.h"
#import "AppDelegate.h"

@interface LegalNewsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * legalNewsArray;
    NSUInteger pointValue;
    NSString * lang;
}

@end

@implementation LegalNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    legalNewsArray = [[NSMutableArray alloc]init];
    _legalNewsTableView.dataSource = self;
    _legalNewsTableView.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.lbl_noDataFound.hidden = YES;
    legalNewsArray.removeAllObjects;
     [self legalNewsServiceCall:0];
}



-(void)legalNewsServiceCall:(NSInteger )param{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * params = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"all_news_bookmarks" ItemStr:params withCompletionBlock:^(NSArray *result, NSError *error) {
        //all_news_bookmarks
        // get_more_legal_news
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1)
                {
                    NSArray * countsArray = [[result valueForKey:@"response"]valueForKey:@"get_news"];
//                    _loader.hidden = YES;
//                    _btnBlur.hidden = YES;
//                    [activityIndicator stopAnimating];
                    if (countsArray.count>0) {
                        
                        if (pointValue == 0) {
                            legalNewsArray = [countsArray mutableCopy];
                        }else{
                            [legalNewsArray addObjectsFromArray:countsArray];
                        }
                        self.legalNewsTableView.hidden = NO;
                        [self.legalNewsTableView reloadData];
                    }else {
                        self.lbl_noDataFound.hidden = NO;
                    }
                    pointValue = legalNewsArray.count;
                    
                }
                else{
                    self.lbl_noDataFound.hidden = NO;
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
    LegalNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LegalNewsCell"];
    if (cell == nil) {
        cell = [[LegalNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LegalNewsCell"];
    }
    cell.newsView.layer.cornerRadius = 3.0f;
    cell.newsView.clipsToBounds = YES;
    cell.lblTime.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"created_on"];
    if ([lang isEqualToString:@"1"]) {
        cell.lblDescription.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    }else{
        cell.lblDescription.text = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"];
    }
    
    [cell.legalNewsImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[legalNewsArray objectAtIndex:indexPath.row] valueForKey:@"image"]]]];
    //    [cell.btnBookmark setTitle:[[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"links"] forState:UIControlStateNormal];
    [cell.btnBookmark addTarget:self action:@selector(bookmarkAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnBookmark.tag = indexPath.row;
    
    
    
    return cell;
}
#pragma Tableview Delegate Methods
-(void)bookmarkAction:(UIButton *)sender{
    UIButton * btn = (UIButton *)sender;
    NSString * urlStr = [NSString stringWithFormat:@"%@",[[legalNewsArray objectAtIndex:(btn.tag)] valueForKey:@"id"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LegalNewsDetailVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalNewsDetailVC"];
    viewObj.idStr = [[legalNewsArray objectAtIndex:indexPath.row]valueForKey:@"id"];
    [self.navigationController pushViewController:viewObj animated:YES];
}
/*
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
        [self legalNewsServiceCall:pointValue+1];

    }
    
}
*/

@end
