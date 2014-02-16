//
//  Message.h
//  PairDiary
//
//  Created by Shaohuan Li on 16/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Message : PFObject

@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *pairId;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) NSString *chatId;


- (Message*)initWithMsg:(NSString*)s pairId:(NSString*)pairId created:(NSDate*)date inchat:(NSString*)chatId;


@end
