//
//  MainViewController.h
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import "FlipsideViewController.h"

#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnSortBoardingPass;
@property (weak, nonatomic) IBOutlet UILabel *lblSortingMessage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
@end
