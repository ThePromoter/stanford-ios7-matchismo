//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Dan Pinciotti on 7/20/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

+ (NSUInteger)mismatchPenalty;
+ (NSUInteger)matchBonus;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSMutableArray *previouslyChosenCards;
@property (nonatomic) NSInteger matchCount;

@end
