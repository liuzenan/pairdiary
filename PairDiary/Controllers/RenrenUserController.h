//
//  RenrenUserController.h
//  PairDiary
//
//  Created by qiyue song on 22/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <RennSDK/RennSDK.h>
#import "User.h"

@protocol RenrenLoginDelegate <NSObject>

- (void) renrenLoginSuccess;
- (void) renrenLoginFailedWithError:(NSError *)error;
- (void) renrenLogoutSuccess;

@end

@interface RenrenUserController : NSObject

@property (nonatomic, weak) id<RenrenLoginDelegate> loginDelegate;

// Singleton
+ (RenrenUserController *)sharedInstance;

/*
 * Method name: isLoggedIn
 * Description: Returns the logged in status of the user
 */
- (BOOL)isLoggedIn;

/*
 * Method name: loginRenrenUser
 * Description: Logs in the user using Renren with the permissions
 required by the application
 */
- (void)loginRenrenUser;


/*
 * Method name: fetchCurrentUser
 * Description: return the current user who has logged in.
 */
- (User*)fetchCurrentUser;

/*
 * Method name:fetchRenrenDetailsWithCompletionHandler
 * Parameters: void(^)()
 * Description: Gets the details of the Facebook details of the currently
 logged in user
 */
- (void)fetchRenrenDetailsWithCompletionHandler: (void(^)())completion;

/*
 * Method name: logout
 * Description: Logs out the current user
 */
- (void)logout;

@end
