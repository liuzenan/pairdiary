//
//  Pair.m
//  PairDiary
//
//  Created by Shaohuan Li on 22/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "Pair.h"

#import <Parse/PFObject+Subclass.h>

NSString *const PairClassKey = @"Pair";

@implementation Pair

@dynamic user1;
@dynamic user2;

+ (NSString *)parseClassName {
    return PairClassKey;
}
@end