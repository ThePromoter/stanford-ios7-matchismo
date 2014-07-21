//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Dan Pinciotti on 7/18/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//
// abstract class. Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Model/Deck.h"

@interface CardGameViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck; // abstract

- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;

@property (nonatomic) NSUInteger matchCount;

@end
