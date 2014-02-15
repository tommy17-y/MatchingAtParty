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
        
        if(selectedUserId == 0) {
            selectingUserId--;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"相手を選択してください" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser
         addObject:[NSNumber numberWithInteger:selectedUserId - 1000]];
        
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"相手を選択してください" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }

        [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser
         addObject:[NSNumber numberWithInteger:selectedUserId]];

        if(selectingUserId > (int)[((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser count] / 2) {
            for (UIView *view in [_scrollView subviews]) {
                [view removeFromSuperview];
            }
            
            [self displayResultViewAndMakeResult];
            
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

- (void)displayResultViewAndMakeResult {
    UIButton *decideButton = (UIButton*)[self.view viewWithTag:50000];
    decideButton.hidden = YES;

    UILabel *text = (UILabel*)[self.view viewWithTag:50001];
    text.hidden = YES;
    
    // matching
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                               [[UIScreen mainScreen] bounds].size.height - [[UIScreen mainScreen] applicationFrame].size.height,
                                                               [[UIScreen mainScreen] applicationFrame].size.width,
                                                               [[UIScreen mainScreen] applicationFrame].size.height)];
    backView.backgroundColor = [UIColor whiteColor];

    UIView *resultView = [[UIView alloc]initWithFrame:CGRectMake(30,
                                                                 [[UIScreen mainScreen] bounds].size.height - [[UIScreen mainScreen] applicationFrame].size.height + 30,
                                                                 [[UIScreen mainScreen] bounds].size.width - 30 * 2,
                                                                 [[UIScreen mainScreen] applicationFrame].size.height - 30 * 2)];
    resultView.backgroundColor = [UIColor whiteColor];
    resultView.layer.cornerRadius = 10.0f;
    resultView.clipsToBounds = YES;
    [[resultView layer] setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:1.0f] CGColor]];
    [[resultView layer] setBorderWidth:2.0f];
    resultView.tag = 70000;
    
    [UIView animateWithDuration:1.5f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.view addSubview:backView];
                         backView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6f];
                     } completion:^(BOOL finished) {
                         [self.view addSubview:resultView];
                     }];
    
    couple = [NSMutableArray array];
    if([((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser count] >= [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser count]) {
        
        for(int i = 0; i < [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser count]; i++) {
            int index = [[((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser objectAtIndex:i] intValue];
            if([[((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser objectAtIndex:index - 1] intValue] == i + 1) {
                [couple addObject:[NSNumber numberWithInt:((i + 1) * 10 + index)]];
            }
        }
    } else {
        for(int i = 0; i < [((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser count]; i++) {
            int index = [[((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdfemaleUserchoosingMaleUser objectAtIndex:i] intValue];
            if([[((AppDelegate*)[[UIApplication sharedApplication] delegate]).userIdmaleUserchoosingFemaleUser objectAtIndex:index - 1] intValue] == i + 1) {
                [couple addObject:[NSNumber numberWithInt:(index * 10 + (i + 1))]];
            }
        }
    }
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     resultView.frame.size.height / 3,
                                                                     resultView.frame.size.width,
                                                                     30)];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [resultView addSubview:resultLabel];
    
    UIButton *resultButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        resultView.frame.size.height / 3 * 2 - 30,
                                                                        resultView.frame.size.width / 2,
                                                                        30)];
    resultButton.center = CGPointMake(resultView.frame.size.width / 2,
                                      resultButton.center.y);
    resultButton.backgroundColor = [UIColor blackColor];
    [resultView addSubview:resultButton];
    resultButton.exclusiveTouch = YES;
    
    if ((int)[couple count] != 0) {
        resultLabel.text = [NSString stringWithFormat:@"%d件のマッチングがありました！", (int)[couple count]];
        [resultButton setTitle:@"結果を見る" forState:UIControlStateNormal];
        [resultButton addTarget:self action:@selector(tappedResultButton) forControlEvents:UIControlEventTouchUpInside];
    } else {
        resultLabel.text = [NSString stringWithFormat:@"マッチングはありませんでした…"];
        [resultButton setTitle:@"もう一度" forState:UIControlStateNormal];
        [resultButton addTarget:self action:@selector(tappedBackButton) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)tappedResultButton {
    UIView *resultView = (UIView*)[self.view viewWithTag:70000];
    for (UIView *view in [resultView subviews]) {
        [view removeFromSuperview];
    }
    
    [self displayResult];
}

- (void)displayResult {
    displayingCoupleId = 0;

    UIView *resultView = (UIView*)[self.view viewWithTag:70000];
    
    int maleUserNum = (int)[[couple objectAtIndex:displayingCoupleId] intValue] / 10;
    int femaleUserNum = (int)[[couple objectAtIndex:displayingCoupleId] intValue] % 10;
    
    [_chooseAndResultView layoutUserView:0 UserId:2000];
    
    UIView *maleUserView = (UIView*)[_chooseAndResultView viewWithTag:2000];
    
    UILabel *maleUserViewLabel = (UILabel*)[maleUserView.subviews objectAtIndex:2];
    maleUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(maleUserNum - 1) * 2 + 1];
    
    UIImageView *maleUserViewImageView = (UIImageView*)[maleUserView.subviews objectAtIndex:0];
    maleUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(maleUserNum - 1) * 2];

    [_chooseAndResultView layoutUserView:1 UserId:1001];
    
    UIView *femaleUserView = (UIView*)[_chooseAndResultView viewWithTag:2001];
    
    UILabel *femaleUserViewLabel = (UILabel*)[femaleUserView.subviews objectAtIndex:2];
    femaleUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(femaleUserNum - 1) * 2 + 1];
    
    UIImageView *femaleUserViewImageView = (UIImageView*)[femaleUserView.subviews objectAtIndex:0];
    femaleUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(femaleUserNum - 1) * 2];
    
    maleUserView.frame = CGRectMake((resultView.frame.size.width - maleUserView.frame.size.width) / 2,
                                    30,
                                    maleUserView.frame.size.width,
                                    maleUserView.frame.size.height);
    femaleUserView.frame = CGRectMake((resultView.frame.size.width - femaleUserView.frame.size.width) / 2,
                                      maleUserView.frame.origin.y + maleUserView.frame.size.height + 30,
                                      femaleUserView.frame.size.width,
                                      femaleUserView.frame.size.height);
    [resultView addSubview:maleUserView];
    [resultView addSubview:femaleUserView];
    
    UIButton *resultButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                        resultView.frame.size.height - 60,
                                                                        resultView.frame.size.width / 2,
                                                                        30)];
    resultButton.center = CGPointMake(resultView.frame.size.width / 2,
                                      resultButton.center.y);
    resultButton.backgroundColor = [UIColor blackColor];
    [resultView addSubview:resultButton];
    resultButton.exclusiveTouch = YES;
    [resultButton addTarget:self action:@selector(tappedNextResultButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if (displayingCoupleId + 1 < (int)[couple count]) {
        [resultButton setTitle:@"次の結果を見る" forState:UIControlStateNormal];
    } else {
        [resultButton setTitle:@"もう一度" forState:UIControlStateNormal];
    }

}

- (void)tappedNextResultButton:(UIButton*)button {
    if (displayingCoupleId + 1 < (int)[couple count]) {
        displayingCoupleId++;
        
        int maleUserNum = (int)[[couple objectAtIndex:displayingCoupleId] intValue] / 10;
        int femaleUserNum = (int)[[couple objectAtIndex:displayingCoupleId] intValue] % 10;

        UIView *resultView = (UIView*)[self.view viewWithTag:70000];

        UIView *maleUserView = (UIView*)[resultView viewWithTag:2000];
        
        UILabel *maleUserViewLabel = (UILabel*)[maleUserView.subviews objectAtIndex:2];
        maleUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(maleUserNum - 1) * 2 + 1];
        
        UIImageView *maleUserViewImageView = (UIImageView*)[maleUserView.subviews objectAtIndex:0];
        maleUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).maleUser objectAtIndex:(maleUserNum - 1) * 2];
        
        [_chooseAndResultView layoutUserView:1 UserId:1001];
        
        UIView *femaleUserView = (UIView*)[resultView viewWithTag:2001];
        
        UILabel *femaleUserViewLabel = (UILabel*)[femaleUserView.subviews objectAtIndex:2];
        femaleUserViewLabel.text = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(femaleUserNum - 1) * 2 + 1];
        
        UIImageView *femaleUserViewImageView = (UIImageView*)[femaleUserView.subviews objectAtIndex:0];
        femaleUserViewImageView.image = [((AppDelegate*)[[UIApplication sharedApplication] delegate]).femaleUser objectAtIndex:(femaleUserNum - 1) * 2];
        
        if (displayingCoupleId + 1 >= (int)[couple count]) {
            [button setTitle:@"もう一度" forState:UIControlStateNormal];
        }
        
    } else {
        [self dismissViewControllerAnimated:YES completion: nil];
    }
    

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
