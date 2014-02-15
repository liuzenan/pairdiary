//
//  PairDiaryMessageViewController.h
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <JSMessagesViewController/JSMessagesViewController.h>

@interface PairDiaryMessageViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate, UIActionSheetDelegate>
@property (strong, nonatomic) PFObject *pair;
//@property (strong, nonatomic) PFUser *withUser;
@property (strong, nonatomic) NSString *saveObjectId;
@end
