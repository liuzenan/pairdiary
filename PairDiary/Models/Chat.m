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

- (Chat*)initWithPFObject:(PFObject *)chat{
    self = [super init];
    if(self){
        self.text = [chat objectForKey:@"text"];
        self.pairId = [chat objectForKey:@"pairId"];
        self.fromUser = [chat objectForKey:@"fromUser"];
        self.toUser = [chat objectForKey:@"toUser"];
    }
    return self;
}
@end
