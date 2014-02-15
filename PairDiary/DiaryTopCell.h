//
//  DiaryTopCell.h
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalMsg;
@property (weak, nonatomic) IBOutlet UILabel *todayMsg;
@property (weak, nonatomic) IBOutlet UILabel *numPhotos;
@property (weak, nonatomic) IBOutlet UILabel *numDays;
@property (weak, nonatomic) IBOutlet UILabel *numOfMsgInDiary;

@end
