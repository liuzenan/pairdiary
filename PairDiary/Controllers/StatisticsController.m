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
        PFQuery *query1 = [PFQuery queryWithClassName:@"Chat"];
        [query1 whereKey:@"pairId" equalTo:pairId];
        PFQuery *query2 = [PFQuery queryWithClassName:@"Chat"];
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
    PFQuery *queryForChats = [PFQuery queryWithClassName:@"Diary"];
    [queryForChats whereKey:@"pairId" equalTo:pairId];
    [queryForChats orderByAscending:@"createdAt"];
    PFObject* firstMessage =[queryForChats getFirstObject];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    NSDate *firstDate = [formatter dateFromString:firstMessage[@"createdAt"]];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:firstDate
                                                 toDate:[NSDate date]
                                                options:0];
    return block(components.day);
    });
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
