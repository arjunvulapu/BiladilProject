//
//  UseFulLinksVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "UseFulLinksVC.h"
#import "AppDelegate.h"

@interface UseFulLinksVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * usefulLinksArray;
    NSUInteger pointValue;
    NSString * lang;
}
@end

@implementation UseFulLinksVC


- (void)viewDidLoad {
    [super viewDidLoad];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    usefulLinksArray = [NSMutableArray new];
    
    _usefulLinksTableView.dataSource = self;
    _usefulLinksTableView.delegate = self;
    _tfSearch.delegate = self;
    
    if ([lang isEqualToString:@"1"]) {
        [self.tfSearch setLeftPadding:50];
    }else{
        [self.tfSearch setRightPadding:25];
    }
    
    [self.tfSearch setValue:[UIColor blackColor] forKeyPath:@"placeholderLabel.textColor"];
    _searchHeightConstraint.constant = 0;
    self.search_img.hidden = YES;
    _btnClose.hidden = YES;
    _usefulLinksTableView.frame = CGRectMake(0, _headerView.frame.origin.y+_headerView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_headerView.frame.size.height-5);
    [self usefulLinksServiceCall:0];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.tfSearch) {
        
        if (textField.text.length > 0) {
            
            NSString *searchStr = [NSString stringWithFormat:@"%@%@",self.tfSearch.text,string];
            NSString * loginParams = [NSString stringWithFormat:@"{\"searchTYPE\":\"%@\",\"keywords\":\"%@\"}",@"USEFUL_LINKS",searchStr];
            [ServiceApI BiladilApis:@"all_serarch" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (error) {
                        NSLog(@"Error is:%@",[error localizedDescription]);
                        
                    }else{
                        if ([[result valueForKey:@"status"]intValue] == 1) {
                            usefulLinksArray.removeAllObjects;
                            usefulLinksArray = [[result valueForKey:@"response"]valueForKey:@"searched_result"];
                            if (usefulLinksArray.count>0) {
                                self.usefulLinksTableView.hidden = NO;
                                [self.usefulLinksTableView reloadData];
                            }else{
                                self.usefulLinksTableView.hidden = YES;
                            }
                        }else{
                            self.usefulLinksTableView.hidden = YES;
                            usefulLinksArray.removeAllObjects;
                            [self usefulLinksServiceCall:0];
                        }
                    }
                });
            }];
            
        }else{
            usefulLinksArray.removeAllObjects;
            [self usefulLinksServiceCall:0];
        }
        
        
    }
    return YES;
}
-(void)usefulLinksServiceCall:(NSInteger )param{
    NSString * usefulParams = [NSString stringWithFormat:@"{\"statPoint\":\"%ld\"}",(long)param];
    [ServiceApI BiladilApis:@"get_useful_link" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {

                    NSArray * countsArray = [[result valueForKey:@"response"]valueForKey:@"Useful_links"];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    //                    [activityIndicator stopAnimating];
                    if (countsArray.count>0) {
                        
                        if (pointValue == 0) {
                            usefulLinksArray = [countsArray mutableCopy];
                        }else{
                            [usefulLinksArray addObjectsFromArray:countsArray];
                        }
                        self.usefulLinksTableView.hidden = NO;
                        [self.usefulLinksTableView reloadData];
                    }
                    pointValue = usefulLinksArray.count;
                    
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
    return usefulLinksArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UsefulLinksCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UsefulLinksCell"];
    if (cell == nil) {
        cell = [[UsefulLinksCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsefulLinksCell"];
    }
    cell.usefulView.layer.cornerRadius = 3.0f;
    cell.usefulView.clipsToBounds = YES;
    if ([lang isEqualToString:@"2"]) {
        cell.lblTitle.text = [[usefulLinksArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"];
        [cell.btnLink setTitle:@"" forState:UIControlStateNormal];
        
        cell.lbl_Link.text = [[usefulLinksArray objectAtIndex:indexPath.row]valueForKey:@"links_arabic"];
        
        [cell.btnLink addTarget:self action:@selector(webLinkAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnLink.tag = indexPath.row;
    }else{
        
        cell.lblTitle.text = [[usefulLinksArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        
        [cell.btnLink setTitle:@"" forState:UIControlStateNormal];
        
        cell.lbl_Link.text = [[usefulLinksArray objectAtIndex:indexPath.row]valueForKey:@"links"];
        
        [cell.btnLink addTarget:self action:@selector(webLinkAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnLink.tag = indexPath.row;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * urlStr = [NSString stringWithFormat:@"%@",[[usefulLinksArray objectAtIndex:indexPath.row] valueForKey:@"links"]];
//    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]];
    
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"www.google.com"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

#pragma Tableview Delegate Methods
-(void)webLinkAction:(UIButton *)sender{
    UIButton * btn = (UIButton *)sender;
    NSString * urlStr = [NSString stringWithFormat:@"%@",[[usefulLinksArray objectAtIndex:(btn.tag)] valueForKey:@"links"]];
    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]];

}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}
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
        [self usefulLinksServiceCall:pointValue+1];
        
    }
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSearchAction:(UIButton *)sender {
    self.tfSearch.text = @"";
    _searchHeightConstraint.constant = 55;
    self.search_img.hidden = NO;
    _btnClose.hidden = NO;
    _usefulLinksTableView.frame = CGRectMake(0, _tfSearch.frame.origin.y+_tfSearch.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_tfSearch.frame.size.height-5);
}
- (IBAction)btnSearchViewCloseAction:(UIButton *)sender {
    _searchHeightConstraint.constant = 0;
    self.search_img.hidden = YES;
    _btnClose.hidden = YES;
//    _usefulLinksTableView.frame = CGRectMake(0, _headerView.frame.origin.y+_headerView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_headerView.frame.size.height-5);
//    usefulLinksArray.removeAllObjects;
    [self usefulLinksServiceCall:0];
    
}



@end
