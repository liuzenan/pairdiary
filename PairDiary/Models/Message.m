//
//  Message.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize message,pairId,date,chatId;

- (Message*)initWithMsg:(NSString*)s pairId:(NSString*)p created:(NSDate*)d inchat:(NSString*)c{
    self = [super init];
    if(self){
        self.message = s;
        self.pairId = p;
        self.date = d;
        self.chatId = c;
    }
    return self;

}
@end
