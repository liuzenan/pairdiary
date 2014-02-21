//
//  ServerController.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chat.h"
#import <Parse/Parse.h>
@interface ServerController: NSObject

+ (void)saveMessageToDiary: (NSString*)chatId;
+ (NSArray*)getMessagesFor: (NSDate*)date;
+ (void)getImportantMessages: (NSDate*)date forPair:(NSString*)pairId handler:(void(^)(NSArray*))block;
@end
