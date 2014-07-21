//
//  MatchCardGameViewController.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "MatchCardGameViewController.h"
#import "Model/MatchCardDeck.h"
#import "Model/MatchCard.h"

@interface MatchCardGameViewController ()

@end

@implementation MatchCardGameViewController

- (Deck *)createDeck {
    return [[MatchCardDeck alloc] init];
}

- (NSUInteger)matchCount {
    return 3;
}

- (NSString *)titleForCard:(MatchCard *)card {
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:card.symbol];
    [title setAttributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }
                   range:NSMakeRange(0, [title length] - 1)];
    return [title string];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:@"cardfront"];
}

@end
