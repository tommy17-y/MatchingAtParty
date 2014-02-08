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

- (UIButton*)plusMaleUserButton;
- (UIButton*)plusFemaleUserButton;

- (void)layoutUserView:(int)gender UserId:(int)userId columnNum:(int)columnNum;
@end
