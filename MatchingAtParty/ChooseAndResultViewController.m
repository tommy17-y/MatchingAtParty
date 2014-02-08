//
//  ChooseAndResultViewController.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/02/08.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "ChooseAndResultViewController.h"
#import "ChooseAndResultView.h"
#import "AppDelegate.h"

@interface ChooseAndResultViewController ()

@end

@implementation ChooseAndResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    rect = [[UIScreen mainScreen] bounds];
    
    _chooseAndResultView = [[ChooseAndResultView alloc] init];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                 rect.size.height / 2,
                                                                 rect.size.width,
                                                                 rect.size.height / 2)];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.contentSize = CGSizeMake(rect.size.width, rect.size.height / 2);
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
    [_chooseAndResultView layoutUserView:0 UserId:10000];
    UIView *view = (UIView*)[_chooseAndResultView viewWithTag:10000];
    view.frame = CGRectMake((rect.size.width - view.frame.size.width) / 2,
                            (rect.size.height / 2 - view.frame.size.height) / 2,
                            view.frame.size.width,
                            view.frame.size.height);
    [self.view addSubview:view];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height / 2 - 35, rect.size.width, 35)];
    text.text = @"タイプの人を選択してください";
    text.textColor = [UIColor blackColor];
    text.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:text];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10,
                                                                      [[UIScreen mainScreen] bounds].size.height - [[UIScreen mainScreen] applicationFrame].size.height + 10,
                                                                      60,
                                                                      30)];
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(tappedBackButton) forControlEvents:UIControlEventTouchUpInside];
    backButton.exclusiveTouch = YES;

    
    [self maleUserChooseFemaleUser];
    
//    for (UIView *view in [_scrollView subviews]) {
//        [view removeFromSuperview];
//    }
//    
//    [self femaleUserChooseMaleUser];
}

- (void) maleUserChooseFemaleUser{
    
    for(int i = 0; i < (int)[((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser count] / 2; i++) {
        [_chooseAndResultView layoutUserView:1 UserId:i + 1];
        
        UIView *view = (UIView*)[_chooseAndResultView viewWithTag:1000 + i + 1];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosedUser:)]];
        
        UILabel *lb = (UILabel*)[view.subviews objectAtIndex:2];
        lb.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:i * 2 + 1];
        
        UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
        iv.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:i * 2];
        
        [_scrollView addSubview:view];
        
        _scrollView.contentSize = CGSizeMake(view.frame.origin.x + view.frame.size.width + 20,
                                             _scrollView.contentSize.height);
    }
    
    UIView *view = (UIView*)[_chooseAndResultView viewWithTag:10000];
    UILabel *lb = (UILabel*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];

    UIImageView *genderIcon = (UIImageView*)[view.subviews objectAtIndex:1];
    genderIcon.image = [UIImage imageNamed:@"male.png"];

    for(int i = 0; i < (int)[((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser count] / 2; i++) {
        lb.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:i * 2 + 1];
        iv.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:i * 2];
        
        
    }

}

- (void) femaleUserChooseMaleUser{
    
    for(int i = 0; i < (int)[((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser count] / 2; i++) {
        [_chooseAndResultView layoutUserView:1 UserId:i + 1];
        
        UIView *view = (UIView*)[_chooseAndResultView viewWithTag:i + 1];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosedUser:)]];
        
        UILabel *lb = (UILabel*)[view.subviews objectAtIndex:2];
        lb.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:i * 2 + 1];
        
        UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
        iv.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:i * 2];
        
        [_scrollView addSubview:view];
    }
    
    UIView *view = (UIView*)[_chooseAndResultView viewWithTag:10000];
    UILabel *lb = (UILabel*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    
    UIImageView *genderIcon = (UIImageView*)[view.subviews objectAtIndex:1];
    genderIcon.image = [UIImage imageNamed:@"female.png"];

}

- (void)choosedUser:(UITapGestureRecognizer *)recognizer {
    
}

- (void)tappedBackButton {
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
