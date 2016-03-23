//
//  NumberCollectionViewCell.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "NumberCollectionViewCell.h"
#import "Presenter.h"
#import "ColorCollectionViewCell.h"
#import "SudokuCubeView.h"

NSString * const NumberCollectionViewCellIdentifier = @"number_collection_view_cell_identifier";
NSString * const NumberCollectionViewCellSelectionChanged = @"NumberCollectionViewCellSelectionChanged";
NSString * const NumberCollectionViewCellSelectionChangedKeyCell = @"NumberCollectionViewCellSelectionChangedKeyCell";

@interface NumberCollectionViewCell ()

@property (nonatomic, strong) UIImageView *numberBackgroundImageView;
@property (nonatomic, strong) UIImageView *numberShadowImageView;
@property (nonatomic, strong) UIImageView *numberImageView;

@property (nonatomic, strong) UIImage *numberBackgroundNormalImage;
@property (nonatomic, strong) UIImage *numberBackgroundHighlightImage;

@property (nonatomic, strong) NSLayoutConstraint *valueNumberWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *valueNumberHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *guessNumberWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *guessNumberHeightConstraint;

@end

@implementation NumberCollectionViewCell

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
    self.backgroundColor = [UIColor clearColor];
    
    self.numberBackgroundNormalImage = [UIImage imageNamed:@"button_number"];
    self.numberBackgroundHighlightImage = [UIImage imageNamed:@"button_number_highlight"];
    
    self.numberBackgroundImageView = [[UIImageView alloc] initWithImage:self.numberBackgroundNormalImage];
    self.numberBackgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.numberBackgroundImageView];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.numberBackgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    widthConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:widthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.numberBackgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.numberBackgroundImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:heightConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.numberBackgroundImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    [self.numberBackgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberBackgroundImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    self.numberShadowImageView = [[UIImageView alloc] init];
    self.numberShadowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberShadowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.numberBackgroundImageView addSubview:self.numberShadowImageView];
    [self.numberBackgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.numberBackgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];

    self.valueNumberWidthConstraint = [NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeWidth multiplier:3.0f / 4.0f constant:0.0];
    [self.numberBackgroundImageView addConstraint:self.valueNumberWidthConstraint];
    self.valueNumberHeightConstraint = [NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeHeight multiplier:3.0f / 4.0f constant:0.0];
    [self.numberBackgroundImageView addConstraint:self.valueNumberHeightConstraint];

    self.guessNumberWidthConstraint = [NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeWidth multiplier:1.0f / 3.0f constant:0.0];
    [self.numberBackgroundImageView addConstraint:self.guessNumberWidthConstraint];
    self.guessNumberWidthConstraint.active = NO;
    self.guessNumberHeightConstraint = [NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeHeight multiplier:1.0f / 3.0f constant:0.0];
    [self.numberBackgroundImageView addConstraint:self.guessNumberHeightConstraint];
    self.guessNumberHeightConstraint.active = NO;

    self.numberImageView = [[UIImageView alloc] init];
    self.numberImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.numberShadowImageView addSubview:self.numberImageView];
    [self.numberShadowImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[number]-0-|" options:0 metrics:nil views:@{@"number" : self.numberImageView}]];
    [self.numberShadowImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[number]-0-|" options:0 metrics:nil views:@{@"number" : self.numberImageView}]];
}

- (void)setNumber:(int)number {
    _number = number;
    if ([[Presenter sharedInstance] isInDemension:number]) {
        NSString *numberShadowImageName = [NSString stringWithFormat:@"b%d_shadow", number];
        self.numberShadowImageView.image = [UIImage imageNamed:numberShadowImageName];

        NSString *numberImageName = [NSString stringWithFormat:@"b%d", number];
        self.numberImageView.image = [[UIImage imageNamed:numberImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.numberImageView.tintColor = [ColorCollectionViewCell defaultSelectedColor];
    } else {
        self.numberShadowImageView.image = [UIImage imageNamed:@"pencil"];
        self.numberImageView.image = nil;
    }
    [self reload];
}

- (BOOL)isAltKey {
    return ![[Presenter sharedInstance] isInDemension:self.number];
}

- (void)setNumberColor:(UIColor *)numberColor {
    _numberColor = numberColor;
    [self reload];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self reload];
}

- (void)setSelected:(BOOL)selected manual:(BOOL)manual {
    [self setSelected:selected];
    if (manual) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NumberCollectionViewCellSelectionChanged object:self userInfo:@{NumberCollectionViewCellSelectionChangedKeyCell : self}];
    }
}

- (void)reload {
    self.numberImageView.tintColor = self.numberColor;
    self.numberBackgroundImageView.image = self.selected ? self.numberBackgroundHighlightImage : self.numberBackgroundNormalImage;
    
    if (self.isAltKey == NO) {
        self.valueNumberWidthConstraint.active = ![Presenter sharedInstance].currentSelectedCubeView.guessMode;
        self.valueNumberHeightConstraint.active = ![Presenter sharedInstance].currentSelectedCubeView.guessMode;
        self.guessNumberHeightConstraint.active = [Presenter sharedInstance].currentSelectedCubeView.guessMode;
        self.guessNumberWidthConstraint.active = [Presenter sharedInstance].currentSelectedCubeView.guessMode;
    } else {
        self.valueNumberWidthConstraint.active = YES;
        self.valueNumberHeightConstraint.active = YES;
        self.guessNumberHeightConstraint.active = NO;
        self.guessNumberWidthConstraint.active = NO;
        self.selected = [Presenter sharedInstance].currentSelectedCubeView.guessMode;
    }
    
    [self layoutIfNeeded];
}


@end
