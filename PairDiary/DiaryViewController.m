//
//  DiaryViewController.m
//  PairDiary
//
//  Created by Liu Zenan on 15/2/14.
//  Copyright (c) 2014 li.shaohuan. All rights reserved.
//

#import "DiaryViewController.h"
#import "DataUtil.h"
#import "DiaryTopCell.h"
#import "DiaryDayCell.h"
#import "StatisticsController.h"

@interface DiaryViewController ()

@end

@implementation DiaryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

        [StatisticsController totalMessageCount:self.pairId handler:
         ^(NSInteger totalMessages){
              [cell.totalMsg setText: [NSString stringWithFormat:@"%d",totalMessages]];
         }];
       
        [StatisticsController todayMessageCount:self.pairId handler:
         ^(NSInteger todayMessages){
             [cell.todayMsg setText: [NSString stringWithFormat:@"%d",todayMessages]];
         }];

        [StatisticsController totalPhotos:self.pairId handler:
         ^(NSInteger totalPhotos){
             [cell.numPhotos setText: [NSString stringWithFormat:@"%d",totalPhotos]];
         }];
        
        [StatisticsController totalDate:self.pairId handler:^(NSInteger totalDates){
            [cell.numDays setText:[NSString stringWithFormat:@"%d", totalDates]];
        }];
        
        [StatisticsController totalSavedMessage:self.pairId handler:^(NSInteger totalSavedMessage){
            [cell.numOfMsgInDiary setText:[NSString stringWithFormat:@"%d", totalSavedMessage]];
        }];
        return cell;
    } else {
        static NSString *CellIdentifier = @"DiaryDayCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
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
