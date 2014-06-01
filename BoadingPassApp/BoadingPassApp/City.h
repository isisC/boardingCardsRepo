//
//  City.h
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BoardingCard;

@interface City : NSManagedObject


@property (nonatomic, retain) NSString * szName;
@property (nonatomic, retain) NSString * szCurrency;
@property (nonatomic, retain) NSString * szMainLanguage;
@property (nonatomic, retain) NSSet *from;
@property (nonatomic, retain) NSSet *to;


@end

@interface City (CoreDataGeneratedAccessors)

- (void)addFromObject:(BoardingCard *)value;
- (void)removeFromObject:(BoardingCard *)value;
- (void)addFrom:(NSSet *)values;
- (void)removeFrom:(NSSet *)values;

- (void)addToObject:(BoardingCard *)value;
- (void)removeToObject:(BoardingCard *)value;
- (void)addTo:(NSSet *)values;
- (void)removeTo:(NSSet *)values;


+ (instancetype)cityFromName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)ctxt;

@end
