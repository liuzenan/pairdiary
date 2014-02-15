//
//  Message.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize fromUser,toUser,text,pairId;

- (Message*)initWithText:(NSString*)s fromUser:(NSString*)from toUser:(NSString*)to inPair:(NSString*)pair{
    self = [super init];
    if(self){
        self.pairId = pair;
        self.fromUser = from;
        self.toUser = to;
        self.text = s;
    }
    return self;

}
@end
