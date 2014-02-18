//
//  MatchingAtPartyViewController.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/27.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "MatchingAtPartyViewController.h"
#import "MatchingAtPartyView.h"
#import "UserListViewController.h"
#import "MagnifyViewController.h"

@interface MatchingAtPartyViewController ()

@end

@implementation MatchingAtPartyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MatchingAtPartyView *matchingAtPartyView = [[MatchingAtPartyView alloc] init];
    
    [matchingAtPartyView startButton];
    [matchingAtPartyView.startButton addTarget:self action:@selector(tappedStartButton) forControlEvents:UIControlEventTouchUpInside];
    matchingAtPartyView.startButton.exclusiveTouch = YES;

    [matchingAtPartyView cameraButton];
    [matchingAtPartyView.cameraButton addTarget:self action:@selector(tappedCameraButton) forControlEvents:UIControlEventTouchUpInside];
    matchingAtPartyView.cameraButton.exclusiveTouch = YES;

    [matchingAtPartyView magnifyButton];
    [matchingAtPartyView.magnifyButton addTarget:self action:@selector(tappedmagnifyButton) forControlEvents:UIControlEventTouchUpInside];
    matchingAtPartyView.magnifyButton.exclusiveTouch = YES;

    [self.view addSubview:matchingAtPartyView.startButton];
    [self.view addSubview:matchingAtPartyView.cameraButton];
    [self.view addSubview:matchingAtPartyView.magnifyButton];
    
}

- (void)tappedStartButton {
    UserListViewController *userListViewController = [[UserListViewController alloc] init];
    [self presentViewController:userListViewController animated:YES completion:nil];
}

- (void)tappedCameraButton {
    
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
		UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー" message:@"カメラを起動できません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
	}

}

- (void)tappedmagnifyButton {
    MagnifyViewController *magnifyViewController = [[MagnifyViewController alloc] init];
    [self presentViewController:magnifyViewController animated:YES completion:nil];
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
	
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	imageView.image = saveImage;
	

    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImageWriteToSavedPhotosAlbum(originalImage, self,
                                   @selector(savedOriginalImage:didFinishSavingWithError:contextInfo:),
                                   NULL);
    UIImageWriteToSavedPhotosAlbum(saveImage, self,
                                   @selector(savedEditedImage:didFinishSavingWithError:contextInfo:),
                                   NULL);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
