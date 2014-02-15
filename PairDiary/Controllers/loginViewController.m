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
    [self facebookLoginSuccessWithExistingUser];
}

-(void) facebookLoginSuccessWithExistingUser {
    [SVProgressHUD dismiss];
    [self performSegueWithIdentifier:@"pushPairing" sender:self];
}

- (void) facebookLoginFailedWithError:(NSError*)error {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"Login Failed"];
    }
}
@end
