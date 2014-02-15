//
//  DiaryViewController.h
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiaryViewController : UITableViewController

@property (strong, nonatomic) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UILabel *msgTotal;
@property (weak, nonatomic) IBOutlet UILabel *msgToday;
@property (weak, nonatomic) IBOutlet UILabel *photoCount;
@property (weak, nonatomic) IBOutlet UILabel *dayCount;
@property (weak, nonatomic) IBOutlet UILabel *msgInDiary;

@end
