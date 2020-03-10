//
//  SavedBookmarksVC.m
//  BiladilProject
//
//  Created by mac on 16/11/18.
//  Copyright © 2018 mac. All rights reserved.
//

#import "SavedBookmarksVC.h"
#import "AppDelegate.h"

@interface SavedBookmarksVC ()
{
    GFPageSlider * pageSlider;
    LegalNewsVC *  v1;
    SavedBookmarkArticleVC * v2;
    NSMutableArray *arrViewControllers;
    NSString * news;
    NSString * article;
    NSString * lang;
}

@end

@implementation SavedBookmarksVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    lang = [[NSUserDefaults standardUserDefaults]valueForKey:@"LANGUAGE"];
    [self manageScreen];
    
    
}
-(void)manageScreen
{
    //    if(!pageSlider)
    //    {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    arrViewControllers =[[NSMutableArray alloc]init];
    
    
    
    v1 = [self.storyboard instantiateViewControllerWithIdentifier:@"LegalNewsVC"];
//    v2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedBookmarkArticleVC"];
    v2 = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedBookMarkArticlesVC"];
    
    [arrViewControllers addObject:v1];
    [arrViewControllers addObject:v2];
    
    [self addChildViewController:arrViewControllers[0]];
    [self addChildViewController:arrViewControllers[1]];
    
    if ([lang isEqualToString:@"1"]) {
        
        news = @"Legal News";
        article = @"Articles";
    }else{
        news = @"الأخبار القانونية";
        article = @"مقالات";
    }
    
    
    pageSlider = [[GFPageSlider alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)
                                        numberOfPage:2
                                     viewControllers:arrViewControllers
                                    menuButtonTitles:@[news,article]
                                           menuColor:[UIColor whiteColor] btnWidth:[UIScreen mainScreen].bounds.size.width/3];
    [self.containerView addSubview:pageSlider];
    pageSlider.menuHeight = 60.0f;
    pageSlider.menuNumberPerPage = 2;
    pageSlider.menuColor=[UIColor blackColor];
    pageSlider.indicatorLineColor =[UIColor colorWithRed:255.0/255.0 green:120.0/255.0 blue:106.0/255.0 alpha:1.0];
    
    // }
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
