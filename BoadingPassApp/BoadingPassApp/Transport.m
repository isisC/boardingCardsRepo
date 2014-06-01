//
//  Transport.m
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import "Transport.h"


@implementation Transport

@dynamic szName;
@dynamic boardingPass;

+ (instancetype)transportFromName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)ctxt{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	request.entity = [NSEntityDescription entityForName:@"Transport" inManagedObjectContext:ctxt];
    request.predicate = [NSPredicate predicateWithFormat:@"szName = %@",[name uppercaseString]];
    
    NSError *error = nil;
    Transport *transport = [[ctxt executeFetchRequest:request error:&error] lastObject];
    
    if (!error && !transport) {
		transport = [NSEntityDescription insertNewObjectForEntityForName:@"Transport" inManagedObjectContext:ctxt];
        transport.szName = [name uppercaseString];
    }
    
    return transport;
}

@end
