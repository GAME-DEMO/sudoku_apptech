//
//  SudokuCubeView.m
//  sudoku_apptech
//
//  Created by Wang.Peng on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuCubeView.h"
#import "Presenter.h"
#import "UIUtils.h"

@interface SudokuCubeView ()

@property (nonatomic, strong) UIView *cubeValueView;
@property (nonatomic, strong) UIView *cubeGuessBackgroundView;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *cubeGuessImageViewArray;
@property (nonatomic, strong) UIImageView *cubeShineImageView;

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

- (void)setShowGuess:(BOOL)showGuess {
    _showGuess = showGuess;
    if (showGuess) {
        self.cubeValueView.hidden = YES;
        self.cubeGuessBackgroundView.hidden = NO;
    } else {
        self.cubeValueView.hidden = NO;
        self.cubeGuessBackgroundView.hidden = YES;
    }
}

- (void)commonInit {
    self.cubeValueView = [[UIView alloc] init];
    self.cubeValueView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cubeValueView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.cubeValueView];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeValueView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeValueView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeValueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeValueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.8 constant:0.0]];
    
    self.cubeGuessBackgroundView = [[UIView alloc] init];
    self.cubeGuessBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cubeGuessBackgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.cubeGuessBackgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[cubeGuessBackgroundView]-0-|" options:0 metrics:nil views:@{@"cubeGuessBackgroundView":self.cubeGuessBackgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cubeGuessBackgroundView]-0-|" options:0 metrics:nil views:@{@"cubeGuessBackgroundView":self.cubeGuessBackgroundView}]];
    
    self.cubeGuessImageViewArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].dimension];
    for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
        UIImageView *guessImageView = [[UIImageView alloc] init];
        guessImageView.translatesAutoresizingMaskIntoConstraints = NO;
        guessImageView.contentMode = UIViewContentModeScaleAspectFit;
        guessImageView.backgroundColor = [UIColor clearColor];
        [self.cubeGuessBackgroundView addSubview:guessImageView];
        [self.cubeGuessImageViewArray addObject:guessImageView];
    }
    
    for (int row = 0; row < [Presenter sharedInstance].eachCount; ++row) {
        for (int col = 0; col < [Presenter sharedInstance].eachCount; ++col) {
            UIImageView *curImageView = [self.cubeGuessImageViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row withLocalCol:col]];
            
            // Leading
            if (col == 0) {
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
            } else {
                UIImageView *leadingImageView = [self.cubeGuessImageViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row withLocalCol:col - 1]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:leadingImageView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
            }
            
            // Trailing
            if (col == [Presenter sharedInstance].eachCount - 1) {
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
            }
            
            // Width
            if (col > 0) {
                UIImageView *previousImageView = [self.cubeGuessImageViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row withLocalCol:col - 1]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:previousImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
            }
            
            // Bottom
            if (row == 0) {
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
            } else {
                UIImageView *bottomImageView = [self.cubeGuessImageViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row - 1 withLocalCol:col]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
            }
            
            // Top
            if (row == [Presenter sharedInstance].eachCount - 1) {
               [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
            }
            
            // Height
            if (row > 0) {
                UIImageView *previousImageView = [self.cubeGuessImageViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row - 1 withLocalCol:col]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:previousImageView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
            }
        }
    }

    self.cubeShineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cube_light"]];
    self.cubeShineImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.cubeShineImageView];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:-9.5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-9.5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:9.5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:9.5]];
    
    self.showGuess = NO;
    self.clipsToBounds = NO;
}

- (void)setCubeValue:(int)cubeValue {
    if (cubeValue > 0 && cubeValue <= [Presenter sharedInstance].dimension) {
        [UIUtils updateNumber:cubeValue withTintColor:nil onView:self.cubeValueView];
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.cubeShineImageView.hidden = !selected;
}

@end
