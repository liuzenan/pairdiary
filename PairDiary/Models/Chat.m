//
//  Chat.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "Chat.h"
#import <Parse/PFObject+Subclass.h>

NSString *const ChatClassKey = @"Chat";

@implementation Chat

@dynamic text;
@dynamic pairId;
@dynamic fromUser;
@dynamic toUser;

+ (NSString *)parseClassName {
    return ChatClassKey;
}

@end
