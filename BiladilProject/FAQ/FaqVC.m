//
//  FaqVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "FaqVC.h"
#import "FaqCell.h"
#import "AppDelegate.h"

@interface FaqVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray * faqArray;
    NSUInteger * pointValue;
    Boolean expand_Status;
    NSString * lang;
}
@property (nonatomic, strong)NSMutableArray *selectedArray;
@property BOOL *selected;
@end

@implementation FaqVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    
    _selectedArray = [NSMutableArray new];
    faqArray = [NSMutableArray new];
    _faqTableView.dataSource = self;
    _faqTableView.delegate = self;
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
    _faqTableView.frame = CGRectMake(0, _faqHeaderView.frame.origin.y+_faqHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_faqHeaderView.frame.size.height-5);
    UINib *nib = [UINib nibWithNibName:@"FaqCell" bundle:nil];
    [self.faqTableView registerNib:nib forCellReuseIdentifier:@"FaqCell"];
    [faqArray removeAllObjects];
    [self faqServiceCall:0];
}
-(void)faqServiceCall:(NSInteger )param{
    NSString * usefulParams = [NSString stringWithFormat:@"{\"statPoint\":\"%ld\"}",(long)param];
    [ServiceApI BiladilApis:@"get_more_faq" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {

                    NSArray * countsArray = [[result valueForKey:@"response"]valueForKey:@"more_faqs"];
                    //                    _loader.hidden = YES;
                    //                    _btnBlur.hidden = YES;
                    //                    [activityIndicator stopAnimating];
                    if (countsArray.count>0) {
                        
                        if (self->pointValue == 0) {
                            self->faqArray = [countsArray mutableCopy];
                        }else{
                            [self->faqArray addObjectsFromArray:countsArray];
                        }
                        self.faqTableView.hidden = NO;
                        [self.faqTableView reloadData];
                    }
                    self->pointValue = self->faqArray.count;
                    
                    
                }
                
                else{
//                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
//                    [t show];
                }
            }
        });
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if (textField == self.tfSearch) {
        
        if (textField.text.length > 0) {
            
            NSString *searchStr = [NSString stringWithFormat:@"%@%@",self.tfSearch.text,string];
            
            NSString * loginParams = [NSString stringWithFormat:@"{\"searchTYPE\":\"%@\",\"keywords\":\"%@\"}",@"FAQ",searchStr];
            [ServiceApI BiladilApis:@"all_serarch" ItemStr:loginParams withCompletionBlock:^(NSArray *result, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (error) {
                        NSLog(@"Error is:%@",[error localizedDescription]);
                        
                    }else{
                        if ([[result valueForKey:@"status"]intValue] == 1) {
                            [self->faqArray removeAllObjects];
                            self->faqArray = [[result valueForKey:@"response"]valueForKey:@"searched_result"];
                            if (self->faqArray.count>0) {
                                [self.faqTableView reloadData];
                            }else{
                                self.faqTableView.hidden = YES;
                            }
                        }else{
//                            self.faqTableView.hidden = YES;
                            [self->faqArray removeAllObjects];
//                            [self faqServiceCall:0];
                            [self.faqTableView reloadData];
                            MDToast *t = [[MDToast alloc]initWithText:[NSString stringWithFormat:@"%@",[result valueForKey:@"message"]] duration:kMDToastDurationShort];
                            [t show];
                        }
                    }
                });
            }];
        }else{
            [faqArray removeAllObjects];
           [self faqServiceCall:0];
        }
        
    }
    return YES;
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSearchAction:(UIButton *)sender {
    
    self.tfSearch.text = @"";
    _searchHeightConstraint.constant = 50;
    self.search_img.hidden = NO;
    _btnClose.hidden = NO;
    _faqTableView.frame = CGRectMake(0, _tfSearch.frame.origin.y+_tfSearch.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_faqHeaderView.frame.size.height-_tfSearch.frame.size.height-5);
}

#pragma TableView DataSource Methods

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return faqArray.count;
}
- ( UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    
    FaqCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FaqCell"];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]){
        
        cell.lblTitle.text = [[faqArray objectAtIndex:indexPath.row]valueForKey:@"title"];
        
    }else{
        
        cell.lblTitle.text = [[faqArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"];
        
    }
    
    cell.btnExpand.tag = indexPath.row;
    [cell.btnExpand addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSInteger ID = [[[faqArray objectAtIndex:(indexPath.row)] valueForKey:@"id"]integerValue];
    NSString * Str = [NSString stringWithFormat:@"%li",(long)ID];
    
//    if (expand_Status) {
//
//        [cell.btnExpand setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
//
//        //[[faqArray objectAtIndex:indexPath.row]valueForKey:@"description"];
//
//        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]){
//
//            cell.lblTitle.text = [[faqArray objectAtIndex:indexPath.row]valueForKey:@"title"];
//            cell.lblDesription.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [[faqArray objectAtIndex:indexPath.row]valueForKey:@"description"]]];
//        }else{
//
//            cell.lblTitle.text = [[faqArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"];
//            cell.lblDesription.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [[faqArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"]]];
//        }
//    }else{
//
//        [cell.btnExpand setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
//        cell.lblDesription.text = @"";
//    }
    
    if ([self.selectedArray containsObject:Str]){
        [cell.btnExpand setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
        
        //[[faqArray objectAtIndex:indexPath.row]valueForKey:@"description"];
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"] isEqualToString:@"1"]){
            
            cell.lblTitle.text = [[faqArray objectAtIndex:indexPath.row]valueForKey:@"title"];
//            NSLog(@"HTML---> %@",[[faqArray objectAtIndex:indexPath.row]valueForKey:@"description"]);
            
            NSString * htmlString = [NSString stringWithFormat:@"%@", [[faqArray objectAtIndex:indexPath.row]valueForKey:@"description"]];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            cell.lblDesription.attributedText = attrStr;
            
//            cell.lblDesription.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [[faqArray objectAtIndex:indexPath.row]valueForKey:@"description"]]];
        }else{
            
            cell.lblTitle.text = [[faqArray objectAtIndex:indexPath.row]valueForKey:@"title_arbic"];
            NSString * htmlString = [NSString stringWithFormat:@"%@", [[faqArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"]];
            NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            
            cell.lblDesription.attributedText = attrStr;
            
//            cell.lblDesription.text = [ServiceApI removeHTMLTagsFromString: [NSString stringWithFormat:@"%@", [[faqArray objectAtIndex:indexPath.row]valueForKey:@"description_arbic"]]];
        }
        
        
    }else{
        [cell.btnExpand setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
        cell.lblDesription.text = @"";
        
    }
    
    return cell;
}
-(void)btnAction:(UIButton *)sender{
    UIButton * expandBtn= (UIButton *)sender;
    
    NSInteger ID = [[[faqArray objectAtIndex:(expandBtn.tag)] valueForKey:@"id"]integerValue];
    NSString * Str = [NSString stringWithFormat:@"%li",(long)ID];
    
    if ([self.selectedArray containsObject:Str]){
        [self.selectedArray removeObject:Str];
    }else{
        [self.selectedArray addObject:Str];
    }
    [self.faqTableView reloadData];
    
}
- (IBAction)btnSearchFieldCloseAction:(UIButton *)sender {
    _searchHeightConstraint.constant = 0;
    self.search_img.hidden = YES;
    _btnClose.hidden = YES;
    _faqTableView.frame = CGRectMake(0, _faqHeaderView.frame.origin.y+_faqHeaderView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-_faqHeaderView.frame.size.height-5);
    faqArray.removeAllObjects;
    [self faqServiceCall:0];
    
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
        [self faqServiceCall:pointValue+1];
        
    }
}

@end
