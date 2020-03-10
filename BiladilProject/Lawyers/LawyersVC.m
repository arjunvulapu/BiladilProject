//
//  LawyersVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LawyersVC.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LawyersVC ()

//{
//    NSArray * lawyersArray;
//}

@end

@implementation LawyersVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    _lawyersTableView.dataSource = self;
//    _lawyersTableView.delegate = self;
//    [self lawyerServiceCall];
}
/*-(void)lawyerServiceCall{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * usefulParams = [NSString stringWithFormat:@"{\"userID\":\"%@\"}",[defaults valueForKey:@"USER_ID"]];
    [ServiceApI BiladilApis:@"all_lawyers_for_user" ItemStr:usefulParams withCompletionBlock:^(NSArray *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                NSLog(@"Error is:%@",[error localizedDescription]);
                
            }else{
                if ([[result valueForKey:@"status"]intValue] == 1) {
                    lawyersArray = [[result valueForKey:@"response"]valueForKey:@"get_lawyes"];
                    [self.lawyersTableView reloadData];
                    //                    MDToast *t = [[MDToast alloc]initWithText:[result valueForKey:@"message"] duration:kMDToastDurationShort];
                    //                    [t show];
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
    return lawyersArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LawyersCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LawyersCell"];
    if (cell == nil) {
        cell = [[LawyersCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LawyersCell"];
    }
    cell.lawyersView.layer.cornerRadius = 5.0f;
    cell.lawyersView.clipsToBounds = YES;
    cell.lawyersImageView.layer.cornerRadius = cell.lawyersImageView.frame.size.width/2;
   // [cell.lawyersImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@"]] placeholderImage:@""];
//    [cell.detailImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_URL,[[newsDetailArray objectAtIndex:0]valueForKey:@"image"]]]];
    cell.lblName.text = [[lawyersArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.lblDesignation.text = [[lawyersArray objectAtIndex:indexPath.row]valueForKey:@"specialization"];
    return cell;
}
#pragma Tableview Delegate Methods
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
 */
 
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLayoutSubviews {
    [self.textView setContentOffset:CGPointZero animated:NO];
}

@end
