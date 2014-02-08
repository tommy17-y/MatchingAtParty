//
//  ChooseAndResultView.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/02/08.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "ChooseAndResultView.h"

@implementation ChooseAndResultView

- (UIView*) userView {
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                               0,
                                                               width / 2,
                                                               height / 5)];
    userView.backgroundColor = [UIColor whiteColor];
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

- (UILabel*)userName {
    UILabel *userName = [[UILabel alloc] init];
    return userName;
}

- (void)layoutUserView:(int)gender UserId:(int)userId{      //userId >= 1
    UIView *userView = [self userView];
    userView.tag = gender * 1000 + userId;                  //maleUser:1~1000 femaleUser:1001~
    userView.frame = CGRectMake(20 + (userView.frame.size.width + 20) * (userId - 1),
                                (height / 2 - userView.frame.size.height) / 2,
                                userView.frame.size.width,
                                userView.frame.size.height);
    
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
    
    UILabel *userName = [self userName];
    userName.frame = CGRectMake(userGenderIcon.frame.origin.x + userGenderIcon.frame.size.width,
                                userGenderIcon.frame.origin.y,
                                userView.frame.size.width - userGenderIcon.frame.size.height,
                                userGenderIcon.frame.size.height);
    [userView addSubview:userName];
        
    [self addSubview:userView];
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
