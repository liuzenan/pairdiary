//
//  PairingViewController.h
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendInvitationViewController.h"
#import <FacebookSDK/FBGraphUser.h>
@interface PairingViewController : UIViewController<PairingDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *UserAvatarImageView;

@property (weak, nonatomic) IBOutlet UIImageView *FriendAvatarImageView;


- (IBAction)SelectPartnerButtonPressed:(id)sender;

@end
