//
//  DataUtil.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "ServerController.h"

@implementation ServerController

+ (void)saveMessageToDiary:(NSString*)chatId{
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
    [queryForChats getObjectInBackgroundWithId:chatId block:^(PFObject *object, NSError *error) {
        if (!error){
            if(object){
                PFObject *message = [PFObject objectWithClassName:@"Diary"];
                [message setObject:chatId forKey:@"chatId"];
                [message setObject:object[@"pairId"] forKey:@"pairId"];
                [message setObject:object[@"text"] forKey:@"message"];
                [message setObject:object.createdAt forKey:@"date"];
                [message saveInBackground];
            }
        }
    }];
}

+ (NSArray*)getMessagesFor: (NSDate*)date{
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
    
    [queryForChats whereKey:@"createdAt" equalTo:date];
    return [queryForChats findObjects];
}

+ (void)getImportantMessages: (NSDate*)date forPair:(NSString*)pairId handler:(void(^)(NSArray*))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        PFQuery *query = [PFQuery queryWithClassName:@"Diary"];
        [query whereKey:@"pairId" equalTo:pairId];
        return block([query findObjects]);
    });
    
}
@end
