//
//  PairingViewController.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "PairingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>
<<<<<<< HEAD
#import <Parse/Parse.h>
#import <FacebookSDK/FBGraphUser.h>
#import "SVProgressHUD.h"
#import "PairDiaryMessageViewController.h"
=======
>>>>>>> 434293b54636c64662e1bbef7607a8b352d94795

@interface PairingViewController ()

@end

@implementation PairingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

<<<<<<< HEAD
-(void)friendSelected:(id<FBGraphUser>)user
{
    NSLog(@"rendering friend's profile");
    NSLog(@"%@",user);
    NSURL *imageURL = [NSURL URLWithString:user[@"picture"][@"data"][@"url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.FriendAvatarImageView setImage:image];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}
=======
>>>>>>> 434293b54636c64662e1bbef7607a8b352d94795
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectPartnerButtonPressed:(id)sender {
<<<<<<< HEAD
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    FriendInvitationViewController * FIViewController =(FriendInvitationViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"FriendInvitation"];
//    FIViewController.PairingDelegate = self;
//    [self presentViewController:FIViewController animated:YES completion:Nil];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    [FBWebDialogs
     presentRequestsDialogModallyWithSession:nil
     message:@"Try our application PairDiary!"
     title:nil
     parameters:nil
     handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or sending the request.
             NSLog(@"Error sending request.");
         } else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // User clicked the "x" icon
                 NSLog(@"User canceled request.");
             } else {
                 // Handle the send request callback
                 NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                 if (![urlParams valueForKey:@"request"]) {
                     // User clicked the Cancel button
                     NSLog(@"User canceled request.");
                 } else {
                     NSLog(@"urlParams: %@",resultURL);
                     // User clicked the Send button
                     NSString *requestID = [urlParams valueForKey:@"request"];
                     NSLog(@"Request ID: %@", requestID);
                     [SVProgressHUD dismiss];
                     UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                     PairDiaryMessageViewController * PairDiaryMessaging = (PairDiaryMessageViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"home"];
                     [self presentViewController:PairDiaryMessaging animated:YES completion:Nil];
                     
                 }
             }
         }
     }];
=======
>>>>>>> 434293b54636c64662e1bbef7607a8b352d94795
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}


//- (void)loadFacebookInvite {
//    [[FriendsController sharedInstance] getInviteRequestCurrentFriendListWithCompletionHandler:^(NSArray *friendsArray, NSError *error) {
//        if(!error){
//            NSMutableArray *excludeFriends = [[NSMutableArray alloc] init];
//            for(NSString * friend in friendsArray){
//                [excludeFriends addObject:friend];
//            }
//            NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                           [excludeFriends componentsJoinedByString:@","], @"exclude_ids",nil];
//            [FBWebDialogs presentRequestsDialogModallyWithSession:nil message:[NSString stringWithFormat:@"Come and join me for a private timeline in Amigo!"] title:@"Invite Friends" parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
//                if (error) {
//                    // Case A: Error launching the dialog or sending request.
//                    DDLogVerbose(@"Error sending request.");
//                } else {
//                    if (result == FBWebDialogResultDialogNotCompleted) {
//                        // Case B: User clicked the "x" icon
//                        DDLogVerbose(@"User canceled request.");
//                    } else {
//                        NSArray *facebookIDArray = [self parseFacebookIDsFromURL:resultURL];
//                        DDLogVerbose(@"Request Sent to: %@",facebookIDArray);
//                        
//                        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
//                        [FriendsController inviteFriends:facebookIDArray withCompletionHandler:^(NSError *error) {
//                            if (error)
//                                [SVProgressHUD showErrorWithStatus:@"An error occurred."];
//                            else {
//                                [SVProgressHUD showSuccessWithStatus:@"Friends successfully invited."];
//                                [self loadData];
//                            }
//                        }];
//                        
//                    }
//                }
//            }];
//            
//        }
//    }];
//}
@end
