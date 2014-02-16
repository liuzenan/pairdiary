//
//  DataUtil.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil

+ (void)saveMessageToDiary:(NSString*)chatId{
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
    [queryForChats getObjectInBackgroundWithId:chatId block:^(PFObject *object, NSError *error) {
        if (!error){
            NSLog(@"%@",object);
            if(object){
                PFObject *message = [PFObject objectWithClassName:@"Diary"];
                [message setObject:chatId forKey:@"chatId"];
                [message setObject:object[@"pairId"] forKey:@"pairId"];
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

+ (NSArray*)getImportantMessages: (NSDate*)date{
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
    
    [queryForChats whereKey:@"createdAt" equalTo:date];
    return [queryForChats findObjects];
}
@end
