//
//  StatisticsController.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface StatisticsController : NSObject
+ (void)totalMessageCount:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)todayMessageCount:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)totalPhotos:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)totalDate:(NSString *)pairId handler:(void(^)(NSInteger))block;
+(void)totalSavedMessage:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (void)totalMessageForDate: (NSDate*)date forPair:(NSString *)pairId handler:(void(^)(NSInteger))block;
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
@end
