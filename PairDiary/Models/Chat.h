//
//  Chat.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

// Class key
extern NSString *const ChatClassKey;

@interface Chat : PFObject<PFSubclassing>

@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *pairId;
@property (nonatomic,strong) NSString *fromUser;
@property (nonatomic,strong) NSString *toUser;

+ (NSString *)parseClassName;
- (Chat*)initWithPFObject:(PFObject*)chat;

@end
