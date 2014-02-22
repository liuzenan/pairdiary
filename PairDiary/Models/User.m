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

NSString *const UserClassKey = @"User";
NSString *const UserUserNameKey = @"username";
NSString *const UserDisplayNameKey = @"displayName";
NSString *const UserEmailKey = @"email";
NSString *const UserFacebookIdKey = @"facebookId";
NSString *const UserObjectIdKey = @"objectId";
NSString *const UserFirstNameKey = @"first_name";
NSString *const UserLastNameKey = @"last_name";

@implementation User

@dynamic username;
@dynamic displayName;
@dynamic email;
@dynamic facebookId;
@dynamic firstName;
@dynamic lastName;

+ (NSString *)parseClassName {
    return UserClassKey;
}

- (User*)initWithPFUser:(PFUser*)user{
    self = [super init];
    if(self){
        self.objectId = user.objectId;
        self.lastName = [user objectForKey:UserLastNameKey];
        self.firstName = [user objectForKey:UserFirstNameKey];
        self.displayName = [user objectForKey:UserDisplayNameKey];
        self.email = [user objectForKey:UserEmailKey];
        self.facebookId = [user objectForKey:UserFacebookIdKey];
    }
    return self;
}

@end
