//
//  YHOCMonkey.m
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/8.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkey.h"
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface YHOCMonkeyRandomAction : NSObject
@property (nonatomic,assign) double accumulatedWeight;
@property (nonatomic,copy  ) YHOCMonkeyActionBlock action;
@end

@implementation YHOCMonkeyRandomAction
@end


@interface YHOCMonkeyRegularAction : NSObject
@property (nonatomic,assign) NSInteger interval;
@property (nonatomic,copy  ) YHOCMonkeyActionBlock action;
@end

@implementation YHOCMonkeyRegularAction
@end

YHOCMonkeyActionBlock actInForeground(YHOCMonkeyActionBlock action) {
    YHOCMonkeyActionBlock result = ^(void) {
        YHOCMonkeyActionBlock block = ^(void) {
            XCUIApplication *obj = [XCUIApplication new];
            if(obj.state !=  XCUIApplicationStateRunningForeground) {
                [obj activate];
            }
            action();
        };
        
        if (NSThread.isMainThread) {
            block();
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    };
    return result;
}

@interface YHOCMonkey()
@property (nonatomic,assign) CGRect frame;
@property (nonatomic,strong) NSMutableArray<YHOCMonkeyRandomAction*> *randomActions;
@property (nonatomic,assign) double totalWeight;
@property (nonatomic,strong) NSMutableArray<YHOCMonkeyRegularAction*> *regularActions;
@property (nonatomic,assign) NSUInteger actionCounter;
@end


@implementation YHOCMonkey
- (instancetype)initWithFrame:(CGRect)frame {
    NSTimeInterval time = [NSDate timeIntervalSinceReferenceDate];
    uint32_t seed = (uint32_t)((uint64_t)(time * 1000) & 0xffffffff);
    return [self initWithFrame:frame seed:seed];
}

- (instancetype)initWithFrame:(CGRect)frame seed:(uint32_t)seed {
    self = [super init];
    if (self) {
        self.frame = frame;
        self.r = [[YHOCMonkeyRandom alloc] initWithSeed:seed];
        self.randomActions = @[].mutableCopy;
        self.totalWeight = 0;
        self.regularActions = @[].mutableCopy;
    }
    return self;
}

- (void)monkeyAround:(NSUInteger)iterations {
    while (iterations--> 0) {
        [self actRandomly];
        [self actRegularly];
    }
}

- (void)monkeyAroundInfinity {
    [self monkeyAroundWithDuration:INFINITY];
}
- (void)monkeyAroundWithDuration:(NSTimeInterval)duration {
    NSTimeInterval monkeyTestingTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    while (currentTime - monkeyTestingTime < duration) {
        [self actRandomly];
        [self actRegularly];
        currentTime = [[NSDate date] timeIntervalSince1970];
    }
}

- (void)actRandomly {
    double x = self.r.randomDouble * self.totalWeight;
    for (YHOCMonkeyRandomAction *action in self.randomActions) {
        if (action.accumulatedWeight > x) {
            action.action();
            return;
        }
        
    }
}

- (void)actRegularly {
    self.actionCounter += 1;
    for (YHOCMonkeyRegularAction *action in self.regularActions) {
        if (self.actionCounter % action.interval == 0) {
            action.action();
        }
    }
}

- (void)addActionWithWeight:(double)weight action:(YHOCMonkeyActionBlock)action {
    self.totalWeight += weight;
    YHOCMonkeyRandomAction *randomAction = [YHOCMonkeyRandomAction new];
    randomAction.accumulatedWeight  = self.totalWeight;
    randomAction.action = actInForeground(action);
    [self.randomActions addObject:randomAction];
}

- (void)addActionWithInterval:(NSTimeInterval)interval action:(YHOCMonkeyActionBlock)action {
    YHOCMonkeyRegularAction *regularAction = [YHOCMonkeyRegularAction new];
    regularAction.interval  = interval;
    regularAction.action = actInForeground(action);
    [self.regularActions addObject:regularAction];
}

- (NSInteger)randomIntLessThan:(NSInteger)limit {
    return [self.r randomIntLessThan:limit];
}

- (NSUInteger)randomUIntLessThan:(NSUInteger)limit {
    return [self.r randomUIntLessThan:limit];
}

- (CGFloat)randomCGFloatLessThan:(CGFloat)limit {
    return (CGFloat)[self.r randomDoubleLessThan:limit];
}

- (CGPoint)randomPoint {
    return [self randomPointInRect:self.frame];
}

- (CGPoint)randomPointAvoidingPanelAreas {
    CGFloat topHeight  = 20;
    CGFloat bottomHeight = 20;
    CGSize size = self.frame.size;
    CGRect frameWithoutTopAndBottom = CGRectMake(0, topHeight, size.width, size.height - topHeight - bottomHeight);
    return [self randomPointInRect:frameWithoutTopAndBottom];
}

- (CGPoint)randomPointInRect:(CGRect)rect {
    CGFloat deltaX = [self randomCGFloatLessThan:rect.size.width];
    CGFloat deltaY = [self randomCGFloatLessThan:rect.size.height];
    return CGPointMake(rect.origin.x + deltaX,
                       rect.origin.y + deltaY);
}

- (CGRect)randomRect {
    return [self rectAroundPoint:[self randomPoint]
                          inRect:self.frame];
}

- (CGRect)randomRectSizeFraction:(CGFloat)sizeFraction {
     return [self rectAroundPoint:[self randomPoint]
                     sizeFraction:sizeFraction
                           inRect:self.frame];
}

- (NSMutableArray *)randomClusteredPoints:(NSUInteger)count {
    CGPoint center = [self randomPoint];
    CGRect clusterRect = [self rectAroundPoint:center inRect:self.frame];
    NSValue *centerValue = [NSValue valueWithCGPoint:center];
    NSMutableArray *points = @[centerValue].mutableCopy;
    while (count-->0) {
        NSValue *pointValue = [NSValue valueWithCGPoint:[self randomPointInRect:clusterRect]];
        [points addObject:pointValue];
    }
    return points;
}

- (CGRect)rectAroundPoint:(CGPoint)point
                   inRect:(CGRect)rect {
    return [self rectAroundPoint:point sizeFraction:3 inRect:rect];
}


- (CGRect)rectAroundPoint:(CGPoint)point sizeFraction:(CGFloat) sizeFraction
                   inRect:(CGRect)rect  {
    CGFloat size = MIN(self.frame.size.width, self.frame.size.height) / sizeFraction;
    CGFloat x0 = (point.x - self.frame.origin.x) * (self.frame.size.width - size) / self.frame.size.width + self.frame.origin.x;
    CGFloat y0 = (point.y - self.frame.origin.y) * (self.frame.size.height - size) / self.frame.size.width  + self.frame.origin.y;
    return CGRectMake(x0, y0, size, size);
}


- (void)sleep:(double)seconds {
    if (seconds > 0) {
        usleep((uint32_t)(seconds * 1000000));
    }
}
@end
