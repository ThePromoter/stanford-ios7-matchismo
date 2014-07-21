//
//  MatchCardDeck.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "MatchCardDeck.h"
#import "MatchCard.h"

@implementation MatchCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [MatchCard validSymbols]) {
            for (NSString *color in [MatchCard validColors]) {
                for (NSNumber *opacity in [MatchCard validOpacities]) {
                    MatchCard *card = [[MatchCard alloc] init];
                    card.symbol = symbol;
                    card.color = color;
                    card.opacity = opacity;
                    [self addCard:card];
                }
            }
        }
    }
    
    return self;
}

@end
