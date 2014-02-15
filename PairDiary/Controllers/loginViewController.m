//
//  loginViewController.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

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
    [UserController sharedInstance].loginDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [[UserController sharedInstance] loginFaceBookUser];
}


-(void) facebookLoginSuccessWithNewUser {
    //DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    [self facebookLoginSuccessWithExistingUser];
}

-(void) facebookLoginSuccessWithExistingUser {
    //DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    [SVProgressHUD showSuccessWithStatus:@"Successfully logged in!"];
}

- (void) facebookLoginFailedWithError:(NSError*)error {
    //DDLogVerbose(@"%@: %@: %@", THIS_FILE, THIS_METHOD,[error localizedDescription]);
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"Login Failed"];
    }
}
@end
