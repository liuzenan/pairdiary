//
//  StatisticsController.m
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "StatisticsController.h"

@implementation StatisticsController

+ (void)totalMessageCount:(NSString *)pairId handler:(void(^)(NSInteger))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PFQuery *queryForChats = [Chat query];
        [queryForChats whereKey:@"pairId" equalTo:pairId];
        __block NSInteger count = [queryForChats countObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(count>1)
                block(count);
            else
                block(0);
        });
    });
}
+ (void)todayMessageCount:(NSString *)pairId handler:(void(^)(NSInteger))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
        
        [components setHour:-[components hour]+7];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];
        
        PFQuery *query = [Chat query];
        [query whereKey:@"pairId" equalTo:pairId];
        [query whereKey:@"createdAt" greaterThan:today];
        
        __block NSInteger count = [query countObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(count>1)
                return block(count);
            else
                return block(0);
        });
    });
}

+(void)totalPhotos:(NSString *)pairId handler:(void(^)(NSInteger))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            return block(0);
        });
    });
}

+(void)totalSavedMessage:(NSString *)pairId handler:(void(^)(NSInteger))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block PFQuery *queryForChats = [Diary query];
        [queryForChats whereKey:@"pairId" equalTo:pairId];
        __block NSInteger count = [queryForChats countObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(count>1)
                return block(count);
            else
                return block(0);
        });

    });
}

+(void)totalDate:(NSString *)pairId handler:(void(^)(NSInteger))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PFQuery *queryForChats = [Chat query];
        [queryForChats whereKey:@"pairId" equalTo:pairId];
        [queryForChats orderByAscending:@"createdAt"];
        Chat* firstMessage =(Chat*)[queryForChats getFirstObject];
        if(firstMessage){
            __block NSInteger dayDifference = [self daysBetweenDate:firstMessage.createdAt andDate:[NSDate date]] + 1;
            NSLog(@"%@",firstMessage.createdAt);
            NSLog(@"day difference %ld",dayDifference);
            dispatch_async(dispatch_get_main_queue(), ^{
                return block(dayDifference);
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                return block(0);
            });
            
        }
    });
}
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+(void)totalMessageForDate: (NSDate*)date forPair:(NSString*)pairId handler:(void(^)(NSInteger))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    PFQuery *query1 = [Diary query];
    [query1 whereKey:@"pairId" equalTo:pairId];
    PFQuery *query2 = [Diary query];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    [query2 whereKey:@"createdAt" equalTo:stringFromDate];
    
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[query1, query2]];
    __block NSInteger count = [query countObjects];
    dispatch_async(dispatch_get_main_queue(), ^{
        if(count>1)
            return block(count);
        else
            return block(0);
    });

    });

}
@end
