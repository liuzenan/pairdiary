//
//  StatisticsController.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Diary.h"
#import "Chat.h"

@interface StatisticsController : NSObject
+ (void)totalChatCount:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)todayChatCount:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)totalPhotos:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)totalDate:(NSString *)pairId handler:(void(^)(NSInteger))block;
+(void)totalDiary:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)totalDiaryForDate: (NSDate*)date forPair:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
@end
