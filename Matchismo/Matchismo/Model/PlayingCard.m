//
//  PlayingCard.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/20/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}
+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    NSMutableArray *usedSuits = [[NSMutableArray alloc] init];
    NSMutableArray *usedRanks = [[NSMutableArray alloc] init];
    [usedSuits addObject:self.suit];
    [usedRanks addObject:@(self.rank)];
    int matchingSuitCount = 0;
    int matchingRankCount = 0;
    
    for (PlayingCard *otherCard in otherCards) {
        // See if this card's suit is already used
        if ([usedSuits containsObject:otherCard.suit]) {
            matchingSuitCount++;
        } else {
            // It does not, add it to the array
            [usedSuits addObject:otherCard.suit];
        }
        
        // See if this card's rank is already used
        if ([usedRanks containsObject:@(otherCard.rank)]) {
            matchingRankCount++;
        } else {
            // It does not, add it to the array
            [usedRanks addObject:@(otherCard.rank)];
        }
    }
    
    if (matchingSuitCount) {
        score += pow(2, matchingSuitCount - 1);
    }
    
    if (matchingRankCount) {
        score += pow(2, matchingRankCount);
    }
    
    return score;
}

// Override the contents getter
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setRank:(NSUInteger)rank {
    if(rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@synthesize suit = _suit;
- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *)suit {
    return _suit ? _suit : @"?";
}

@end
