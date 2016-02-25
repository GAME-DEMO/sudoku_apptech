//
//  SudokuContentView.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/25/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "SudokuContentView.h"
#import "Presenter.h"

@interface SudokuContentView ()

@end


@implementation SudokuContentView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}


- (void)viewDidLoad {
    if ([Presenter sharedInstance].isDemensionLevelNine) {
        UIView *lastLineView = nil;
        UIView *lastPlaceHolderView = nil;
        for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
            UIView *placeHolderView = [[UIView alloc] init];
            placeHolderView.translatesAutoresizingMaskIntoConstraints = NO;
            placeHolderView.backgroundColor = [UIColor clearColor];
            [self addSubview:placeHolderView];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView)]];
            
            UIView *lineView = nil;
            if (i != [Presenter sharedInstance].dimension - 1) {
                lineView = [[UIView alloc] init];
                lineView.translatesAutoresizingMaskIntoConstraints = NO;
                lineView.backgroundColor = RGBA(0, 0, 0, 0.6);
                [self addSubview:lineView];
                
                CGFloat lineWidth = i % 3 == 2 ? 2 * LINE_WIDTH : LINE_WIDTH;
                [lineView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:lineWidth]];
                
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[lineView]-0-|" options:0 metrics:nil views:@{@"lineView" : lineView}]];
            }
            
            if (lastLineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView, lineView)]];
            } else if (lineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastLineView]-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView)]];
            } else {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[lastLineView]-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView, lineView)]];
            }
            
            if (lastPlaceHolderView != nil) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:placeHolderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:lastPlaceHolderView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
            }
            
            lastLineView = lineView;
            lastPlaceHolderView = placeHolderView;
        }
        
        lastLineView = nil;
        lastPlaceHolderView = nil;
        for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
            UIView *placeHolderView = [[UIView alloc] init];
            placeHolderView.translatesAutoresizingMaskIntoConstraints = NO;
            placeHolderView.backgroundColor = [UIColor clearColor];
            [self addSubview:placeHolderView];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView)]];
            
            UIView *lineView = nil;
            if (i != [Presenter sharedInstance].dimension - 1) {
                lineView = [[UIView alloc] init];
                lineView.translatesAutoresizingMaskIntoConstraints = NO;
                lineView.backgroundColor = RGBA(0, 0, 0, 0.6);
                [self addSubview:lineView];
                
                CGFloat lineWidth = i % 3 == 2 ? 2 * LINE_WIDTH : LINE_WIDTH;
                [lineView addConstraint:[NSLayoutConstraint constraintWithItem:lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:lineWidth]];
                
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[lineView]-0-|" options:0 metrics:nil views:@{@"lineView" : lineView}]];
            }
            
            if (lastLineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(placeHolderView, lineView)]];
            } else if (lineView == nil) {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLineView]-0-[placeHolderView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView)]];
            } else {
                [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastLineView]-0-[placeHolderView]-0-[lineView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lastLineView, placeHolderView, lineView)]];
            }
            
            if (lastPlaceHolderView != nil) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:placeHolderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:lastPlaceHolderView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
            }
            
            lastLineView = lineView;
            lastPlaceHolderView = placeHolderView;
        }
    }
}


@end
