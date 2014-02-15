//
//  StatisticsController.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatisticsController : NSObject

+ (NSInteger) totalMessageCount;
+ (NSInteger) todayMessageCount;
+ (NSInteger) totalSavedMessage;
+ (NSInteger) totalPhotos;
+ (NSInteger) totalDate;
+ (NSInteger) totalMessageForDate: (NSDate*)date;
@end
