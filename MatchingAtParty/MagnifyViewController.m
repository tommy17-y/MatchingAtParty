//
//  MagnifyViewController.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/02/18.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "MagnifyViewController.h"

@interface MagnifyViewController ()

@end

@implementation MagnifyViewController

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
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    resultArray = [ud arrayForKey:@"KEY_RESULT"];
    maleNameArray = [ud arrayForKey:@"KEY_MALE_NAME"];
    maleImageArray = [ud arrayForKey:@"KEY_MALE_IMAGE"];
    femaleNameArray = [ud arrayForKey:@"KEY_FEMALE_NAME"];
    femaleImageArray = [ud arrayForKey:@"KEY_FEMALE_IMAGE"];
    
    // NSDateで保存しておいたUserIconをUIImageに戻す
    maleImageMutableArray = [NSMutableArray array];
    femaleImageMutableArray = [NSMutableArray array];
    for(int i = 0; i < [maleImageArray count]; i++) {
        UIImage* image = [UIImage imageWithData:[maleImageArray objectAtIndex:i]];
        [maleImageMutableArray addObject:image];
    }
    for(int i = 0; i < [femaleImageArray count]; i++) {
        UIImage* image = [UIImage imageWithData:[femaleImageArray objectAtIndex:i]];
        [femaleImageMutableArray addObject:image];
    }
    
    displayingMagnifyId = 0;
    
    _magnifyView = [[MagnifyView alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [_magnifyView layoutUserView:0];
    UIView *maleUserView = (UIView*)[_magnifyView viewWithTag:1];
    [self.view addSubview:maleUserView];
    
    int selectedUserIdfemaleUserchoosingMaleUser =[[resultArray objectAtIndex:displayingMagnifyId] intValue];
    
    UILabel *maleUserViewLabel = (UILabel*)[maleUserView.subviews objectAtIndex:2];
    maleUserViewLabel.text = [maleNameArray objectAtIndex:selectedUserIdfemaleUserchoosingMaleUser - 1];
    
    UIImageView *maleUserViewImageView = (UIImageView*)[maleUserView.subviews objectAtIndex:0];
    maleUserViewImageView.image = [maleImageMutableArray objectAtIndex:selectedUserIdfemaleUserchoosingMaleUser - 1];
    
    [_magnifyView layoutUserView:1];
    UIView *femaleUserView = (UIView*)[_magnifyView viewWithTag:1001];
    [self.view addSubview:femaleUserView];
    
    UILabel *femaleUserViewLabel = (UILabel*)[femaleUserView.subviews objectAtIndex:2];
    femaleUserViewLabel.text = [femaleNameArray objectAtIndex:displayingMagnifyId];
    
    UIImageView *femaleUserViewImageView = (UIImageView*)[femaleUserView.subviews objectAtIndex:0];
    femaleUserViewImageView.image = [femaleImageMutableArray objectAtIndex:displayingMagnifyId];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10,
                                                                      [[UIScreen mainScreen] bounds].size.height - [[UIScreen mainScreen] applicationFrame].size.height + 10,
                                                                      60,
                                                                      30)];
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    backButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(tappedBackButton) forControlEvents:UIControlEventTouchUpInside];
    backButton.exclusiveTouch = YES;
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width / 3,
                                                                      [[UIScreen mainScreen] bounds].size.height - 60,
                                                                      [[UIScreen mainScreen] bounds].size.width / 3,
                                                                      40)];
    [nextButton setTitle:@"next" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:nextButton];
    [nextButton addTarget:self action:@selector(tappedNextButton:) forControlEvents:UIControlEventTouchUpInside];
    nextButton.exclusiveTouch = YES;
    
    if(displayingMagnifyId + 1 >= [resultArray count]) {
        nextButton.hidden = YES;
    }

}

- (void)tappedNextButton:(UIButton*)button {
    displayingMagnifyId++;
    
    UIView *femaleUserView = (UIView*)[self.view viewWithTag:1001];
    
    UILabel *femaleUserViewLabel = (UILabel*)[femaleUserView.subviews objectAtIndex:2];
    femaleUserViewLabel.text = [femaleNameArray objectAtIndex:displayingMagnifyId];
    
    UIImageView *femaleUserViewImageView = (UIImageView*)[femaleUserView.subviews objectAtIndex:0];
    femaleUserViewImageView.image = [femaleImageMutableArray objectAtIndex:displayingMagnifyId];
    
    int selectedUserIdfemaleUserchoosingMaleUser =[[resultArray objectAtIndex:displayingMagnifyId] intValue];
    
    UIView *maleUserView = (UIView*)[self.view viewWithTag:1];
    
    UILabel *maleUserViewLabel = (UILabel*)[maleUserView.subviews objectAtIndex:2];
    maleUserViewLabel.text = [maleNameArray objectAtIndex:selectedUserIdfemaleUserchoosingMaleUser - 1];
    
    UIImageView *maleUserViewImageView = (UIImageView*)[maleUserView.subviews objectAtIndex:0];
    maleUserViewImageView.image = [maleImageMutableArray objectAtIndex:selectedUserIdfemaleUserchoosingMaleUser - 1];
    
    if(displayingMagnifyId + 1 >= [resultArray count]) {
        button.hidden = YES;
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
