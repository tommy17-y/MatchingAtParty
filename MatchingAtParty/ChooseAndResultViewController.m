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
    selectedUserId = 0;
    
    _chooseAndResultView = [[ChooseAndResultView alloc] init];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                 rect.size.height / 2,
                                                                 rect.size.width,
                                                                 rect.size.height / 2)];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.contentSize = CGSizeMake(rect.size.width, rect.size.height / 2);
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];

    UIButton *decideButton = [[UIButton alloc] initWithFrame:CGRectMake(10,
                                                                      [[UIScreen mainScreen] bounds].size.height / 2 + 10,
                                                                      60,
                                                                      30)];
    [decideButton setTitle:@"決定" forState:UIControlStateNormal];
    decideButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:decideButton];
    [decideButton addTarget:self action:@selector(tappedDecideButton) forControlEvents:UIControlEventTouchUpInside];
    decideButton.exclusiveTouch = YES;
    decideButton.tag = 50000;
    
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
    text.tag = 50001;
    
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
    
}

- (void) maleUserChooseFemaleUser{
    
    selectingUserGender = 0;
    selectingUserId = 1;
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser = [NSMutableArray array];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser removeAllObjects];
    
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
    
    UIView *selectingUserView = (UIView*)[self.view viewWithTag:10000];
    UILabel *selectingUserViewLabel = (UILabel*)[selectingUserView.subviews objectAtIndex:2];
    UIImageView *selectingUserViewImageView = (UIImageView*)[selectingUserView.subviews objectAtIndex:0];

    UIImageView *genderIcon = (UIImageView*)[selectingUserView.subviews objectAtIndex:1];
    genderIcon.image = [UIImage imageNamed:@"male.png"];

    selectingUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(selectingUserId - 1) * 2 + 1];
    selectingUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(selectingUserId - 1) * 2];
    
}

- (void) femaleUserChooseMaleUser{
    
    selectingUserGender = 1;
    selectingUserId = 1;
    
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser = [NSMutableArray array];
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser removeAllObjects];
    
    for(int i = 0; i < (int)[((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser count] / 2; i++) {
        [_chooseAndResultView layoutUserView:0 UserId:i + 1];
        
        UIView *view = (UIView*)[_chooseAndResultView viewWithTag:i + 1];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosedUser:)]];
        
        UILabel *lb = (UILabel*)[view.subviews objectAtIndex:2];
        lb.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:i * 2 + 1];
        
        UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
        iv.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:i * 2];
        
        [_scrollView addSubview:view];
        
        _scrollView.contentSize = CGSizeMake(view.frame.origin.x + view.frame.size.width + 20,
                                             _scrollView.contentSize.height);
    }
    
    UIView *selectingUserView = (UIView*)[self.view viewWithTag:10000];
    UILabel *selectingUserViewLabel = (UILabel*)[selectingUserView.subviews objectAtIndex:2];
    UIImageView *selectingUserViewImageView = (UIImageView*)[selectingUserView.subviews objectAtIndex:0];
    
    UIImageView *genderIcon = (UIImageView*)[selectingUserView.subviews objectAtIndex:1];
    genderIcon.image = [UIImage imageNamed:@"female.png"];
    
    selectingUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(selectingUserId - 1) * 2 + 1];
    selectingUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(selectingUserId - 1) * 2];
    
}

- (void)choosedUser:(UITapGestureRecognizer *)recognizer {

    UIView *iv = (UIView*)recognizer.view;
    UIView *selectedUserView = (UIView*)[_scrollView viewWithTag:selectedUserId];
    
    if(selectedUserId == iv.tag) {
        
        [[iv layer] setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor]];
        selectedUserId = 0;

    } else {
        if(selectedUserId != 0) {
            [[selectedUserView layer] setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor]];
        }
        [[iv layer] setBorderColor:[[[UIColor redColor] colorWithAlphaComponent:0.8] CGColor]];
        [[iv layer] setBorderWidth:3.0f];
        selectedUserId = (int)iv.tag;
    }
    
}

- (void)tappedDecideButton {
    selectingUserId++;
    
    if(selectingUserGender == 0){
        
        [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser
         addObject:[NSNumber numberWithInteger:selectedUserId]];
        
        if(selectingUserId > (int)[((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser count] / 2) {
            for (UIView *view in [_scrollView subviews]) {
                [view removeFromSuperview];
            }
        
            [self femaleUserChooseMaleUser];
        } else {
            UIView *selectingUserView = (UIView*)[self.view viewWithTag:10000];
            UILabel *selectingUserViewLabel = (UILabel*)[selectingUserView.subviews objectAtIndex:2];
            UIImageView *selectingUserViewImageView = (UIImageView*)[selectingUserView.subviews objectAtIndex:0];
            
            selectingUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(selectingUserId - 1) * 2 + 1];
            selectingUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(selectingUserId - 1) * 2];
            
            for (UIView *view in [_scrollView subviews]) {
                [[view layer] setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor]];

            }
            selectedUserId = 0;
        }
    } else {
        
        if(selectedUserId == 0) {
            selectingUserId--;
            return;
        }

        [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser
         addObject:[NSNumber numberWithInteger:selectedUserId]];

        if(selectingUserId > (int)[((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser count] / 2) {
            for (UIView *view in [_scrollView subviews]) {
                [view removeFromSuperview];
            }
            
            [self displayResult];
        } else {
            UIView *selectingUserView = (UIView*)[self.view viewWithTag:10000];
            UILabel *selectingUserViewLabel = (UILabel*)[selectingUserView.subviews objectAtIndex:2];
            UIImageView *selectingUserViewImageView = (UIImageView*)[selectingUserView.subviews objectAtIndex:0];
            
            selectingUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(selectingUserId - 1) * 2 + 1];
            selectingUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(selectingUserId - 1) * 2];
            
            for (UIView *view in [_scrollView subviews]) {
                [[view layer] setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor]];
                
            }
            selectedUserId = 0;
        }
    }
}

- (void)displayResult {
    UIButton *decideButton = (UIButton*)[self.view viewWithTag:50000];
    decideButton.hidden = YES;

    UILabel *text = (UILabel*)[self.view viewWithTag:50001];
    text.hidden = YES;
    
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
