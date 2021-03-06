//
//  PairDiaryAppDelegate.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "PairDiaryAppDelegate.h"
#import <Parse/Parse.h>
#import <RennSDK/RennSDK.h>

#import "LoginViewController.h"
#import "RenrenUserController.h"
#import "FacebookUserController.h"

#import "Chat.h"
#import "Diary.h"
#import "Pair.h"

@implementation PairDiaryAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Chat registerSubclass];
    [Diary registerSubclass];
    [Pair registerSubclass];
    [Parse setApplicationId:@"2Jtj8Ch3fOkMXoWOAgsH8VzftlANtoi4SOdVXokj"
                  clientKey:@"9r9UIOyyKGO1XFJOF0OJSVet5YKlpv9rZYj7HmhJ"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //[PFFacebookUtils initializeFacebook];
    
    [RennClient initWithAppId:@"264753" apiKey:@"fa6e37a3beba4bb7962bc32e53a1c11b" secretKey:@"56f317819aaf4a84b965e224bc69c4c4"];
    [RennClient setTokenType:@"bearer"];

    NSShadow* shadow = [NSShadow new];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Medium" size:17.0f],
                                                            NSShadowAttributeName: shadow
                                                            }];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes: @{
                                                           NSFontAttributeName:[UIFont fontWithName:@"AvenirNext-Medium" size:17.0f]
                                                           } forState:UIControlStateNormal];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (![[RenrenUserController sharedInstance] isLoggedIn]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginViewController * PairDiaryLogin = (LoginViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"Login"];
        [self.window.rootViewController presentViewController:PairDiaryLogin animated:NO completion:Nil];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//-(BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation {
//    return [FBAppCall handleOpenURL:url
//                  sourceApplication:sourceApplication
//                        withSession:[PFFacebookUtils session]];
//}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [RennClient  handleOpenURL:url];
}

@end
