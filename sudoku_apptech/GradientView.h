//
//  GradientView.h
//  ColorKeyboard
//
//  Created by Wang.Peng on 12/30/15.
//  Copyright © 2015 iHandySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, copy) NSString *type;

@end
