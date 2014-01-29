//
//  UserListView.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/29.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "UserListView.h"

const int buttonRate = 10;

@implementation UserListView

- (UIButton*)plusMaleUserButton {
    if(!_plusMaleUserButton) {
        _plusMaleUserButton = [[UIButton alloc] initWithFrame:CGRectMake((width - (width / buttonRate * 2)) / 4,
                                                                         30,
                                                                         width / buttonRate,
                                                                         width / buttonRate)];
        UIImage *img = [UIImage imageNamed:@"plusMaleUser.png"];
        [_plusMaleUserButton setBackgroundImage:img forState:UIControlStateNormal];
        _plusMaleUserButton.layer.cornerRadius = 10.0f;
        _plusMaleUserButton.clipsToBounds = YES;
        [self addSubview:_plusMaleUserButton];
    }
    return _plusMaleUserButton;
}

- (UIButton*)plusFemaleUserButton {
    if(!_plusFemaleUserButton) {
        _plusFemaleUserButton = [[UIButton alloc] initWithFrame:CGRectMake((width - (width / buttonRate * 2)) / 4 * 3 + width / buttonRate,
                                                                           30,
                                                                           width / buttonRate,
                                                                           width / buttonRate)];
        UIImage *img = [UIImage imageNamed:@"plusFemaleUser.png"];
        [_plusFemaleUserButton setBackgroundImage:img forState:UIControlStateNormal];
        _plusFemaleUserButton.layer.cornerRadius = 10.0f;
        _plusFemaleUserButton.clipsToBounds = YES;
        [self addSubview:_plusFemaleUserButton];
    }
    return _plusFemaleUserButton;
}

- (UIView*) userView {
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                        0,
                                                        width / 2,
                                                        height / 5)];
    return userView;
}

- (UIImageView*)userIcon {
    UIImageView *userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noIconUser.png"]];
    userIcon.layer.cornerRadius = 10.0f;
    userIcon.clipsToBounds = YES;
    userIcon.userInteractionEnabled = YES;
    return userIcon;
}

- (UIImageView*)userGenderIcon {
    UIImageView *userGenderIcon = [[UIImageView alloc] init];
    userGenderIcon.layer.cornerRadius = 5.0f;
    userGenderIcon.clipsToBounds = YES;
    return userGenderIcon;
}

- (UITextField*)userName {
    UITextField *userName = [[UITextField alloc] init];
    userName.placeholder = @"User Name";
    return userName;
}

- (UITextField*)layoutUserView:(int)gender totalUserNum:(int)userId columnNum:(int)columnNum {
    UIView *userView = [self userView];
    userView.tag = userId;
    if(gender == 0) {
        userView.frame = CGRectMake(0,
                                    (height - userView.frame.size.height) / 2,
                                    userView.frame.size.width,
                                    userView.frame.size.height);
    }else if(gender == 1) {
        userView.frame = CGRectMake(width / 2,
                                    (height - userView.frame.size.height) / 2,
                                    userView.frame.size.width,
                                    userView.frame.size.height);
    }
    
    UIImageView *userIcon = [self userIcon];
    userIcon.frame = CGRectMake(0,
                                0,
                                userView.frame.size.height / 5 * 4,
                                userView.frame.size.height / 5 * 4);
    [userView addSubview:userIcon];
    
    UIImageView *userGenderIcon = [self userGenderIcon];
    userGenderIcon.frame = CGRectMake(userIcon.frame.origin.x,
                                      userIcon.frame.origin.y + userIcon.frame.size.height,
                                      userView.frame.size.height - userIcon.frame.size.height,
                                      userView.frame.size.height - userIcon.frame.size.height);
    if(gender == 0) {
        userGenderIcon.image = [UIImage imageNamed:@"male.png"];
    }else if(gender == 1) {
        userGenderIcon.image = [UIImage imageNamed:@"female.png"];
    }
    [userView addSubview:userGenderIcon];
    
    UITextField *userName = [self userName];
    userName.frame = CGRectMake(userGenderIcon.frame.origin.x + userGenderIcon.frame.size.width,
                                userGenderIcon.frame.origin.y,
                                userView.frame.size.width - userGenderIcon.frame.size.height,
                                userGenderIcon.frame.size.height);
    [userView addSubview:userName];
    
    [self addSubview:userView];
    
    return userName;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        width = [[UIScreen mainScreen] bounds].size.width;
        height = [[UIScreen mainScreen] bounds].size.height;
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
