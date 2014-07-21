//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/18/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "CardGameViewController.h"
#import "Model/PlayingCardDeck.h"
#import "Model/CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMatchResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSegment;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void) updateGameMatchCount {
    self.game.matchCount = self.matchModeSegment.selectedSegmentIndex + 2;
}

- (IBAction)matchModeChanged:(UISegmentedControl *)sender {
    [self updateGameMatchCount];
}

- (IBAction)startNewGame:(UIButton *)sender {
    self.matchModeSegment.enabled = YES;
    self.game = nil;
    [self updateGameMatchCount];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    // Since the game has 'started', disable the match mode control
    self.matchModeSegment.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastMatchResultLabel.text = [self generateResultText];
}

- (NSString *)cardContentsAsString:(NSMutableArray *)cards {
    NSString *resultString = [[NSString alloc] init];
    for (Card *card in cards) {
        resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@ ", card.contents]];
    }
    return resultString;
}

- (NSString *)generateResultText {
    NSMutableArray *chosenCards = self.game.previouslyChosenCards;
    if ([chosenCards count] == self.game.matchCount) {
        // A matching event occured, display the results
        int pointValue = [[chosenCards firstObject] match:[chosenCards objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, [chosenCards count] - 1)]]];
        if (pointValue > 0) {
            return [NSString stringWithFormat:@"Matched %@ for %d %@!", [self cardContentsAsString:self.game.previouslyChosenCards], pointValue * [CardMatchingGame matchBonus], pointValue * [CardMatchingGame matchBonus] == 1 ? @"point" : @"points"];
        } else {
            return [NSString stringWithFormat:@"%@ don't match!%d point penalty!", [self cardContentsAsString:self.game.previouslyChosenCards], [CardMatchingGame mismatchPenalty]];
        }
    } else {
        // No matching event occured, simply display the currently selected cards
        return [self cardContentsAsString:self.game.previouslyChosenCards];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
