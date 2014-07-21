//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/18/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "CardGameViewController.h"
#import "Model/CardMatchingGame.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) NSMutableArray *resultItems;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMatchResultLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    _game.matchCount = self.matchCount;
    return _game;
}

// abstract
- (Deck *)createDeck {
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowHistory"]) {
        HistoryViewController *historyVS = segue.destinationViewController;
        historyVS.historyItems = self.resultItems;
    }
}

- (IBAction)startNewGame:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastMatchResultLabel.attributedText = [self generateResultText];
}

- (NSAttributedString *)cardContentsAsString:(NSArray *)cards {
    NSString *resultString = [[NSString alloc] init];
    for (Card *card in cards) {
        resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"%@ ", card.contents]];
    }
    return [[NSAttributedString alloc] initWithString:resultString];
}

- (NSAttributedString *)generateResultText {
    NSArray *chosenCards = self.game.previouslyChosenCards;
    NSAttributedString *resultText = [[NSAttributedString alloc] init];
    if ([chosenCards count] == self.game.matchCount) {
        // A matching event occured, display the results
        int pointValue = self.game.lastScore;
        if (pointValue > 0) {
            NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            NSAttributedString *cardContents = [self cardContentsAsString:self.game.previouslyChosenCards];
            [result appendAttributedString:cardContents];
            [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points", pointValue]]];
            resultText = result;
        } else {
            NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
            NSAttributedString *cardContents = [self cardContentsAsString:self.game.previouslyChosenCards];
            [result appendAttributedString:cardContents];
            [result appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %d point penalty", pointValue]]];
            resultText = result;
        }
        
        [self.resultItems addObject:resultText];
    } else {
        // No matching event occured, simply display the currently selected cards
        resultText = [self cardContentsAsString:self.game.previouslyChosenCards];
    }
    
    return resultText;
}

- (NSAttributedString *)titleForCard:(Card *)card {
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.isChosen ? card.contents : @""];
    return title;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSMutableArray *)resultItems {
    if (!_resultItems) _resultItems = [[NSMutableArray alloc] init];
    return _resultItems;
}

@end
