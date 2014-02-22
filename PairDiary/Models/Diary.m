//
//  Diary.m
//  PairDiary
//
//  Created by Shaohuan Li on 22/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "Diary.h"
#import <Parse/PFObject+Subclass.h>

NSString *const DiaryClassKey = @"Diary";

@implementation Diary

@dynamic chatId;
@dynamic pairId;
@dynamic message;
@dynamic date;

+ (NSString *)parseClassName {
    return DiaryClassKey;
}

@end
