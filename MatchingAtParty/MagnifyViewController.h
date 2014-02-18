//
//  MagnifyViewController.h
//  MatchingAtParty
//
//  Created by Yuki Tomiyoshi on 2014/02/18.
//  Copyright (c) 2014年 Yuki Tomiyoshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagnifyView.h"

@interface MagnifyViewController : UIViewController {
    NSArray *resultArray;
    NSArray *maleNameArray;
    NSArray *maleImageArray;
    NSMutableArray *maleImageMutableArray;
    NSArray *femaleNameArray;
    NSArray *femaleImageArray;
    NSMutableArray *femaleImageMutableArray;
    int displayingMagnifyId;
}

@property (nonatomic, retain) MagnifyView *magnifyView;

@end
