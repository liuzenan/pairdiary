//
//  loginViewController.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "LoginViewController.h"
#import "PhoneVerificationViewController.h"

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

-(void) renrenLoginSuccessWithNewUser {
    GetUserLoginParam *userParam = [[GetUserLoginParam alloc] init];
    [RennClient sendAsynRequest:userParam delegate:self];
}

-(void) renrenLoginSuccessWithExistUser {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PhoneVerificationViewController * PVViewController =(PhoneVerificationViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"Phone Verification"];
    [self presentViewController:PVViewController animated:YES completion:Nil];
}

- (void) renrenLoginFailedWithError:(NSError*)error {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"Login Failed"];
    }
}

- (void) renrenLogoutSuccess {
    [SVProgressHUD showWithStatus:@"logout successfully!"];
}

- (void)rennService:(RennService *)service requestSuccessWithResponse:(id)response{
    NSLog(@"user name %@",response);
    PFUser *user = [PFUser user];
    user.username =[response objectForKey:@"name"];
    user.password = [NSString stringWithFormat:@"%@",[response objectForKey:@"id"]];
    user[@"profileUrl"] = [[[response objectForKey:@"avatar"] objectAtIndex:1] objectForKey:@"url"];
    user[@"renrenId"] = [NSString stringWithFormat:@"%@",[response objectForKey:@"id"]];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            PhoneVerificationViewController * PVViewController =(PhoneVerificationViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"Phone Verification"];
            [self presentViewController:PVViewController animated:YES completion:Nil];
        }
    }];
}
- (void)rennService:(RennService *)service requestFailWithError:(NSError*)error{
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"login failed with reason: %@",error]];
}

@end
