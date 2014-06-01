//
//  FlipsideViewController.m
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import "FlipsideViewController.h"
#import "BoardingCard.h"
#import "Transport.h"
#import "City.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"rows %d",[self.listOfSortedBoardingPass count]);
    return [self.listOfSortedBoardingPass count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *ReuseIdentifier = @"BoardingCardCell";
    BoardingCard *boardingCard = [self.listOfSortedBoardingPass objectAtIndex:indexPath.row];
	UITableViewCell *cell =(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
	}
    cell.textLabel.text = [NSString stringWithFormat:@"%@ From: %@ To: %@",boardingCard.transport.szName,boardingCard.from.szName,boardingCard.to.szName];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = boardingCard.extraInfo;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = NO;
	
    return cell;
}



@end
