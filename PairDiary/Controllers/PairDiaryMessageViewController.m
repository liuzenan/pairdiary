//
//  PairDiaryMessageViewController.m
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "PairDiaryMessageViewController.h"
#import "UserController.h"
#import "loginViewController.h"
#import "PairingViewController.h"
#import <UIColor-HexString/UIColor+HexString.h>
#import "ServerController.h"
#import "DiaryViewController.h"

@interface PairDiaryMessageViewController ()

@property (strong, nonatomic) PFUser *withUser;
@property (strong, nonatomic) PFUser *currentUser;

@property (strong, nonatomic) NSTimer *chatsTimer;
@property (nonatomic) BOOL initialLoadComplete;

@property (strong, nonatomic) NSMutableArray *chats;

@property (strong, nonatomic) UIImage *image;

@end

@implementation PairDiaryMessageViewController

-(NSMutableArray *)chats {
    
    if (!_chats) {
        _chats = [[NSMutableArray alloc]init];
    }
    return _chats;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDiary"]) {
        DiaryViewController *vc =[segue destinationViewController];
        [vc setPairId:self.pair.objectId];
    }
}

- (void)viewDidLoad
{
    self.dataSource = self;
    self.delegate   = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [super viewDidLoad];
    
    if (![[UserController sharedInstance] isLoggedIn]) {
        return;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"F26363"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[JSBubbleView appearance] setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17.0f]];
    self.title = @"Loading...";
    [self.messageInputView.textView setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17.0f]];
    [self.messageInputView.sendButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Bold" size:20.0f]];
    
    self.currentUser = [PFUser currentUser];
    //Get the other user
    PFQuery *query1 = [Pair query];
    [query1 whereKey:@"user1" equalTo:self.currentUser[@"facebookId"]];
    [query1 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        if(object){
            self.pair = (Pair*)object;
            NSString *otherUser = object[@"user2"];
            [self getOtherUser:otherUser];
        }else{
            PFQuery *query2 = [Pair query];
            [query2 whereKey:@"user2" equalTo:self.currentUser[@"facebookId"]];
            [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
                if(object){
                    self.pair = (Pair*)object;
                    NSString *otherUser = object[@"user1"];
                    [self getOtherUser:otherUser];
                }else{
                    __block UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:Nil];
                    LoginViewController *login = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"Login"];
                    [self presentViewController:login animated:YES completion:^{
                        PairingViewController *pair = (PairingViewController*)[storyboard instantiateViewControllerWithIdentifier:@"Pairing"];
                        [login.navigationController pushViewController:pair animated:NO];
                    }];
                }
            }];
        }
    }];
}

- (void)getOtherUser:(NSString*)otherUser{
    self.messageInputView.textView.placeHolder = @"Say something...";
    [self setBackgroundColor:[UIColor whiteColor]];
    
    PFQuery *query = [PFUser query];
    
    [query whereKey:@"facebookId" equalTo:otherUser];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        //Possibly the Other User is not registered.
        self.withUser = (PFUser *)object;
        self.title = self.withUser[@"displayName"];
        self.initialLoadComplete = NO;
        
        [self checkForNewChats];
        self.chatsTimer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(checkForNewChats) userInfo:nil repeats:YES];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [self.chatsTimer invalidate];
    self.chatsTimer = nil;
}

#pragma mark - TableViewDataSource


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.chats count];
    
}


#pragma mark tableViewDelegat

-(void)didSendText:(NSString *)text {
    
    if (text.length != 0) {
        Chat *chat=[Chat object];
        chat.pairId = self.pair.objectId;
        chat.fromUser = self.currentUser[@"facebookId"] ;
        chat.toUser = self.withUser[@"facebookId"];
        chat.text = text;
        [self.chats addObject:chat];
        [self.messageInputView.sendButton setEnabled:NO];
        [self.tableView reloadData];
        [JSMessageSoundEffect playMessageSentSound];
        [self finishSend];
        [self scrollToBottomAnimated:YES];
        [chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.messageInputView.sendButton setEnabled:YES];
        }];
    }
}

-(JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Chat *chat = self.chats[indexPath.row];
    NSString *testFromUser = chat[@"fromUser"];
    
    if ([testFromUser isEqualToString:self.currentUser[@"facebookId"]]) {
        return JSBubbleMessageTypeOutgoing;
    } else {
        
        return JSBubbleMessageTypeIncoming;
    }
}


-(UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Chat *chat = self.chats[indexPath.row];
    NSString *testFromUser = chat[@"fromUser"];
    
    if ([testFromUser isEqualToString:self.currentUser[@"facebookId"]]) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleLightGrayColor]];
    } else {
        
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor colorWithRed:91.0/255.0 green:191.0/255.0 blue:171.0/255.0 alpha:1.0]];
        
    }
    
    
}



-(JSMessagesViewTimestampPolicy)timestampPolicy {
    
    return JSMessagesViewTimestampPolicyEveryFive;
}

-(JSMessagesViewAvatarPolicy)avatarPolicy {
    
    return  JSMessagesViewAvatarPolicyNone;
}

-(JSMessagesViewSubtitlePolicy)subtitlePolicy{
    
    return JSMessagesViewSubtitlePolicyIncomingOnly;
}

-(JSMessageInputViewStyle)inputViewStyle
{
    return JSMessageInputViewStyleFlat;
}


-(void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    [cell.bubbleView setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:14.0f]];
    CGRect frame = cell.bubbleView.textView.frame;
    frame.size.height = cell.bubbleView.textView.contentSize.height;
    cell.bubbleView.textView.frame = frame;
    [cell.bubbleView.textView setContentInset:UIEdgeInsetsMake(4.0f, 4.0f, 0, 0)];
    cell.bubbleView.textView.tag = indexPath.row;
    
    frame = cell.bubbleView.frame;
    frame.size.height = cell.bubbleView.textView.contentSize.height + 10.0f;
    [cell.bubbleView.bubbleImageView setFrame: frame];
    
    if ([cell messageType] == JSBubbleMessageTypeIncoming) {
        
        cell.bubbleView.textView.textColor = [UIColor colorWithHexString:@"333333"];
        
        UIImageView *imageView = [JSBubbleImageViewFactory bubbleImageViewForType:JSBubbleMessageTypeIncoming color:[UIColor colorWithHexString:@"F6F6F6"]];
        [cell.bubbleView.bubbleImageView setImage:imageView.image];
        
    } else {
        
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
        
        UIImageView *imageView = [JSBubbleImageViewFactory bubbleImageViewForType:JSBubbleMessageTypeOutgoing color:[UIColor colorWithHexString:@"F26363"]];
        [cell.bubbleView.bubbleImageView setImage:imageView.image];
        
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [cell.bubbleView.textView addGestureRecognizer:singleTap];
}

- (void)cellSingleTap:(UITapGestureRecognizer*)recognizer
{
    NSLog(@"tapped");
    Chat *chat = self.chats[recognizer.view.tag];
    NSLog(@"%@", chat.objectId);
    self.saveObjectId = chat.objectId;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Save to Diary" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: @"Save", nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Save"]) {
        NSLog(@"save the msg");
        [ServerController saveMessageToDiary:self.saveObjectId];
        
    }
}

-(BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    
    return YES;
}


//data

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Chat *chat = self.chats[indexPath.row];
    NSString *message = chat[@"text"];
    return message;
}

-(NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Chat *chat = self.chats[indexPath.row];
    NSDate *date = chat.createdAt;
    return date;
}

-(UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

-(NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark Helper MEthods

-(void)checkForNewChats {
    
    NSInteger oldChatCount = [self.chats count];
    
    PFQuery *queryForChats = [Chat query];
    [queryForChats whereKey:@"pairId" equalTo:self.pair.objectId];
    [queryForChats orderByAscending:@"createdAt"];
    [queryForChats findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (self.initialLoadComplete == NO || oldChatCount != [objects count]) {
                self.chats = [objects mutableCopy];
                [self.tableView reloadData];
                
                if (self.initialLoadComplete == YES) {
                    //[JSMessageSoundEffect playMessageReceivedSound];
                }
                self.initialLoadComplete = YES;
                [self scrollToBottomAnimated:YES];
                
            }
        }
    }];
}

@end