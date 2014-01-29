//
//  MatchingAtPartyViewController.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/27.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "MatchingAtPartyViewController.h"
#import "MatchingAtPartyView.h"

@interface MatchingAtPartyViewController ()

@end

@implementation MatchingAtPartyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MatchingAtPartyView *view = [[MatchingAtPartyView alloc] init];
    
    [view startButton];
    [view.startButton addTarget:self action:@selector(tappedStartButton) forControlEvents:UIControlEventTouchUpInside];

    [view cameraButton];
    [view.cameraButton addTarget:self action:@selector(tappedCameraButton) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:view.startButton];
    [self.view addSubview:view.cameraButton];
    
}

- (void)tappedStartButton {
//    // 次画面を指定して遷移
//    UIViewController *next = [[SubViewController alloc] init];
//    next.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:next animated:YES completion:^ {
//        // 完了時の処理をここに書きます
//    }];
}

- (void)tappedCameraButton {
    
    // カメラ起動
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
