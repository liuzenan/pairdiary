//
//  DataUtil.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "ServerController.h"

@implementation ServerController

+ (void)saveChatToDiary:(NSString*)chatId{
    PFQuery *queryForChats = [Chat query];
    [queryForChats getObjectInBackgroundWithId:chatId block:^(PFObject *object, NSError *error) {
        if (!error){
            if(object){
                Diary *diary = [Diary object];
                diary.chatId = chatId;
                diary.pairId = object[@"pairId"];
                diary.message = object[@"text"];
                diary.date = object.createdAt;
                [diary saveInBackground];
            }
        }
    }];
}

+ (void)getDiary:(NSDate*)date forPair:(NSString*)pairId handler:(void(^)(NSArray*))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        PFQuery *query = [Diary query];
        [query whereKey:@"pairId" equalTo:pairId];
        [query whereKey:@"date" equalTo:date];
        return block([query findObjects]);
    });
}

+ (void)getPairDiary:(NSString*)pairId handler:(void(^)(NSArray*))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        PFQuery *query = [Diary query];
        [query whereKey:@"pairId" equalTo:pairId];
        return block([query findObjects]);
    });
}
@end
