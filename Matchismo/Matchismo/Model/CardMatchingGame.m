//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/20/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "CardMatchingGame.h"
#import "MatchCard.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSMutableArray *previouslyChosenCards;
@property (nonatomic, strong) NSMutableArray *cards; // of cards
@end

@implementation CardMatchingGame

- (instancetype)init {
    return nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

+ (NSUInteger)mismatchPenalty {
    return MISMATCH_PENALTY;
}

+ (NSUInteger)matchBonus {
    return MATCH_BONUS;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.previouslyChosenCards removeObject:card];
        } else {
            // build a quick array of all of the chosen and unmatched cards
            NSMutableArray *potentialMatches = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [potentialMatches addObject:otherCard];
                }
            }
            
            [self.previouslyChosenCards removeAllObjects];
            [self.previouslyChosenCards addObjectsFromArray:potentialMatches];
            [self.previouslyChosenCards addObject:card];
            
            // Only attempt matching logic if the number of selected cards equals the matchCount
            if ([potentialMatches count] == self.matchCount - 1) {
                int matchScore = [card match:potentialMatches];
                if (matchScore > 0) {
                    self.score += matchScore * MATCH_BONUS;
                    
                    // Update the relevent cards as matched
                    card.matched = YES;
                    for (Card *otherCard in potentialMatches) {
                        otherCard.matched = YES;
                    }
                } else {
                    // No matches
                    self.score -= MISMATCH_PENALTY;
                    card.chosen = NO;
                    for (Card *otherCard in potentialMatches) {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            if (![card isKindOfClass:[MatchCard class]]) {
                // Only penalize for a reveal if the cards aren't revealed to begin with
                self.score -= COST_TO_CHOOSE;
            }
            card.chosen = YES;
        }
    }
}

- (NSMutableArray *)previouslyChosenCards {
    if (!_previouslyChosenCards) _previouslyChosenCards = [[NSMutableArray alloc] init];
    return _previouslyChosenCards;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSInteger)matchCount {
    // Must have at least 2 for matching
    return _matchCount >= 2 ? _matchCount : 2;
}

@end
