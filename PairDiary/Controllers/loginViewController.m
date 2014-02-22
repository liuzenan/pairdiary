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
    [FacebookUserController sharedInstance].loginDelegate = self;
    [RenrenUserController sharedInstance].loginDelegate = self;

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if([[FacebookUserController sharedInstance] isLoggedIn]){
        NSLog(@"current user : facebook %@",[PFUser currentUser]);
        [self performSegueWithIdentifier:@"pushPairing" sender:self];
    }else if([[RenrenUserController sharedInstance] isLoggedIn]){
        NSLog(@"current user : renren %@",[PFUser currentUser]);
        [self performSegueWithIdentifier:@"pushPairing" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookLoginButtonPressed:(id)sender {
    [[FacebookUserController sharedInstance] loginFaceBookUser];
}

-(void) facebookLoginSuccess{
    [self performSegueWithIdentifier:@"pushPairing" sender:self];
}

- (void) facebookLoginFailedWithError:(NSError*)error {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"Login Failed"];
    }
}

- (void) facebookLogoutSuccess {
    [SVProgressHUD showWithStatus:@"logout successfully!"];
}

- (IBAction)renrenLoginButtonPressed:(id)sender {
    [[RenrenUserController sharedInstance] loginRenrenUser];
}

-(void) renrenLoginSuccess {
    [self performSegueWithIdentifier:@"pushPairing" sender:self];
}

- (void) renrenLoginFailedWithError:(NSError*)error {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"Login Failed"];
    }
}

- (void) renrenLogoutSuccess {
    [SVProgressHUD showWithStatus:@"logout successfully!"];
}

@end
