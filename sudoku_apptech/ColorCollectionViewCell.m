//
//  ColorCollectionViewCell.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/21/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "ColorCollectionViewCell.h"

NSString * const ColorCollectionViewCellIdentifier = @"color_collection_view_cell_identifier";

@interface ColorCollectionViewCell ()

@property (nonatomic, strong) UIButton *colorButton;
@property (nonatomic, strong) UIView *colorView;

@end

@implementation ColorCollectionViewCell

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
    self.colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.colorButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.colorButton];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.colorButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.colorButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.colorButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0];
    widthConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:widthConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.colorButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    heightConstraint.priority = UILayoutPriorityDefaultHigh;
    [self addConstraint:heightConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.colorButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    [self.colorButton addConstraint:[NSLayoutConstraint constraintWithItem:self.colorButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.colorButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];

    self.colorButton.backgroundColor = [UIColor lightGrayColor];
}

@end
