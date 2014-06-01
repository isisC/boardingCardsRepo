//
//  BoardingCard.m
//  BoadingPassApp
//
//  Created by Noemi Quintanal on 01/06/2014.
//  Copyright (c) 2014 NoemiQuintanal. All rights reserved.
//

#import "BoardingCard.h"
#import "City.h"
#import "Transport.h"


#define EN_BOARDINGCARD @"BoardingCard"

@implementation BoardingCard

@dynamic extraInfo;
@dynamic from;
@dynamic to;
@dynamic transport;


+(NSString*)entityName{
    return EN_BOARDINGCARD;
}


@end
