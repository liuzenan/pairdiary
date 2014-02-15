//
//  PairingViewController.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "PairingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FBGraphUser.h>
#import "SVProgressHUD.h"
#import "PairDiaryMessageViewController.h"
#import "FriendInvitationViewController.h"

@interface PairingViewController ()

@end

@implementation PairingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.readyToChat = false;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        NSLog(@"rendering profile");
        NSString *imageUrl = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?&height=200&type=normal&width=200", currentUser[@"facebookId"]];
        NSLog(@"%@",imageUrl);
        NSURL *imageURL = [NSURL URLWithString:imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        [self.UserAvatarImageView setImage:image];
    }
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"appeared already");
    if(self.readyToChat){
        [SVProgressHUD dismiss];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        PairDiaryMessageViewController * PDViewController =(PairDiaryMessageViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"Chat"];
        [self presentViewController:PDViewController animated:YES completion:Nil];
    };
}

-(void)friendSelected:(id<FBGraphUser>)user
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    NSLog(@"rendering friend's profile");
    NSLog(@"%@",user);
    self.readyToChat = true;
    NSURL *imageURL = [NSURL URLWithString:user[@"picture"][@"data"][@"url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [self.FriendAvatarImageView setImage:image];
}

    [self.UserAvatarImage setImage:image];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SelectPartnerButtonPressed:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FriendInvitationViewController * FIViewController =(FriendInvitationViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"FriendInvitation"];
    FIViewController.PairingDelegate = (id<PairingDelegate>)self;
    [self presentViewController:FIViewController animated:YES completion:Nil];
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

@end
