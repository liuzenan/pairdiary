//
//  Chat.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "Chat.h"

@implementation Chat

@synthesize text,pairId,fromUser,toUser;

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
