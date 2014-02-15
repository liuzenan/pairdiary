//
//  loginViewController.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if([[UserController sharedInstance] isLoggedIn]){
        NSLog(@"current user : %@",[PFUser currentUser]);
        [self performSegueWithIdentifier:@"pushPairing" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    [[UserController sharedInstance] loginFaceBookUser];
    [SVProgressHUD showWithStatus:@"Logging in..."];
}


-(void) facebookLoginSuccessWithNewUser {
    //DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    [self facebookLoginSuccessWithExistingUser];
}

-(void) facebookLoginSuccessWithExistingUser {
    //DDLogVerbose(@"%@: %@", THIS_FILE, THIS_METHOD);
    [SVProgressHUD dismiss];
    [self performSegueWithIdentifier:@"pushPairing" sender:self];
}

- (void) facebookLoginFailedWithError:(NSError*)error {
    //DDLogVerbose(@"%@: %@: %@", THIS_FILE, THIS_METHOD,[error localizedDescription]);
    if (error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"Login Failed"];
    }
}
@end
