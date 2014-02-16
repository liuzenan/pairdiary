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
    dispatch_async(dispatch_get_main_queue(), ^{
        PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
        [queryForChats whereKey:@"pairId" equalTo:pairId];
        if([queryForChats countObjects]>1)
            block([queryForChats countObjects]);
        else
            block(0);
    });
}
+ (void)todayMessageCount:(NSString *)pairId handler:(void(^)(NSInteger))block
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:[[NSDate alloc] init]];
        
        [components setHour:-[components hour]+7];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        NSDate *today = [cal dateByAddingComponents:components toDate:[[NSDate alloc] init] options:0];
        
        PFQuery *query = [PFQuery queryWithClassName:@"Chat"];
        [query whereKey:@"pairId" equalTo:pairId];
        [query whereKey:@"createdAt" greaterThan:today];
        
        if([query countObjects]>1)
            return block([query countObjects]);
        else
            return block(0);
    });
}

+(void)totalPhotos:(NSString *)pairId handler:(void(^)(NSInteger))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        return block(0);
    });
}

+(void)totalSavedMessage:(NSString *)pairId handler:(void(^)(NSInteger))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        PFQuery *queryForChats = [PFQuery queryWithClassName:@"Diary"];
        [queryForChats whereKey:@"pairId" equalTo:pairId];
        if([queryForChats countObjects]>1)
            return block([queryForChats countObjects]);
        else
            return block(0);
    });
}

+(void)totalDate:(NSString *)pairId handler:(void(^)(NSInteger))block{
    dispatch_async(dispatch_get_main_queue(), ^{
        PFQuery *queryForChats = [PFQuery queryWithClassName:@"Chat"];
        [queryForChats whereKey:@"pairId" equalTo:pairId];
        [queryForChats orderByAscending:@"createdAt"];
        PFObject* firstMessage =[queryForChats getFirstObject];
        if(firstMessage){
            NSInteger dayDifference = [self daysBetweenDate:firstMessage.createdAt andDate:[NSDate date]] + 1;
            NSLog(@"%@",firstMessage.createdAt);
            NSLog(@"day difference %ld",dayDifference);
            return block(dayDifference);
        }else{
            return block(0);
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
    dispatch_async(dispatch_get_main_queue(), ^{
    PFQuery *query1 = [PFQuery queryWithClassName:@"Diary"];
    [query1 whereKey:@"pairId" equalTo:pairId];
    PFQuery *query2 = [PFQuery queryWithClassName:@"Diary"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:[NSDate date]];
    [query2 whereKey:@"createdAt" equalTo:stringFromDate];
    
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[query1, query2]];
    
    if([query countObjects]>1)
        return block([query countObjects]);
    else
        return block(0);
    });

}
@end
