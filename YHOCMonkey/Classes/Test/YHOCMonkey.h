//
//  YHOCMonkey.h
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/8.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHOCMonkeyRandom.h"
NS_ASSUME_NONNULL_BEGIN


typedef void (^YHOCMonkeyActionBlock)(void);

@interface YHOCMonkey : NSObject
@property (nonatomic,strong) YHOCMonkeyRandom *r;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)addActionWithInterval:(NSTimeInterval)interval
                       action:(YHOCMonkeyActionBlock)action;
- (void)addActionWithWeight:(double)weight
                     action:(YHOCMonkeyActionBlock)action;
- (CGPoint)randomPointAvoidingPanelAreas;
- (NSInteger)randomIntLessThan:(NSInteger)limit;
- (CGRect)randomRectSizeFraction:(CGFloat)sizeFraction;
- (CGPoint)randomPoint;
- (CGPoint)randomPointInRect:(CGRect)rect;
- (CGRect)randomRect;
- (void)monkeyAroundInfinity;
@end

NS_ASSUME_NONNULL_END
