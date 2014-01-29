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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _userListView = [[UserListView alloc] init];
    
    [_userListView plusMaleUserButton];
    [_userListView.plusMaleUserButton addTarget:self action:@selector(tappedPlusMaleUserButton) forControlEvents:UIControlEventTouchUpInside];
    _userListView.plusMaleUserButton.exclusiveTouch = YES;
    
    [_userListView plusFemaleUserButton];
    [_userListView.plusFemaleUserButton addTarget:self action:@selector(tappedPlusFemaleUserButton) forControlEvents:UIControlEventTouchUpInside];
    _userListView.plusFemaleUserButton.exclusiveTouch = YES;
    
    [self.view addSubview:_userListView.plusMaleUserButton];
    [self.view addSubview:_userListView.plusFemaleUserButton];
    
    [_userListView layoutUserView:0 totalUserNum:1 columnNum:maleUserNum];
    UIView *view = (UIView*)[_userListView viewWithTag:1];
    UITextField *tf = (UITextField*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];
    [self.view addSubview:view];
    
    [_userListView layoutUserView:1 totalUserNum:2 columnNum:femaleUserNum];
    view = (UIView*)[_userListView viewWithTag:2];
    tf = (UITextField*)[view.subviews objectAtIndex:2];
    iv = (UIImageView*)[view.subviews objectAtIndex:0];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];
    [self.view addSubview:view];
    
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
    [_userListView layoutUserView:0 totalUserNum:maleUserNum + femaleUserNum columnNum:maleUserNum];
    UIView *view = (UIView*)[_userListView viewWithTag:maleUserNum + femaleUserNum];
    UITextField *tf = (UITextField*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];[self.view addSubview:(UIView*)[_userListView viewWithTag:maleUserNum + femaleUserNum]];
}

- (void)tappedPlusFemaleUserButton {
    femaleUserNum++;
    [_userListView layoutUserView:1 totalUserNum:maleUserNum + femaleUserNum columnNum:femaleUserNum];
    UIView *view = (UIView*)[_userListView viewWithTag:maleUserNum + femaleUserNum];
    UITextField *tf = (UITextField*)[view.subviews objectAtIndex:2];
    UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
    tf.delegate = self;
    [iv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTappedUserIcon:)]];
    [self.view addSubview:(UIView*)[_userListView viewWithTag:maleUserNum + femaleUserNum]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
