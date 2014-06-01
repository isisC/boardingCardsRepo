//
//  Transport.h
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Transport : NSManagedObject

@property (nonatomic, retain) NSString * szName;
@property (nonatomic, retain) NSSet *boardingPass;
@end

@interface Transport (CoreDataGeneratedAccessors)

- (void)addBoardingPassObject:(NSManagedObject *)value;
- (void)removeBoardingPassObject:(NSManagedObject *)value;
- (void)addBoardingPass:(NSSet *)values;
- (void)removeBoardingPass:(NSSet *)values;

+ (instancetype)transportFromName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)ctxt;

@end
