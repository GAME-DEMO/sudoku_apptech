//
//  NumberCollectionViewCell.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "NumberCollectionViewCell.h"
#import "Presenter.h"

NSString * const NumberCollectionViewCellIdentifier = @"number_collection_view_cell_identifier";

@interface NumberCollectionViewCell ()

@property (nonatomic, strong) UIButton *numberButton;
@property (nonatomic, strong) UIImageView *numberImageView;

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

    self.numberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.numberButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.numberButton setImage:[UIImage imageNamed:@"button_number"] forState:UIControlStateNormal];
    [self.numberButton setImage:[UIImage imageNamed:@"button_number_highlight"] forState:UIControlStateHighlighted];
    [self.numberButton setImage:[UIImage imageNamed:@"button_number_highlight"] forState:UIControlStateSelected];
    [self addSubview:self.numberButton];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    widthConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:widthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:heightConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    [self.numberButton addConstraint:[NSLayoutConstraint constraintWithItem:self.numberButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    self.numberImageView = [[UIImageView alloc] init];
    self.numberImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.numberButton addSubview:self.numberImageView];
    [self.numberButton addConstraint:[NSLayoutConstraint constraintWithItem:self.numberImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.numberButton addConstraint:[NSLayoutConstraint constraintWithItem:self.numberImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.numberButton addConstraint:[NSLayoutConstraint constraintWithItem:self.numberImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeWidth multiplier:3.0f / 4.0f constant:0.0]];
    [self.numberButton addConstraint:[NSLayoutConstraint constraintWithItem:self.numberImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.numberButton attribute:NSLayoutAttributeHeight multiplier:3.0f / 4.0f constant:0.0]];
}

- (void)setNumber:(int)number {
    if (number > 0 && number < 10) {
        NSString *numberImageName = [NSString stringWithFormat:@"b%d", number];
        self.numberImageView.image = [[UIImage imageNamed:numberImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.numberImageView.tintColor = [UIColor whiteColor];
        //self.numberImageView.tintColor = [Presenter sharedInstance].randomColor;
    }
}

@end
