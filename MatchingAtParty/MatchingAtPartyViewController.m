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
        
		UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
		[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
		[imagePickerController setAllowsEditing:YES];
		[imagePickerController setDelegate:self];
		[self presentViewController:imagePickerController animated:YES completion:nil];
        
    } else {
		NSLog(@"camera invalid.");
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
