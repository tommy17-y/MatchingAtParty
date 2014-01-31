//
//  UserListViewController.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/29.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "UserListViewController.h"
#import "AppDelegate.h"

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
    userID = 2;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = self.view.bounds.size;
    _scrollView.bounces = NO;
    
    [self.view addSubview:_scrollView];
    
    _userListView = [[UserListView alloc] init];
    
    [_userListView plusMaleUserButton];
    [_userListView.plusMaleUserButton addTarget:self action:@selector(tappedPlusMaleUserButton) forControlEvents:UIControlEventTouchUpInside];
    _userListView.plusMaleUserButton.exclusiveTouch = YES;
    
    [_userListView plusFemaleUserButton];
    [_userListView.plusFemaleUserButton addTarget:self action:@selector(tappedPlusFemaleUserButton) forControlEvents:UIControlEventTouchUpInside];
    _userListView.plusFemaleUserButton.exclusiveTouch = YES;
    
    [self.view addSubview:_userListView.plusMaleUserButton];
    [self.view addSubview:_userListView.plusFemaleUserButton];
    
    _scrollView.frame = CGRectMake(0,
                                   _userListView.plusMaleUserButton.frame.origin.y + _userListView.plusMaleUserButton.frame.size.height + /*ボタンとスクロールのマージン*/10,
                                   rect.size.width,
                                   rect.size.height - _userListView.plusMaleUserButton.frame.origin.y + _userListView.plusMaleUserButton.frame.size.height);
    
    [_userListView layoutUserView:0 UserId:1 columnNum:maleUserNum];
    UIView *view = (UIView*)[_userListView viewWithTag:1];
    UITextField *tf = (UITextField*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    UIButton *btn = (UIButton*)[view.subviews objectAtIndex:3];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];
    [btn addTarget:self action:@selector(tappedDeleteUserButton:) forControlEvents:UIControlEventTouchDown];
    [_scrollView addSubview:view];
    
    [_userListView layoutUserView:1 UserId:2 columnNum:femaleUserNum];
    view = (UIView*)[_userListView viewWithTag:2];
    tf = (UITextField*)[view.subviews objectAtIndex:2];
    iv = (UIImageView*)[view.subviews objectAtIndex:0];
    btn = (UIButton*)[view.subviews objectAtIndex:3];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];
    [btn addTarget:self action:@selector(tappedDeleteUserButton:) forControlEvents:UIControlEventTouchDown];
    [_scrollView addSubview:view];
    
    _scrollView.contentSize = CGSizeMake(rect.size.width, view.frame.size.height + _userListView.plusMaleUserButton.frame.size.height + [[UIScreen mainScreen] bounds].size.height - [[UIScreen mainScreen] applicationFrame].size.height + /*ボタンとスクロールのマージン*/10 + /*ボタンと画面上部のマージン*/10);
    
 }

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)onTappedUserIcon:(UITapGestureRecognizer *)recognizer {
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImageView *iv = (UIImageView*)recognizer.view;
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).tappedUserIconNum = (int)iv.superview.tag;
        
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"カメラロールにアクセスできません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
	}
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
	UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
	UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
	UIImage *saveImage;
	
	if(editedImage) {
		saveImage = editedImage;
	} else {
		saveImage = originalImage;
	}
	
    UIView *view = (UIView*)[self.view viewWithTag:((AppDelegate*)[[UIApplication sharedApplication] delegate]).tappedUserIconNum];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    iv.image = saveImage;
        
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)tappedPlusMaleUserButton {
    maleUserNum++;
    userID++;
    [_userListView layoutUserView:0 UserId:userID columnNum:maleUserNum];
    UIView *view = (UIView*)[_userListView viewWithTag:userID];
    UITextField *tf = (UITextField*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    UIButton *btn = (UIButton*)[view.subviews objectAtIndex:3];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];
    [btn addTarget:self action:@selector(tappedDeleteUserButton:) forControlEvents:UIControlEventTouchDown];
    [_scrollView addSubview:view];
    
    if(maleUserNum > femaleUserNum) {
        _scrollView.contentSize = CGSizeMake(view.frame.size.width, _scrollView.contentSize.height + view.frame.size.height);
    }
}

- (void)tappedPlusFemaleUserButton {
    femaleUserNum++;
    userID++;
    [_userListView layoutUserView:1 UserId:userID columnNum:femaleUserNum];
    UIView *view = (UIView*)[_userListView viewWithTag:userID];
    UITextField *tf = (UITextField*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    UIButton *btn = (UIButton*)[view.subviews objectAtIndex:3];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];
    [btn addTarget:self action:@selector(tappedDeleteUserButton:) forControlEvents:UIControlEventTouchDown];
    [_scrollView addSubview:view];
    
    if(maleUserNum < femaleUserNum) {
        _scrollView.contentSize = CGSizeMake(view.frame.size.width, _scrollView.contentSize.height + view.frame.size.height);
    }
}

- (void)tappedDeleteUserButton:(UIButton*)button {
    UIView *view = (UIView*)[self.view viewWithTag:button.superview.tag];
    
    // 下にあるビューを上に移動
    if(1) {
        
    }
    
    if(view.frame.origin.x < [[UIScreen mainScreen] bounds].size.width / 2) {
        maleUserNum--;
        if(maleUserNum > femaleUserNum) {
            _scrollView.contentSize = CGSizeMake(view.frame.size.width, _scrollView.contentSize.height - view.frame.size.height);
        }

    }else {
        femaleUserNum--;
        if(maleUserNum < femaleUserNum) {
            _scrollView.contentSize = CGSizeMake(view.frame.size.width, _scrollView.contentSize.height - view.frame.size.height);
        }
    }
    
    [view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
