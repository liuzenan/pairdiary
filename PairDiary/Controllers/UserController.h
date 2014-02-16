//
//  UserController.h
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"

@protocol FacebookLoginDelegate <NSObject>

- (void) facebookLoginSuccessWithExistingUser;
- (void) facebookLoginSuccessWithNewUser;
- (void) facebookLoginFailedWithError:(NSError *)error;

@end

@interface UserController : NSObject

@property (nonatomic, weak) id<FacebookLoginDelegate> loginDelegate;

// Singleton
+ (UserController *)sharedInstance;

/*
 * Method name: isLoggedIn
 * Description: Returns the logged in status of the user
 */
- (BOOL)isLoggedIn;

/*
 * Method name: loginFacebookUser
 * Description: Logs in the user using Facebook with the permissions
 required by the application
 */
- (void)loginFaceBookUser;

/*
 * Method name:fetchFacebookDetailsWithCompletionHandler
 * Parameters: void(^)()
 * Description: Gets the details of the Facebook details of the currently
 logged in user
 */
- (void)fetchFacebookDetailsWithCompletionHandler: (void(^)())completion;

/*
 * Method name: logout
 * Description: Logs out the current user
 */
- (void)logout;

@end