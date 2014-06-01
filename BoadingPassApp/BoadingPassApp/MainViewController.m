//
//  MainViewController.m
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import "MainViewController.h"
#import "BoardingCard.h"
#import "Transport.h"
#import "City.h"

#define SECTIONS_NUMBER 1


@interface MainViewController ()

@property (nonatomic, strong) NSFetchedResultsController *boardingCardsList;
@property (nonatomic, strong) NSArray* listOfSortedBoardingCards;

@end

@implementation MainViewController

-(NSFetchedResultsController*)boardingCardsList{
    if (!_boardingCardsList) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        request.entity = [NSEntityDescription entityForName:[BoardingCard entityName] inManagedObjectContext:self.managedObjectContext];
        request.fetchBatchSize = 20;
        
        
        //NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"from.szName" ascending:NO];
        //NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:dateDescriptor,nil];
        //[request setSortDescriptors:sortDescriptors];
     
        
        request.sortDescriptors = [[NSArray alloc] initWithObjects:[[NSSortDescriptor alloc] initWithKey:@"from.szName" ascending:NO],nil];
        _boardingCardsList = [[NSFetchedResultsController alloc]
                             initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    return _boardingCardsList;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load all the data
   
   
    // process all the data
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSError *error = nil;
    [self.boardingCardsList performFetch:&error];
    [self.tableView reloadData];
    self.tableView.hidden = NO;
    [self.loadingSpinner stopAnimating];
    self.loadingSpinner.hidden = YES;
    self.lblSortingMessage.hidden = YES;
    self.btnSortBoardingPass.enabled = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        [[segue destinationViewController] setListOfSortedBoardingPass:self.listOfSortedBoardingCards];
    }
}


#pragma mark - Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return SECTIONS_NUMBER;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"rows %d",[[self.boardingCardsList fetchedObjects] count]);
    return [[self.boardingCardsList fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *ReuseIdentifier = @"BoardingCardCell";
    BoardingCard *boardingCard = [[self.boardingCardsList fetchedObjects]objectAtIndex:indexPath.row];
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


-(IBAction)startSorting:(id)sender{
    self.btnSortBoardingPass.enabled = NO;
    [self sortingHasStarted];
    
    
}


-(void)sortingHasStarted{
    self.loadingSpinner.hidden = NO;
    [self.loadingSpinner startAnimating];
    self.lblSortingMessage.hidden = NO;
    self.tableView.hidden = YES;
    
    [self sortBoardingCards];

}


-(void)sortBoardingCards{
    NSMutableDictionary *listOfOrigins = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *listOfDestinations = [[NSMutableDictionary alloc]init];
    
    [[self.boardingCardsList fetchedObjects] enumerateObjectsUsingBlock:^(BoardingCard* boardingCard, NSUInteger idx, BOOL *stop) {
        [listOfOrigins setObject:boardingCard forKey:boardingCard.from.szName];
        [listOfDestinations setObject:boardingCard forKey:boardingCard.to.szName];
    }];

    NSMutableSet *originsKeys = [[NSSet setWithArray:[listOfOrigins allKeys]]mutableCopy];
    NSMutableSet *destinationsKeys = [[NSSet setWithArray:[listOfDestinations allKeys]]mutableCopy];
    NSString *origin;
    for (NSString* originKey in originsKeys){
        if (![destinationsKeys containsObject:originKey]) {
            origin = originKey;
            break;
        }
    }
    NSLog(@"origin %@", origin);

    
    NSMutableArray * newListOfBoardingPass = [[NSMutableArray alloc]init];
    BoardingCard *prevObj = [listOfOrigins objectForKey:origin];
    [newListOfBoardingPass addObject:prevObj];
    
    for (int i=1; i<[[listOfOrigins allKeys]count]; i++){
        prevObj = [listOfOrigins objectForKey:prevObj.to.szName];
        [newListOfBoardingPass addObject:prevObj];
    }
    
    [self showNewList:newListOfBoardingPass];
    self.listOfSortedBoardingCards = newListOfBoardingPass;
    [self performSelector:@selector(loadSorted) withObject:self afterDelay:3];

}

-(void)loadSorted{
    [self performSegueWithIdentifier:@"showAlternate" sender:self];


}
-(void)showNewList:(NSMutableArray*)list{
    for (BoardingCard *bc in list){
        NSLog(@"%@ From: %@ To: %@",bc.transport.szName,bc.from.szName,bc.to.szName);
    }
}

@end
