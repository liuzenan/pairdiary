//
//  PairingViewController.h
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PairingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *UserAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *FriendAvatarImageView;
@property (nonatomic) Boolean readyToChat;

- (IBAction)SelectPartnerButtonPressed:(id)sender;

@end
