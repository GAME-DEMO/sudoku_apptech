//
//  UISudokuDataManager.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/29/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "UISudokuDataManager.h"
#import "Presenter.h"

@interface UICubeData ()

@end

@implementation UICubeData

- (instancetype)init {
    if (self = [super init]) {
        NSMutableArray *guessArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].dimension];
        NSMutableArray *valueColorArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].dimension];
        NSMutableArray *guessColorArray = [NSMutableArray arrayWithCapacity:[Presenter sharedInstance].dimension];
        for (int i = 0; i < [Presenter sharedInstance].dimension; ++i) {
            [guessArray addObject:@(0)];
            [valueColorArray addObject:[UIColor whiteColor]];
            [valueColorArray addObject:[UIColor whiteColor]];
        }
        _guessArray = [NSArray arrayWithArray:guessArray];
        _valueColorArray = [NSArray arrayWithArray:valueColorArray];
        _guessColorArray = [NSArray arrayWithArray:guessColorArray];
    }
    return self;
}

@end


@interface UISudokuDataManager ()

@end


@implementation UISudokuDataManager

+ (instancetype)sharedInstance {
    static UISudokuDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UISudokuDataManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

@end
