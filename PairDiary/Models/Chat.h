//
//  Chat.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Chat : PFObject

@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *pairId;
@property (nonatomic,strong) NSString *fromUser;
@property (nonatomic,strong) NSString *toUser;

- (Chat*)initWithPFObject:(PFObject*)chat;

@end
