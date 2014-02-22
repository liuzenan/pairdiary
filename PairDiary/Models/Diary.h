//
//  Diary.h
//  PairDiary
//
//  Created by Shaohuan Li on 22/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Parse/Parse.h>

// Class key
extern NSString *const DiaryClassKey;

@interface Diary : PFObject<PFSubclassing>

@property (nonatomic,strong) NSString *chatId;
@property (nonatomic,strong) NSString *pairId;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSDate *date;

+ (NSString *)parseClassName;

@end
