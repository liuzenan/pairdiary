//
//  FriendInvitationViewController.m
//  PairDiary
//
//  Created by qiyue song on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "FriendInvitationViewController.h"
#import "SVProgressHUD.h"

@interface FriendInvitationViewController ()

@end

@implementation FriendInvitationViewController

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
    self.allowsMultipleSelection = false;
    self.delegate = self;
    [self loadData];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)facebookViewControllerDoneWasPressed:(id)sender{
    if(self.selection.count > 0){
        [self dismissViewControllerAnimated:YES completion:Nil];
        id<FBGraphUser> selectedUser = [self.selection objectAtIndex:0];
        [self.PairingDelegate friendSelected:selectedUser];
    }else{
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
    NSLog(@"DONE button pressed.");
}

- (void)facebookViewControllerCancelWasPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:Nil];
    NSLog(@"CANCEL button pressed.");
}
@end
