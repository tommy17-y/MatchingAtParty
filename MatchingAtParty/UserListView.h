//
//  UserListView.h
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/29.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListView : UIView {
    float width;
    float height;
}

@property (nonatomic,retain) UIButton *plusMaleUserButton;
@property (nonatomic,retain) UIButton *plusFemaleUserButton;

//@property (nonatomic,retain) UIView *userView;
//@property (nonatomic, retain) UIImageView *userIcon;
//@property (nonatomic, retain) UIImageView *userGenderIcon;
//@property (nonatomic, retain) UITextField *userName;

- (UIButton*)plusMaleUserButton;
- (UIButton*)plusFemaleUserButton;

- (UITextField*)layoutUserView:(int)gender totalUserNum:(int)userId;
@end
