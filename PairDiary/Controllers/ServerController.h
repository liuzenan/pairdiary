//
//  ServerController.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chat.h"
#import "Diary.h"
#import <Parse/Parse.h>
@interface ServerController: NSObject

+ (void)saveChatToDiary: (NSString*)chatId;
+ (void)getDiary:(NSDate*)date forPair:(NSString*)pairId handler:(void(^)(NSArray*))block;
+ (void)getPairDiary:(NSString*)pairId handler:(void(^)(NSArray*))block;
@end
