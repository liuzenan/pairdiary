//
//  Pair.h
//  PairDiary
//
//  Created by Shaohuan Li on 22/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Parse/Parse.h>

// Class key
extern NSString *const PairClassKey;

@interface Pair : PFObject<PFSubclassing>

@property (nonatomic,strong) NSString *user1;
@property (nonatomic,strong) NSString *user2;

+ (NSString *)parseClassName;

@end
