//
//  MatchCard.h
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "Card.h"

@interface MatchCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSNumber *opacity;
@property (strong, nonatomic) NSString *color;

+ (NSArray *)validSymbols;
+ (NSArray *)validOpacities;
+ (NSArray *)validColors;

@end
