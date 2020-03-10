//
//  LegalHelpVC.m
//  BiladilProject
//
//  Created by mac on 08/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "LegalHelpVC.h"
#import "AppDelegate.h"

#define LegalNewsStr @"الأخبار القانونية"
#define UsefulLinksStr @"روابط مفيدة"
#define LegalDocs @"وثائق قانونية"

@interface LegalHelpVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * legalHelpArray;
}

@end

@implementation LegalHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _legalHelpTableView.dataSource = self;
    _legalHelpTableView.delegate = self;
    
    NSString* lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    if ([lang isEqualToString:@"1"]) {
        legalHelpArray = @[@"Legal News",@"Useful Links",@"Legal Documents"];
    }else{
        legalHelpArray = @[LegalNewsStr,UsefulLinksStr,LegalDocs];
    }
    
    
    _legalHelpTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    UINib *nib1 = [UINib nibWithNibName:@"BasicCell" bundle:nil];
//    [_legalHelpTableView registerNib:nib1 forCellReuseIdentifier:@"BasicCell"];
}

#pragma TableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LegalHelpCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LegalHelpCell"];
    if (cell == nil) {
        cell = [[LegalHelpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LegalHelpCell"];
    }
    cell.basicView.layer.cornerRadius = 5.0f;
    cell.basicView.clipsToBounds = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblName.text = [legalHelpArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma Tableview Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TopStoriesLegalNewsVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"TopStoriesLegalNewsVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    } if (indexPath.row == 1) {
        UseFulLinksVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"UseFulLinksVC"];
        [self.navigationController pushViewController:viewObj animated:YES];
    } if (indexPath.row == 2) {
        LegalDocumentsVC * viewObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalDocumentsVC"];
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
