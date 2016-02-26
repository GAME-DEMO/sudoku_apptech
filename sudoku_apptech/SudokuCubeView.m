//
//  SudokuCubeView.m
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuCubeView.h"
#import "Presenter.h"

@interface SudokuCubeView ()

@property (nonatomic, strong) UIImageView *valueImageView;
@property (nonatomic, strong) UIView *guessBackgroundView;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *guessImageViewArray;

@end


@implementation SudokuCubeView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.valueImageView = [[UIImageView alloc] init];
    self.valueImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.valueImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.valueImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.valueImageView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[valueImageView]-0-|" options:0 metrics:nil views:@{@"valueImageView":self.valueImageView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[valueImageView]-0-|" options:0 metrics:nil views:@{@"valueImageView":self.valueImageView}]];
    
    self.guessBackgroundView = [[UIView alloc] init];
    self.guessBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.guessBackgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.guessBackgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[guessBackgroundView]-0-|" options:0 metrics:nil views:@{@"guessBackgroundView":self.guessBackgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[guessBackgroundView]-0-|" options:0 metrics:nil views:@{@"guessBackgroundView":self.guessBackgroundView}]];
    
    self.guessImageViewArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].dimension];
    for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
        UIImageView *guessImageView = [[UIImageView alloc] init];
        guessImageView.translatesAutoresizingMaskIntoConstraints = NO;
        guessImageView.contentMode = UIViewContentModeScaleAspectFit;
        guessImageView.backgroundColor = [UIColor clearColor];
        [self.guessBackgroundView addSubview:guessImageView];
        [self.guessImageViewArray addObject:guessImageView];
    }
    
    for (int row = 0; row < [Presenter sharedInstance].eachCount; ++row) {
        for (int col = 0; col < [Presenter sharedInstance].eachCount; ++col) {
            UIImageView *curImageView = [self.guessImageViewArray objectAtIndex:[[Presenter sharedInstance] indexFromRow:row withCol:col]];
            
            // Leading
            if (col == 0) {
                [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.guessBackgroundView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
            } else {
                UIImageView *leadingImageView = [self.guessImageViewArray objectAtIndex:[[Presenter sharedInstance] indexFromRow:row withCol:col - 1]];
                [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:leadingImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
            }
            
            // Trailing
            if (col == [Presenter sharedInstance].eachCount - 1) {
                [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.guessBackgroundView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
            }
            
            // Width
            if (col > 0) {
                UIImageView *previousImageView = [self.guessImageViewArray objectAtIndex:[[Presenter sharedInstance] indexFromRow:row withCol:col - 1]];
                [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:previousImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
            }
            
            // Bottom
            if (row == 0) {
                [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.guessBackgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
            } else {
                UIImageView *bottomImageView = [self.guessImageViewArray objectAtIndex:[[Presenter sharedInstance] indexFromRow:row - 1 withCol:col]];
                [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
            }
            
            // Top
            if (row == [Presenter sharedInstance].eachCount - 1) {
               [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.guessBackgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
            }
            
            // Height
            if (row > 0) {
                UIImageView *previousImageView = [self.guessImageViewArray objectAtIndex:[[Presenter sharedInstance] indexFromRow:row - 1 withCol:col]];
                [self.guessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:previousImageView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
            }
        }
    }
}

@end
