//
//  City.m
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import "City.h"
#import "BoardingCard.h"

#define ENTITY_NAME @"City"

@implementation City

@dynamic szName;
@dynamic szCurrency;
@dynamic szMainLanguage;
@dynamic from;
@dynamic to;


+ (instancetype)cityFromName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)ctxt{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"City" inManagedObjectContext:ctxt];
    request.predicate = [NSPredicate predicateWithFormat:@"szName = %@",[name uppercaseString]];
    
    NSError *error = nil;
    City *city = [[ctxt executeFetchRequest:request error:&error] lastObject];
    
    if (!error && !city) {
		city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:ctxt];
        city.szName = [name uppercaseString];
    }

    return city;
}


@end
