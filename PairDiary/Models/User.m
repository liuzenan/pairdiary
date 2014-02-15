//
//  User.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "User.h"
#import <Parse/PFObject+Subclass.h>

#pragma mark - PFObject User Class

// Class key

NSString *const kMRUserClassKey = @"User";
NSString *const kMRUserUserNameKey = @"username";
NSString *const kMRUserDisplayNameKey = @"displayName";
NSString *const kMRUserEmailKey = @"email";
NSString *const kMRUserFacebookIdKey = @"facebookId";
NSString *const kMRUserObjectIdKey = @"objectId";

@implementation User

@dynamic username;
@dynamic displayName;
@dynamic email;
@dynamic facebookId;

+ (NSString *)parseClassName {
    return kMRUserClassKey;
}

- (User*)initWithPFUser:(PFUser*)user{
    self = [super init];
    if(self){
        self.objectId = user.objectId;
        self.username = [user objectForKey:kMRUserUserNameKey];
        self.displayName = [user objectForKey:kMRUserDisplayNameKey];
        self.email = [user objectForKey:kMRUserEmailKey];
        self.facebookId = [user objectForKey:kMRUserFacebookIdKey];
    }
    return self;
}

@end
