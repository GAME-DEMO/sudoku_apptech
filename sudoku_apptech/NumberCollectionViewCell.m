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

@property (nonatomic, strong) UIImageView *numberBackgroundImageView;
@property (nonatomic, strong) UIImageView *numberShadowImageView;
@property (nonatomic, strong) UIImageView *numberImageView;

@property (nonatomic, strong) UIImage *numberBackgroundNormalImage;
@property (nonatomic, strong) UIImage *numberBackgroundHighlightImage;

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
    [self.numberBackgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeWidth multiplier:3.0f / 4.0f constant:0.0]];
    [self.numberBackgroundImageView addConstraint:[NSLayoutConstraint constraintWithItem:self.numberShadowImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.numberBackgroundImageView attribute:NSLayoutAttributeHeight multiplier:3.0f / 4.0f constant:0.0]];

    self.numberImageView = [[UIImageView alloc] init];
    self.numberImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.numberShadowImageView addSubview:self.numberImageView];
    [self.numberShadowImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[number]-0-|" options:0 metrics:nil views:@{@"number" : self.numberImageView}]];
    [self.numberShadowImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[number]-0-|" options:0 metrics:nil views:@{@"number" : self.numberImageView}]];
}

- (void)setNumber:(int)number {
    if (number > 0 && number < 10) {
        NSString *numberShadowImageName = [NSString stringWithFormat:@"b%d_shadow", number];
        self.numberShadowImageView.image = [UIImage imageNamed:numberShadowImageName];

        NSString *numberImageName = [NSString stringWithFormat:@"b%d", number];
        self.numberImageView.image = [[UIImage imageNamed:numberImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.numberImageView.tintColor = [UIColor whiteColor];
        //self.numberImageView.tintColor = [Presenter sharedInstance].randomColor;
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.numberBackgroundImageView.image = selected ? self.numberBackgroundHighlightImage : self.numberBackgroundNormalImage;
}

@end
