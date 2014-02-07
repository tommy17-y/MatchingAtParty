//
//  UserListViewController.h
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/29.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListView.h"

@interface UserListViewController : UIViewController<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate> {
    int maleUserNum;
    int femaleUserNum;
    int userID;
}

@property (nonatomic, retain) UserListView *userListView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImagePickerController *imagePicker;

@end
