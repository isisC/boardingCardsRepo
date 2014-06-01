//
//  BoardingCard.h
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Transport;

@interface BoardingCard : NSManagedObject

@property (nonatomic, retain) NSString * extraInfo;
@property (nonatomic, retain) City *from;
@property (nonatomic, retain) City *to;
@property (nonatomic, retain) Transport *transport;

+(NSString*)entityName;

@end
