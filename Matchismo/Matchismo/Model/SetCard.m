//
//  MatchCard.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validSymbols {
    return @[@"oval",@"squiggle",@"diamond"];
}

+ (NSArray *)validShades {
    return @[@"solid",@"open",@"striped"];
}

+ (NSArray *)validColors {
    return @[@"red",@"green",@"purple"];
}

+ (NSInteger)maxNumber {
    return 3;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == self.numberOfMatchingCards - 1) {
        NSMutableSet *usedSymbols = [[NSMutableSet alloc] init];
        NSMutableSet *usedShades = [[NSMutableSet alloc] init];
        NSMutableSet *usedColors = [[NSMutableSet alloc] init];
        NSMutableSet *usedNumbers = [[NSMutableSet alloc] init];
        [usedSymbols addObject:self.symbol];
        [usedShades addObject:self.shading];
        [usedColors addObject:self.color];
        [usedNumbers addObject:@(self.number)];
        
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                [usedSymbols addObject:otherSetCard.symbol];
                [usedShades addObject:otherSetCard.shading];
                [usedColors addObject:otherSetCard.color];
                [usedNumbers addObject:@(otherSetCard.number)];
                
                if (([usedSymbols count] == 1 || [usedSymbols count] == self.numberOfMatchingCards) &&
                    ([usedShades count] == 1 || [usedShades count] == self.numberOfMatchingCards) &&
                    ([usedColors count] == 1 || [usedColors count] == self.numberOfMatchingCards) &&
                    ([usedNumbers count] == 1 || [usedNumbers count] == self.numberOfMatchingCards)) {
                    score = 4;
                }
            }
        }
    }
    
    return score;
}

// Override the contents getter
@synthesize symbol = _symbol, shading = _shading, color = _color;

- (NSUInteger)numberOfMatchingCards {
    return 3;
}

- (NSString *)contents {
    return nil;
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading {
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShades] containsObject:shading]) _shading = shading;
}

- (NSString *)color {
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (void)setNumber:(NSInteger)number {
    if (number <= [SetCard maxNumber]) _number = number;
}

@end
