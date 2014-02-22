//
//  PhoneVerificationViewController.h
//  PairDiary
//
//  Created by qiyue song on 23/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PhoneVerificationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumber;
@property (weak, nonatomic) IBOutlet UIImageView *verificationCode;

@end
