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
+ (void)totalMessageCount:(NSString *)pairId handler:(void(^)(NSNumber *))block;
+ (NSInteger) todayMessageCount:(NSString*)pairId;
+ (NSInteger) totalSavedMessage:(NSString*)pairId;
+ (NSInteger) totalPhotos:(NSString*)pairId;
+ (NSInteger) totalDate:(NSString*)pairId;
+ (NSInteger) totalMessageForDate: (NSDate*)date forPair:(NSString*)pairId;
@end
