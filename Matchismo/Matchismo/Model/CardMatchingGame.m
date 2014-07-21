//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/20/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "CardMatchingGame.h"
#import "SetCard.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSArray *previouslyChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;
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

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
- (void)chooseCardAtIndex:(NSUInteger)index {
    self.lastScore = 0;
    
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            // We have to remove this card from the previously chosen card array
            NSMutableArray *previousCards = [[NSMutableArray alloc] initWithArray:[self.previouslyChosenCards copy]];
            [previousCards removeObject:card];
            self.previouslyChosenCards = previousCards;
        } else {
            // build a quick array of all of the chosen and unmatched cards
            NSMutableArray *potentialMatches = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [potentialMatches addObject:otherCard];
                }
            }
            
            self.previouslyChosenCards = [potentialMatches arrayByAddingObject:card];
            
            // Only attempt matching logic if the number of selected cards equals the matchCount
            if ([potentialMatches count] == self.matchCount - 1) {
                int matchScore = [card match:potentialMatches];
                if (matchScore > 0) {
                    self.lastScore = matchScore * MATCH_BONUS;
                    
                    // Update the relevent cards as matched
                    card.matched = YES;
                    for (Card *otherCard in potentialMatches) {
                        otherCard.matched = YES;
                    }
                } else {
                    // No matches
                    self.lastScore = -MISMATCH_PENALTY;
                    
                    card.chosen = NO;
                    for (Card *otherCard in potentialMatches) {
                        otherCard.chosen = NO;
                    }
                }
            }
            
            if (![card isKindOfClass:[SetCard class]]) {
            	// Only penalize for a reveal if the cards aren't revealed to begin with
            	self.score -= COST_TO_CHOOSE;
            }
            self.score += self.lastScore;
            card.chosen = YES;
        }
    }
}

- (NSArray *)previouslyChosenCards {
    if (!_previouslyChosenCards) _previouslyChosenCards = [[NSArray alloc] init];
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
