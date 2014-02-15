//
//  loginViewController.h
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "UserController.h"

@interface loginViewController : UIViewController <FacebookLoginDelegate>

- (IBAction)loginButtonPressed:(id)sender;

@end
