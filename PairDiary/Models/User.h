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
extern NSString *const kMRUserClassKey;
extern NSString *const kMRUserUserNameKey;
extern NSString *const kMRUserDisplayNameKey;
extern NSString *const kMRUserEmailKey;
extern NSString *const kMRUserFacebookIdKey;
extern NSString *const kMRUserObjectIdKey;

@interface User : PFUser<PFSubclassing,NSCoding>

+ (NSString *)parseClassName;
- (User*)initWithPFUser:(PFUser*)user;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *facebookId;

@end