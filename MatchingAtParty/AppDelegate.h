//
//  AppDelegate.h
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/27.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property int tappedUserNum;
@property NSMutableArray *maleUserName;
@property NSMutableArray *maleUserImage;
@property NSMutableArray *femaleUserName;
@property NSMutableArray *femaleUserImage;
@property NSMutableArray *userIdmaleUserchoosingFemaleUser;
@property NSMutableArray *userIdfemaleUserchoosingMaleUser;

@end
