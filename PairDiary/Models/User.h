//
//  User.h
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

#pragma mark - PFObject User Class

// Class key
extern NSString *const UserClassKey;
extern NSString *const UserUserNameKey;
extern NSString *const UserDisplayNameKey;
extern NSString *const UserEmailKey;
extern NSString *const UserFacebookIdKey;
extern NSString *const UserObjectIdKey;
extern NSString *const UserFirstNameKey;
extern NSString *const UserLastNameKey;

@interface User : PFUser<PFSubclassing,NSCoding>

+ (NSString *)parseClassName;
- (User*)initWithPFUser:(PFUser*)user;

@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *facebookId;

@end
