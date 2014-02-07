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
    _imagePicker = [[UIImagePickerController alloc] init];
    
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
    
    UIImageView *iv = (UIImageView*)recognizer.view;
    ((AppDelegate*)[[UIApplication sharedApplication] delegate]).tappedUserIconNum = (int)iv.superview.tag;
        
    UIActionSheet *as = [[UIActionSheet alloc] init];
    as.delegate = self;
    [as addButtonWithTitle:@"カメラ起動"];
    [as addButtonWithTitle:@"カメラロールから選択"];
    [as addButtonWithTitle:@"キャンセル"];
    as.cancelButtonIndex = 2;
    [as showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                _imagePicker.delegate = self;
                _imagePicker.allowsEditing = YES;
                _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:_imagePicker animated:YES completion:nil];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"カメラを起動できません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            break;
        case 1:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                _imagePicker.delegate = self;
                _imagePicker.allowsEditing = YES;
                _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:_imagePicker animated:YES completion:nil];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"カメラロールにアクセスできません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            break;
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
	UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
	UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
	UIImage *saveImage;
	
	if(editedImage) {
		saveImage = editedImage;
	}else {
		saveImage = originalImage;
	}
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        imageView.image = saveImage;
       
        UIImageWriteToSavedPhotosAlbum(originalImage, self,
                                       @selector(savedOriginalImage:didFinishSavingWithError:contextInfo:),
                                       NULL);
        UIImageWriteToSavedPhotosAlbum(saveImage, self,
                                       @selector(savedEditedImage:didFinishSavingWithError:contextInfo:),
                                       NULL);
        
	}else {
        
		UIView *view = (UIView*)[self.view viewWithTag:((AppDelegate*)[[UIApplication sharedApplication] delegate]).tappedUserIconNum];
        UIImageView *iv = (UIImageView*)[view.subviews objectAtIndex:0];
        iv.image = saveImage;
        
	}
	
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)savedOriginalImage:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"撮影画像の保存に失敗しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
}

-(void)savedEditedImage:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"編集画像の保存に失敗しました" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
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
    
    if(view.center.x < _scrollView.frame.size.width / 2) {
        maleUserNum--;
        for(int i = 0; i < _scrollView.subviews.count; i++) {
            UIView* subview = [_scrollView.subviews objectAtIndex:i];
            if((subview.center.y > view.center.y) && (subview.center.x < _scrollView.frame.size.width / 2)){
                subview.frame = CGRectMake(subview.frame.origin.x,
                                           subview.frame.origin.y - view.frame.size.height,
                                           subview.frame.size.width,
                                           subview.frame.size.height);
            }
        }
        if(maleUserNum >= femaleUserNum) {
            _scrollView.contentSize = CGSizeMake(view.frame.size.width, _scrollView.contentSize.height - view.frame.size.height);
        }
    } else {
        femaleUserNum--;
        for(int i = 0; i < _scrollView.subviews.count; i++) {
            UIView* subview = [_scrollView.subviews objectAtIndex:i];
            if((subview.center.y > view.center.y) && (subview.center.x > _scrollView.frame.size.width / 2)){
                subview.frame = CGRectMake(subview.frame.origin.x,
                                           subview.frame.origin.y - view.frame.size.height,
                                           subview.frame.size.width,
                                           subview.frame.size.height);
            }
        }
        if(maleUserNum <= femaleUserNum) {
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
