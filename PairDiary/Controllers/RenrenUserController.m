//
//  RenrenUserController.m
//  PairDiary
//
//  Created by qiyue song on 22/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "RenrenUserController.h"
#import <Parse/PFObject+Subclass.h>
#import "SVProgressHUD.h"

//#define FACEBOOK_ID_KEY @"fb_id_for_%@"

@implementation RenrenUserController

+ (id)sharedInstance
{
    static RenrenUserController *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[RenrenUserController alloc] init];
    });
    
    return __sharedInstance;
}

- (BOOL)isLoggedIn {
    return [RennClient isLogin];
}

- (void)loginRenrenUser
{
    [RennClient setScope:@"read_user_blog read_user_photo read_user_status read_user_album read_user_comment read_user_share publish_blog publish_share send_notification photo_upload status_update create_album publish_comment publish_feed operate_like"];
    [RennClient loginWithDelegate:self];
}

- (void)fetchRenrenDetailsWithCompletionHandler: (void(^)())completion {
    
}

- (User*)fetchCurrentUser {
    return (User*)[User currentUser];
}

-(void)logout{
    [RennClient logoutWithDelegate:self];
}

- (void)rennLoginSuccess{
    NSLog(@"renren user: %d",[RennClient isLogin]);
    [SVProgressHUD showWithStatus:@"Processing..."];
    [self.loginDelegate renrenLoginSuccess];
}
- (void)rennLogoutSuccess{
    [self.loginDelegate renrenLogoutSuccess];
}

@end
