//
//  LegalAdviceVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LegalAdviceVC.h"
#import "AppDelegate.h"

#define Articlesstr @"مقالات"
#define FAQSstr @"التعليمات"
#define AdviceStr @"النصيحة"

@interface LegalAdviceVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * legalAdviceArray;
//     NSArray * legalAdviceArray_Arabic;
}
@end

@implementation LegalAdviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _legalAdviceTableView.dataSource = self;
    _legalAdviceTableView.delegate = self;
    NSString* lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    if ([lang isEqualToString:@"1"]) {
         legalAdviceArray = @[@"Articles",@"FAQ'S",@"Advice"];
    }else{
//         legalAdviceArray_Arabic = @[Articlesstr];
        legalAdviceArray = @[Articlesstr,FAQSstr,AdviceStr];
    }
   
   
    _legalAdviceTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    UINib *nib1 = [UINib nibWithNibName:@"BasicCell" bundle:nil];
//    [_legalAdviceTableView registerNib:nib1 forCellReuseIdentifier:@"BasicCell"];
}
#pragma TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LegalAdviceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LegalAdviceCell"];
    if (cell == nil) {
        cell = [[LegalAdviceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LegalAdviceCell"];
    }
    cell.basicView.layer.cornerRadius = 5.0f;
    cell.basicView.clipsToBounds = YES;
    
    
    
    
    cell.lblName.text = [legalAdviceArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma Tableview Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ArticlesVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticlesVC"];
        viewObj.commingFrom = @"LegalAdvice";
        [self.navigationController pushViewController:viewObj animated:YES];
    } if (indexPath.row == 1) {
        FaqVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"FaqVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    } if (indexPath.row == 2) {
        OnlineAdviceVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"OnlineAdviceVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
