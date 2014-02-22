//
//  loginViewController.h
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RenrenUserController.h"
#import "FacebookUserController.h"
#import "SVProgressHUD.h"

@interface LoginViewController : UIViewController <FacebookLoginDelegate,RenrenLoginDelegate>

- (IBAction)facebookLoginButtonPressed:(id)sender;
- (IBAction)renrenLoginButtonPressed:(id)sender;
@end
