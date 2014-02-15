//
//  DiaryDayCell.h
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryDayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numSavedMsg;
@property (weak, nonatomic) IBOutlet UIView *background;
@property (weak, nonatomic) IBOutlet UITextView *msg;

@end
