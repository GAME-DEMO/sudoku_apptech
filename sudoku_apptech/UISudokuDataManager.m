//
//  UISudokuDataManager.m
//  sudoku_apptech
//
//  Created by Peng Wang on 2/29/16.
//  Copyright © 2016 Peng Wang. All rights reserved.
//

#import "UISudokuDataManager.h"

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
