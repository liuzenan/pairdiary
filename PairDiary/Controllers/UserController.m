//
//  UserController.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "UserController.h"
#import <Parse/PFObject+Subclass.h>
#import "SVProgressHUD.h"

#define FACEBOOK_ID_KEY @"fb_id_for_%@"

@implementation UserController

+ (id)sharedInstance
{
    static UserController *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[UserController alloc] init];
    });
    
    return __sharedInstance;
}

- (BOOL)isLoggedIn {
    return [FBSession activeSession].isOpen && [[PFUser currentUser] isAuthenticated];
}

- (void)loginFaceBookUser
{
    NSArray *permissionsArray = @[ @"email", @"user_about_me", @"user_photos", @"friends_photos", @"publish_actions", @"friends_about_me", @"friends_birthday", @"user_likes", @"friends_likes",@"friends_relationships",@"user_relationships", @"friends_hometown", @"friends_videos", @"user_videos", @"user_photo_video_tags", @"friends_photo_video_tags", @"user_checkins", @"friends_checkins", @"user_activities", @"friends_activities", @"user_games_activity", @"friends_games_activity", @"user_events", @"create_event", @"rsvp_event"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        NSLog(@"%@",user.objectId);
        if (!user) {
            if (!error) {
                //DDLogVerbose(@"Uh oh. The user cancelled the Facebook login.");
                [self.loginDelegate facebookLoginFailedWithError:nil];
            } else {
                //DDLogVerbose(@"Uh oh. An error occurred: %@", error);
                [self.loginDelegate facebookLoginFailedWithError:error];
            }
            
        } else if (user.isNew) {
            [self fetchFacebookDetailsWithCompletionHandler:^{
                [self.loginDelegate facebookLoginSuccessWithNewUser];
            }];
            
        } else {
            [self fetchFacebookDetailsWithCompletionHandler:^{
                [self.loginDelegate facebookLoginSuccessWithExistingUser];
            }]; // Temporary so that everyone's data will be in
        }
    }];
}

- (void)fetchFacebookDetailsWithCompletionHandler: (void(^)())completion {
    
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSLog(@"%@",result);
        NSDictionary *facebookDetails = [NSDictionary dictionaryWithDictionary:result];
        User *currentUser = (User *)[User currentUser];
        [currentUser setEmail:[facebookDetails objectForKey:@"email"]];
        [currentUser setObject:[facebookDetails objectForKey:@"id"] forKey:UserFacebookIdKey];
        [currentUser setObject:[facebookDetails objectForKey:@"name"] forKey:UserDisplayNameKey];
        [currentUser setObject:[facebookDetails objectForKey:@"first_name"] forKey:UserFirstNameKey];
        [currentUser setObject:[facebookDetails objectForKey:@"last_name"] forKey:UserLastNameKey];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                NSLog(@"save logined user successfully.");
            }else{
                NSLog(@"%@",error);
            }
        }];
        
        //[currentUser saveInBackgroundWithTarget:[ServerController sharedInstance] selector:@selector(attachUserToInstallation)];
        
        completion();
    }];
}

- (User*)fetchCurrentUser {
    return (User*)[User currentUser];
}

- (void)fetchUserForUserID:(NSString*)userId WithCompletionHandler: (void(^)(User *user))completion {
//    [ServerController queryUserWithConditions:@{kMRUserObjectIdKey:userId} andCompletionHandler:^(NSArray *results, NSError *error) {
//        if(!error && results.count > 0) {
//            User *user = [results objectAtIndex:0];
//            completion(user);
//        } else {
//            completion(nil);
//        }
//    }];
}

-(void)logout{
    [PFUser logOut];
}

@end
