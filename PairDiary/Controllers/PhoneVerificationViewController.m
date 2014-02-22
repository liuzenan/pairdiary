//
//  PhoneVerificationViewController.m
//  PairDiary
//
//  Created by qiyue song on 23/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "PhoneVerificationViewController.h"
#import "SVProgressHUD.h"

@interface PhoneVerificationViewController ()

@end

@implementation PhoneVerificationViewController

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
    [SVProgressHUD dismiss];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
