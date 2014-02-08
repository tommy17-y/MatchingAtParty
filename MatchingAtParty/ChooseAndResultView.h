//
//  ChooseAndResultView.h
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/02/08.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseAndResultView : UIView {
    float width;
    float height;
}

- (void)layoutUserView:(int)gender UserId:(int)userId;

@end
