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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectPartnerButtonPressed:(id)sender {
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
