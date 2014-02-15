//
//  PairDiaryMessageViewController.m
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "PairDiaryMessageViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];

   /* PFQuery *query= [PFUser query];
    [query whereKey:@"username" equalTo:@"Harrison"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        PFUser *firstUser = (PFUser *)object;
        PFQuery *query= [PFUser query];
        [query whereKey:@"username" equalTo:@"Shao"];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object,NSError *error){
            PFUser *secondUser = (PFUser *)object;
            PFObject *pair = [PFObject objectWithClassName:@"Pair"];
            pair[@"user1"] = firstUser.objectId;
            pair[@"user2"] = secondUser.objectId;
            [pair saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(!error){
                    NSLog(@"saved successfully.");
                }else{
                    NSLog(@"%@",error);
                }
            }];
        }];
    }];*/
    PFQuery *query = [PFQuery queryWithClassName:@"Pair"];
    [query whereKey:@"id" equalTo:@"317giHX8Wt"];
    [query getObjectInBackgroundWithId:@"317giHX8Wt" block:^(PFObject *object, NSError *error){
        self.pair = object;
        NSLog(@"inside");
        NSLog(@"%@",self.pair);
        // Do something with the returned PFObject in the gameScore variable.
        self.dataSource = self;
        self.delegate   = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [[JSBubbleView appearance]setFont:[UIFont systemFontOfSize:16.0f]];
        self.messageInputView.textView.placeHolder = @"Be original";
        [self setBackgroundColor:[UIColor whiteColor]];
        self.currentUser = [PFUser currentUser];
        PFUser *testUser = self.pair[@"user1"];
        
        if ([testUser.objectId isEqualToString:self.currentUser.objectId]) {
            self.withUser = self.pair[@"user2"];
        } else {
            
            self.withUser = self.pair[@"user1"];
        }
        
        NSString *picstring = self.withUser[@"profilePic"];
        NSData *profilePictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:picstring]];
        UIImage *profilePicture = [UIImage imageWithData:profilePictureData];
        
        UIImageView *chatBackRound = [[UIImageView alloc]initWithImage:profilePicture];
        
        self.tableView.backgroundView  = chatBackRound;
        self.title = self.withUser[@"username"];
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
        PFObject *chat = [PFObject objectWithClassName:@"Chat"];
        [chat setObject:self.pair forKey:@"pair"];
        [chat setObject:self.currentUser forKey:@"fromUser"];
        [chat setObject:self.withUser forKey:@"toUser"];
        [chat setObject:text forKey:@"text"];
        [chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.chats addObject:chat];
            //[JSMessageSoundEffect playMessageSentSound];
            [self.tableView reloadData];
            [self finishSend];
            [self scrollToBottomAnimated:YES];
        }];
    }
}

-(JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *chat = self.chats[indexPath.row];
    PFUser *testFromUser = chat[@"fromUser"];
    
    if ([testFromUser.objectId isEqualToString:self.currentUser.objectId]) {
        return JSBubbleMessageTypeOutgoing;
    } else {
        
        return JSBubbleMessageTypeIncoming;
    }
}


-(UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *chat = self.chats[indexPath.row];
    PFUser *testFromUser = chat[@"fromUser"];
    
    if ([testFromUser.objectId isEqualToString:self.currentUser.objectId]) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleLightGrayColor]];
    } else {
        
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor colorWithRed:91.0/255.0 green:191.0/255.0 blue:171.0/255.0 alpha:1.0]];
        
    }
    
    
}



-(JSMessagesViewTimestampPolicy)timestampPolicy {
    
    return JSMessagesViewTimestampPolicyAll;
}

-(JSMessagesViewAvatarPolicy)avatarPolicy {
    
    return  JSMessagesViewAvatarPolicyNone;
}

-(JSMessagesViewSubtitlePolicy)subtitlePolicy{
    
    return JSMessagesViewSubtitlePolicyIncomingOnly;
}

-(JSMessageInputViewStyle)inputViewStyle {
    
    return  JSMessageInputViewStyleFlat;
}



-(void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell messageType] == JSBubbleMessageTypeOutgoing ) {
        
        cell.bubbleView.textView.textColor = [UIColor colorWithRed:91.0/255.0 green:191.0/255.0 blue:171.0/255.0 alpha:1.0];
        cell.bubbleView.textView.font = [ UIFont fontWithName:@"Avenir Neue" size:20.0];
        cell.backgroundColor = [UIColor clearColor];
    } else if ([cell messageType] == JSBubbleMessageTypeIncoming) {
        
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
        cell.bubbleView.textView.font = [ UIFont fontWithName:@"Avenir Neue" size:20.0];
        cell.backgroundColor = [UIColor clearColor];
    }
}

-(BOOL)shouldPreventScrollToBottomWhileUserScrolling {
    
    return YES;
}


//data

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *chat = self.chats[indexPath.row];
    NSString *message = chat[@"text"];
    return message;
}

-(NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
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
    
    
    
    PFQuery *qeuryForCHats = [PFQuery queryWithClassName:@"Chat"];
    [qeuryForCHats whereKey:@"pair" equalTo:self.pair];
    [qeuryForCHats orderByAscending:@"createdAt"];
    [qeuryForCHats findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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