//
//  LegalDocumentsVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LegalDocumentsVC.h"
#import "AppDelegate.h"

@interface LegalDocumentsVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray * documentsArray;
    NSUInteger pointValue;
     NSString * lang;
}
@end

@implementation LegalDocumentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    documentsArray = [NSMutableArray new];
    
    _legalDocTableView.dataSource = self;
    _legalDocTableView.delegate = self;
    _tfSearch.delegate = self;
    
    if ([lang isEqualToString:@"1"]) {
        [self.tfSearch setLeftPadding:50];
    }else{
        [self.tfSearch setRightPadding:25];
    }
    
    [self.tfSearch setValue:[UIColor blackColor] forKeyPath:@"placeholderLabel.textColor"];
    _searchHeightConstraint.constant = 0;
    self.imgView_Search.hidden = YES;
    _btnClose.hidden = YES;
//    _legalDocTableView.frame = CGRectMake(0, _legalDocHeaderView.frame.origin.y+_legalDocHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_legalDocHeaderView.frame.size.height-5);
    documentsArray.removeAllObjects;
    [self docServiceCall:0];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.tfSearch) {
        
        NSInteger newLength = textField.text.length + string.length;
        NSLog(@"Length --> %ld",(long)newLength);
//        let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
        
        if (newLength > 1) {
            
            
            
            NSString *searchStr = [NSString stringWithFormat:@"%@%@",self.tfSearch.text,string];
            
            NSString * loginParams = [NSString stringWithFormat:@"{\"searchTYPE\":\"%@\",\"keywords\":\"%@\"}",@"LEGAL_DOC",searchStr];
            [ServiceApI BiladilApis:@"all_serarch" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (error) {
                        NSLog(@"Error is:%@",[error localizedDescription]);
                        
                    }else{
                        if ([[result valueForKey:@"status"]intValue] == 1) {
                            documentsArray.removeAllObjects;
                            documentsArray = [[result valueForKey:@"response"]valueForKey:@"searched_result"];
                            if (documentsArray.count>0) {
                                self.legalDocTableView.hidden = NO;
                                [self.legalDocTableView reloadData];
                            }else{
                                self.legalDocTableView.hidden = YES;
                            }
                        }else{
//                            self.legalDocTableView.hidden = YES;
                            documentsArray.removeAllObjects;
                            self.legalDocTableView.hidden = NO;
                            [self.legalDocTableView reloadData];
//                            [self docServiceCall:0];
                            MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]] duration:kMDToastDurationShort];
                            [t show];
                        }
                    }
                });
            }];
            
        }else{
             self.legalDocTableView.hidden = NO;
            documentsArray = [NSMutableArray new];
            documentsArray.removeAllObjects;
            [self docServiceCall:0];
        }
        
        
    }
    return YES;
}
-(void)docServiceCall:(NSInteger )param{
    
    NSString * usefulParams = [NSString stringWithFormat:@"{\"statPoint\":\"%ld\"}",(long)param];
    [ServiceApI BiladilApis:@"get_legal_document" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
              
                    NSArray * countsArray = [[result valueForKey:@"response"]valueForKey:@"legal_document"];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    //                    [activityIndicator stopAnimating];
                    if (countsArray.count>0) {
                        
                        if (pointValue == 0) {
                            documentsArray = [countsArray mutableCopy];
                        }else{
                            [documentsArray addObjectsFromArray:countsArray];
                        }
                        self.legalDocTableView.hidden = NO;
                        [self.legalDocTableView reloadData];
                    }
                    pointValue = documentsArray.count;
                    
                    
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

-(void)btn_DownloadAction: (UIButton *) btn {
    
//    UIButton * btn1 = (UIButton *)btn;
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",@"http://biladl.com/",[[documentsArray objectAtIndex:(btn.tag)] valueForKey:@"download_link"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    
}


#pragma TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return documentsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LegaldocumentsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LegaldocumentsCell"];
    if (cell == nil) {
        cell = [[LegaldocumentsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LegaldocumentsCell"];
    }
    cell.lblTitle.text = [[documentsArray objectAtIndex:indexPath.row]valueForKey:@"title"];
    
    cell.btndownload.tag = indexPath.row;
    [cell.btndownload addTarget:self action:@selector(btn_DownloadAction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.btndownload addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
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
        [self docServiceCall:pointValue+1];
        
    }
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSearchViewCloseAction:(UIButton *)sender {
    _searchHeightConstraint.constant = 0;
    self.imgView_Search.hidden = YES;
    _btnClose.hidden = YES;
//    _legalDocTableView.frame = CGRectMake(0, _legalDocHeaderView.frame.origin.y+_legalDocHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_legalDocHeaderView.frame.size.height-5);
    [documentsArray removeAllObjects];
    [self docServiceCall:0];
}
- (IBAction)btnSeachAction:(UIButton *)sender {
    self.tfSearch.text = @"";
    _searchHeightConstraint.constant = 55;
    self.imgView_Search.hidden = NO;
    _btnClose.hidden = NO;
//    _legalDocTableView.frame = CGRectMake(0, _tfSearch.frame.origin.y+_tfSearch.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_tfSearch.frame.size.height-5);
}

@end
