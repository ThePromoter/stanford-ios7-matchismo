//
//  MatchCard.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "MatchCard.h"

@implementation MatchCard

+ (NSArray *)validSymbols {
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validOpacities {
    return @[@.3,@.6,@1];
}

+ (NSArray *)validColors {
    return @[@"red",@"green",@"purple"];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    //TODO score calculation
    
    return score;
}

// Override the contents getter
- (NSString *)contents {
    return nil;
}


@end
