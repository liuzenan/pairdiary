//
//  DaySummaryViewController.h
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaySummaryViewController : UITableViewController
@property (nonatomic, strong) NSString *pairId;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSDate *date;
@end
