//
//  MatchCard.h
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSInteger number;

+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSInteger)maxNumber;

@end
