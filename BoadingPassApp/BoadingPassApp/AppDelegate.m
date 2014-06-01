//
//  AppDelegate.m
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "BoardingCard.h"
#import "Transport.h"
#import "City.h"


#define BoardingCardConstant @"BoardingCard"
#define TransportConstant @"Transport"
#define CityConstant @"City"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self cleanDatabase];
    [self loadData];
   // [self showDataBaseSnapshot];
    
    MainViewController *controller = (MainViewController *)self.window.rootViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BoadingPassApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BoadingPassApp.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Methods to manage all the data

-(void)loadData{
    NSError *error = nil;;

    BoardingCard *b1 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b1.from = [City cityFromName:@"Santander" inManagedObjectContext:self.managedObjectContext];
    b1.to = [City cityFromName:@"Madrid" inManagedObjectContext:self.managedObjectContext];
    b1.extraInfo = @"Seat 4D";
    b1.transport = [Transport transportFromName:@"Train" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b2 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b2.from = [City cityFromName:@"Madrid" inManagedObjectContext:self.managedObjectContext];
    b2.to = [City cityFromName:@"Gerona" inManagedObjectContext:self.managedObjectContext];
    b2.extraInfo = @"Gate 12 Seat 17D";
    b2.transport = [Transport transportFromName:@"Plane" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b3 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b3.from = [City cityFromName:@"Gerona" inManagedObjectContext:self.managedObjectContext];
    b3.to = [City cityFromName:@"Barcelona" inManagedObjectContext:self.managedObjectContext];
    b3.extraInfo = @"No seat assigned";
    b3.transport = [Transport transportFromName:@"Bus" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b4 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b4.from = [City cityFromName:@"Barcelona" inManagedObjectContext:self.managedObjectContext];
    b4.to = [City cityFromName:@"Paris" inManagedObjectContext:self.managedObjectContext];
    b4.extraInfo = @"Gate 24 Seat 30C";
    b4.transport = [Transport transportFromName:@"Plane" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b5 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b5.from = [City cityFromName:@"Paris" inManagedObjectContext:self.managedObjectContext];
    b5.to = [City cityFromName:@"Brussels" inManagedObjectContext:self.managedObjectContext];
    b5.extraInfo = @"Seat 13F";
    b5.transport = [Transport transportFromName:@"Train" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b6 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b6.from = [City cityFromName:@"Brussels" inManagedObjectContext:self.managedObjectContext];
    b6.to = [City cityFromName:@"Amsterdam" inManagedObjectContext:self.managedObjectContext];
    b6.extraInfo = @"No seat assigned";
    b6.transport = [Transport transportFromName:@"Bus" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b7 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b7.from = [City cityFromName:@"Amsterdam" inManagedObjectContext:self.managedObjectContext];
    b7.to = [City cityFromName:@"London" inManagedObjectContext:self.managedObjectContext];
    b7.extraInfo = @"Gate 89 Seat 40C";
    b7.transport = [Transport transportFromName:@"Plane" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b8 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b8.from = [City cityFromName:@"London" inManagedObjectContext:self.managedObjectContext];
    b8.to = [City cityFromName:@"New York" inManagedObjectContext:self.managedObjectContext];
    b8.extraInfo = @"Gate 30 Seat 31D";
    b8.transport = [Transport transportFromName:@"Plane" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b9 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b9.from = [City cityFromName:@"New York" inManagedObjectContext:self.managedObjectContext];
    b9.to = [City cityFromName:@"Miami" inManagedObjectContext:self.managedObjectContext];
    b9.extraInfo = @"Seat 21R";
    b9.transport = [Transport transportFromName:@"Train" inManagedObjectContext:self.managedObjectContext];
    
    BoardingCard *b10 = [NSEntityDescription insertNewObjectForEntityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    b10.from = [City cityFromName:@"Miami" inManagedObjectContext:self.managedObjectContext];
    b10.to = [City cityFromName:@"San Francisco" inManagedObjectContext:self.managedObjectContext];
    b10.extraInfo = @"Gate 21 Seat 37B";
    b10.transport = [Transport transportFromName:@"Plane" inManagedObjectContext:self.managedObjectContext];

    
    [self.managedObjectContext save:&error];
    
    if (error){
        UIAlertView *errorLoadingData = [[UIAlertView alloc]initWithTitle:@"Error!!!" message:@"Sorry there have been an error loading all the boarding cards" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [errorLoadingData show];
    }
}

/**
 Cleans database before loading all the boarding list
 */
-(void)cleanDatabase{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:BoardingCardConstant inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    NSArray *listOfBoardingPass = [self.managedObjectContext executeFetchRequest:request error:&error];
    for (BoardingCard *bc in listOfBoardingPass){
        [self.managedObjectContext deleteObject:bc];
    }
}

#pragma mark - Methods to log all the database content

/**
 Logs in the console all the current information that is loaded in the database
 */
-(void)showDataBaseSnapshot{
    [self showLogEntity:BoardingCardConstant];
    [self showLogEntity:CityConstant];
    [self showLogEntity:TransportConstant];
}

/**
 Logs in the console an entity
 @param entity that we want to log in the console
 */
-(void)showLogEntity:(NSString*)entityName{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    
    NSError *error = nil;
    NSArray *list = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    for (id a in list){
        if ([entityName isEqualToString:BoardingCardConstant]) {
            [self showBPDetail:(BoardingCard*)a];
        }
        else if ([entityName isEqualToString:CityConstant]){
            [self showCityDetail:(City*)a];
        }
        else if ([entityName isEqualToString:TransportConstant]){
            [self showTransportDetail:(Transport*)a];
        }
    }
}

/**
 Logs the content of a boarding card
 @param boardingCard
 */
-(void)showBPDetail:(BoardingCard*)bp{
    NSLog(@"from %@ to %@ and transport %@, with extraInfo %@\n",bp.from.szName,bp.to.szName,bp.transport.szName,bp.extraInfo);
}

/**
 Logs the content of a city
 @param city
 */
-(void)showCityDetail:(City*)c{
    NSLog(@"City: %@\n",c.szName);
}

/**
 Logs the content of a mean of transport
 @param transport
 */
-(void)showTransportDetail:(Transport*)t{
    NSLog(@"Transport: %@\n",t.szName);
}

@end
