//
//  MatchCardGameViewController.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "Model/SetCardDeck.h"
#import "Model/SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSUInteger)matchCount {
    return 3;
}

- (NSAttributedString *)titleForCard:(SetCard *)card {
    NSString *symbol = @"?"; // default string if the symbol is invalid
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        if ([setCard.symbol isEqualToString:@"oval"]) symbol = @"●";
        if ([setCard.symbol isEqualToString:@"squiggle"]) symbol = @"▲";
        if ([setCard.symbol isEqualToString:@"diamond"]) symbol = @"■";
        symbol = [symbol stringByPaddingToLength:setCard.number withString:symbol startingAtIndex:0];
        
        // Now for the color attribute
        if ([setCard.color isEqualToString:@"red"]) {
            [attributes setObject:[UIColor redColor]
                           forKey:NSForegroundColorAttributeName];
        } else if ([setCard.color isEqualToString:@"green"]) {
            [attributes setObject:[UIColor greenColor]
                           forKey:NSForegroundColorAttributeName];
        } else if ([setCard.color isEqualToString:@"purple"]) {
            [attributes setObject:[UIColor purpleColor]
                           forKey:NSForegroundColorAttributeName];
        }
        
        // Have to consider the shading
        if ([setCard.shading isEqualToString:@"solid"]) {
            [attributes setObject:@-5
                           forKey:NSStrokeWidthAttributeName];
        } else if ([setCard.shading isEqualToString:@"open"]) {
            [attributes addEntriesFromDictionary:@{ NSStrokeWidthAttributeName: @5,
                                                    NSStrokeColorAttributeName: attributes[NSForegroundColorAttributeName] }];
        } else if ([setCard.shading isEqualToString:@"striped"]) {
            [attributes addEntriesFromDictionary:@{ NSStrokeWidthAttributeName: @-5,
                                                    NSStrokeColorAttributeName: attributes[NSForegroundColorAttributeName],
                                                    NSForegroundColorAttributeName: [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1] }];
        }
    }
    
    return [[NSAttributedString alloc] initWithString:symbol attributes:attributes];
}

- (NSAttributedString *)cardContentsAsString:(NSArray *)cards {
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] init];
    for (Card *card in cards) {
        [resultString appendAttributedString:[self titleForCard:card]];
    }
    return resultString;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"setCardSelected" : @"setCard"];
}

@end
