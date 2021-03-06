//
//  DiaryViewController.m
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "DiaryViewController.h"
#import "ServerController.h"
#import "DiaryTopCell.h"
#import "DiaryDayCell.h"
#import "StatisticsController.h"
#import "DaySummaryViewController.h"
#import "Chat.h"
#import "Diary.h"

@interface DiaryViewController ()

@end

@implementation DiaryViewController

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
    [ServerController getPairDiary:self.pairId handler:^(NSArray * diaries) {
        self.dataList = diaries;
        [self setupDataSource:diaries];
        [self.tableView reloadData];
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) setupDataSource:(NSArray*)sortedDateArray
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = calendar.timeZone;
    [dateFormatter setDateFormat:@"DD MM YYYY"];
    
    NSDictionary *summary;
    for (Diary *diary in sortedDateArray)
    {
        NSString* dateSection = [dateFormatter stringFromDate:diary.date];
        if ([summary objectForKey:dateSection] != nil) {
            NSDictionary *dict = [summary objectForKey:dateSection];
            NSString *count = [dict objectForKey:@"count"];
            [dict setValue: [NSString stringWithFormat:@"%d", (count.intValue+1)] forKey:[dict objectForKey:@"count"]];
            [summary setValue: dict forKey:[summary objectForKey:dateSection]];
        }else{
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"1", @"count", dateSection, @"date",diary.message, @"message", nil];
            [summary setValue: dict forKey:[summary objectForKey:dateSection]];
        }
    }
    NSLog(@"summary%@",summary);
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else {
        return [self.dataList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"DiaryTopCell";
        DiaryTopCell *cell = (DiaryTopCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        [StatisticsController totalChatCount:self.pairId handler:
         ^(NSInteger totalChats){
              [cell.totalMsg setText: [NSString stringWithFormat:@"%ld",(long)totalChats]];
         }];
       
        [StatisticsController todayChatCount:self.pairId handler:
         ^(NSInteger todayChats){
             [cell.todayMsg setText: [NSString stringWithFormat:@"%ld",(long)todayChats]];
         }];

        [StatisticsController totalPhotos:self.pairId handler:
         ^(NSInteger totalPhotos){
             [cell.numPhotos setText: [NSString stringWithFormat:@"%ld",(long)totalPhotos]];
         }];
        
        [StatisticsController totalDate:self.pairId handler:^(NSInteger totalDates){
            [cell.numDays setText:[NSString stringWithFormat:@"%ld", (long)totalDates]];
        }];
        
        [StatisticsController totalDiary:self.pairId handler:^(NSInteger totalDiary){
            [cell.numOfMsgInDiary setText:[NSString stringWithFormat:@"%ld", (long)totalDiary]];
        }];
        return cell;
    } else {
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

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 290.0;
    } else {
        return 144.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
    }else{
        Diary* diary = [self.dataList objectAtIndex:indexPath.row];
        DaySummaryViewController *dsvc = [[DaySummaryViewController alloc] init];
        dsvc.pairId = diary.pairId;
        dsvc.date = diary.date;
        [self.navigationController pushViewController:dsvc animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
