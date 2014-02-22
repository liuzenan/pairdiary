//
//  DaySummaryViewController.m
//  PairDiary
//
//  Created by qiyue song on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "DaySummaryViewController.h"
#import "ServerController.h"
#import "DiaryDayCell.h"

@interface DaySummaryViewController ()

@end

@implementation DaySummaryViewController
@synthesize pairId;
@synthesize date;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _dataList = [[NSArray alloc] init];
        self.dataList = _dataList;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [ServerController getDiary:self.date forPair:self.pairId handler:^(NSArray * diaries) {
        self.dataList = diaries;
        [self.tableView reloadData];
    }];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DiaryDayCell";
    DiaryDayCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Diary* diary = [self.dataList objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateDisplay = [dateFormatter stringFromDate:diary.createdAt];
    cell.dateLabel.text = dateDisplay;
    cell.msg.text = [diary objectForKey:@"message"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144.0;
}
@end
