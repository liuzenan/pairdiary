//
//  DataUtil.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil

+ (void)saveMessageToDiary: (NSString*)chatId{
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
    
    [queryForChats whereKey:@"chatId" equalTo:chatId];
    [queryForChats findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if (!error){
        PFObject *message = [PFObject objectWithClassName:@"Diary" dictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                        @"chatId", chatId,@"pairId",objects[0][@"pairId"],@"date",objects[0][@"createdAt"],nil] ];
                             [message saveInBackground];
        }
    }];
    
    
}

+ (NSArray*)getMessagesFor: (NSDate*)date{
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
    
    [queryForChats whereKey:@"createdAt" equalTo:date];
    return [queryForChats findObjects];
}

+ (NSArray*)getImportantMessages: (NSDate*)date{
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
    
    [queryForChats whereKey:@"createdAt" equalTo:date];
    return [queryForChats findObjects];
}
@end
