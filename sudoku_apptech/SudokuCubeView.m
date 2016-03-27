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
#import "SudokuUINumber.h"

@interface SudokuCubeView ()

@property (nonatomic, strong) NSMutableArray *cubeGuessArray;
@property (nonatomic, strong) UIView *cubeValueView;
@property (nonatomic, strong) UIView *cubeGuessBackgroundView;
@property (nonatomic, strong) NSMutableArray<UIView *> *cubeGuessViewArray;
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
    self.cubeGuessBackgroundView.hidden = YES;
    [self addSubview:self.cubeGuessBackgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[cubeGuessBackgroundView]-0-|" options:0 metrics:nil views:@{@"cubeGuessBackgroundView":self.cubeGuessBackgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[cubeGuessBackgroundView]-0-|" options:0 metrics:nil views:@{@"cubeGuessBackgroundView":self.cubeGuessBackgroundView}]];
    
    self.cubeGuessViewArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].dimension];
    for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
        UIView *guessView = [[UIImageView alloc] init];
        guessView.translatesAutoresizingMaskIntoConstraints = NO;
        guessView.contentMode = UIViewContentModeScaleAspectFit;
        guessView.backgroundColor = [UIColor clearColor];
        [self.cubeGuessBackgroundView addSubview:guessView];
        [self.cubeGuessViewArray addObject:guessView];
    }
    
    for (int row = 0; row < [Presenter sharedInstance].eachCount; ++row) {
        for (int col = 0; col < [Presenter sharedInstance].eachCount; ++col) {
            UIView *curGuessView = [self.cubeGuessViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row withLocalCol:col]];
            
            // Leading
            if (col == 0) {
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
            } else {
                UIView *leadingGuessView = [self.cubeGuessViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row withLocalCol:col - 1]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:leadingGuessView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
            }
            
            // Trailing
            if (col == [Presenter sharedInstance].eachCount - 1) {
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
            }
            
            // Width
            if (col > 0) {
                UIView *previousGuessView = [self.cubeGuessViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row withLocalCol:col - 1]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:previousGuessView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
            }
            
            // Bottom
            if (row == 0) {
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
            } else {
                UIView *bottomGuessView = [self.cubeGuessViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row - 1 withLocalCol:col]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:bottomGuessView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
            }
            
            // Top
            if (row == [Presenter sharedInstance].eachCount - 1) {
               [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.cubeGuessBackgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
            }
            
            // Height
            if (row > 0) {
                UIView *previousGuessView = [self.cubeGuessViewArray objectAtIndex:[[Presenter sharedInstance] localIndexFromLocalRow:row - 1 withLocalCol:col]];
                [self.cubeGuessBackgroundView addConstraint:[NSLayoutConstraint constraintWithItem:curGuessView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:previousGuessView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
            }
        }
    }

    self.cubeShineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cube_light"]];
    self.cubeShineImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.cubeShineImageView];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:-3.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-3.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:3.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.cubeShineImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3.0]];

    self.clipsToBounds = NO;
    self.guessMode = NO;
    self.cubeGuessArray = [NSMutableArray array];
    for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
        [self.cubeGuessArray addObject:[NSNull null]];
    }
}

- (void)setCubeValue:(SudokuUINumber *)cubeValue {
    _cubeValue = cubeValue;
    int number = cubeValue.number;
    
    if ([[Presenter sharedInstance] isInDemension:number]) {
        [UIUtils updateValue:self.cubeValue onValueView:self.cubeValueView];
    } else {
        [UIUtils removeValueOnValueView:self.cubeValueView];
    }
}

- (UIView *)getCubeGuessView:(int)guessValue {
    if (guessValue <= 0 || guessValue > [Presenter sharedInstance].dimension) {
        return nil;
    }
    
    int guessIndex = guessValue - 1;
    int row = [Presenter sharedInstance].eachCount - 1 - guessIndex / [Presenter sharedInstance].eachCount;
    int col = guessIndex % [Presenter sharedInstance].eachCount;
    guessIndex = row * [Presenter sharedInstance].eachCount + col;
    
    return [self.cubeGuessViewArray objectAtIndex:guessIndex];
}

- (void)setGuess:(SudokuUINumber *)guess {
    int number = guess.number;
    if ([[Presenter sharedInstance] isInDemension:number]) {
        [self.cubeGuessArray replaceObjectAtIndex:number - 1 withObject:guess];
        
        UIView *guessView = [self getCubeGuessView:number];
        if (guessView) {
            [UIUtils updateValue:guess onValueView:guessView];
        }
    }
}

- (void)removeGuessValue:(int)guessValue {
    if ([[Presenter sharedInstance] isInDemension:guessValue]) {
        [self.cubeGuessArray replaceObjectAtIndex:guessValue - 1 withObject:[NSNull null]];
        
        UIView *guessView = [self getCubeGuessView:guessValue];
        if (guessView) {
            [UIUtils removeValueOnValueView:guessView];
        }
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.cubeShineImageView.hidden = !selected;
}

- (void)setGuessMode:(BOOL)guessMode {
    _guessMode = guessMode;
    
    self.cubeGuessBackgroundView.hidden = !guessMode;
    self.cubeValueView.hidden = guessMode;
}

@end
