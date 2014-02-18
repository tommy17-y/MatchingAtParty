//
//  MatchingAtPartyView.m
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/01/27.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import "MatchingAtPartyView.h"

@implementation MatchingAtPartyView

- (UIButton*)startButton {
    if(!_startButton) {
        CGRect rect;
        rect = [[UIScreen mainScreen] bounds];
        _startButton = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width / 3,
                                                                  rect.size.height / 3 - 20,
                                                                  rect.size.width / 3,
                                                                  rect.size.height / 10)];
        [_startButton setTitle:@"start" forState:UIControlStateNormal];
        [_startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_startButton setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_startButton];
    }
    return  _startButton;
}

- (UIButton*)cameraButton {
    if(!_cameraButton) {
        CGRect rect;
        rect = [[UIScreen mainScreen] bounds];
        _cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(rect.size.width / 3,
                                                                  rect.size.height / 3 + 50,
                                                                  rect.size.width / 3,
                                                                  rect.size.height / 10)];
        [_cameraButton setTitle:@"camera" forState:UIControlStateNormal];
        [_cameraButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cameraButton setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_cameraButton];
    }
    return  _cameraButton;
}

- (UIButton*)magnifyButton{
    if(!_magnifyButton) {
        CGRect rect;
        rect = [[UIScreen mainScreen] bounds];
        _magnifyButton = [[UIButton alloc] initWithFrame:CGRectMake(20,
                                                                   rect.size.height - [[UIScreen mainScreen] applicationFrame].size.height + 20,
                                                                   35,
                                                                   30)];
        UIImage *img = [UIImage imageNamed:@"search.png"];
        [_magnifyButton setBackgroundImage:img forState:UIControlStateNormal];
        [self addSubview:_magnifyButton];
    }
    return  _magnifyButton;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
