//
//  UserListViewController.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/29.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "UserListViewController.h"
#import "UserListView.h"

@interface UserListViewController ()

@end

@implementation UserListViewController

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
    
    maleUserNum = 1;
    femaleUserNum = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UserListView *userListView = [[UserListView alloc] init];
    userListView.tag = 10000;
    
    [userListView plusMaleUserButton];
    [userListView.plusMaleUserButton addTarget:self action:@selector(tappedPlusMaleUserButton) forControlEvents:UIControlEventTouchUpInside];
    userListView.plusMaleUserButton.exclusiveTouch = YES;
    
    [userListView plusFemaleUserButton];
    [userListView.plusFemaleUserButton addTarget:self action:@selector(tappedPlusFemaleUserButton) forControlEvents:UIControlEventTouchUpInside];
    userListView.plusFemaleUserButton.exclusiveTouch = YES;
    
    [self.view addSubview:userListView.plusMaleUserButton];
    [self.view addSubview:userListView.plusFemaleUserButton];
    
    UITextField *tf = [userListView layoutUserView:0 totalUserNum:1];
    tf.delegate = self;
    [self.view addSubview:(UIView*)[userListView viewWithTag:1]];
    
    tf = [userListView layoutUserView:1 totalUserNum:2];
    tf.delegate = self;
    [self.view addSubview:(UIView*)[userListView viewWithTag:2]];
    
 }

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)tappedPlusMaleUserButton {
    maleUserNum++;
}

- (void)tappedPlusFemaleUserButton {
    femaleUserNum++;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
