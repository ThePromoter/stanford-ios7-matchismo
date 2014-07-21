//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Dan Pinciotti on 7/21/14.
//  Copyright (c) 2014 Dan Pinciotti. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    NSMutableAttributedString *totalHistory = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *history in self.historyItems) {
        [totalHistory appendAttributedString:history];
        [totalHistory appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    self.historyTextView.attributedText = totalHistory;
}

@end
