//
//  FriendInvitationViewController.h
//  PairDiary
//
//  Created by qiyue song on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <FacebookSDK/FBGraphUser.h>
@protocol PairingDelegate

-(void)friendSelected:(NSDictionary<FBGraphUser> *)user;

@end


@interface FriendInvitationViewController : FBFriendPickerViewController <FBFriendPickerDelegate>

@property(nonatomic,weak) id<PairingDelegate> PairingDelegate;

@end
