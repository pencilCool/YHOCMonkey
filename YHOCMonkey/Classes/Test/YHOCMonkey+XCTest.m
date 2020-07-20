//
//  YHOCMonkey+XCTest.m
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/9.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkey+XCTest.h"

@implementation YHOCMonkey (XCTest)

- (CGVector) randomOffset {
    CGPoint point = [self randomPoint];
    return CGVectorMake(point.x, point.y);
}

- (void)addXCTestTapAlertAction:(NSTimeInterval)interval
                    application:(XCUIApplication *)application {
    YHOCMonkeyActionBlock action = ^(void) {
        for (int i = 0; i < application.alerts.count; i ++) {
            XCUIElement *alert = [application.alerts elementBoundByIndex:i];
            XCUIElementQuery *buttons = [alert descendantsMatchingType:XCUIElementTypeButton];
            NSUInteger index = [self.r randomIntLessThan:buttons.count];
            XCUIElement *button = [buttons elementBoundByIndex:index];
            [button tap];
        }
    };
    [self addActionWithInterval:interval action:action];
}

- (void)addDefaultXCTestPublicActions:(XCUIApplication *)app {
    [self addXCTestPublicTapAction:app weight:25 doubleTapProbability:0.05];
    [self addXCTestPublicLongPressAction:app weight:1];
    [self addXCTestPublicDragAction:app weight:1];
}

- (void)addXCTestPublicTapAction:(XCUIApplication *)app
                          weight:(double )weight
            doubleTapProbability:(double)doubleTapProbability {
    YHOCMonkeyActionBlock action = ^(void) {
        BOOL isDoubleTap = self.r.randomDouble < doubleTapProbability;
        XCUICoordinate *offset = [app coordinateWithNormalizedOffset:CGVectorMake(0, 0)];
        XCUICoordinate *coordinate  = [offset coordinateWithOffset:[self randomOffset]];
        if (isDoubleTap) {
           [coordinate doubleTap];
        } else {
           [coordinate tap];
        }
    };
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestPublicLongPressAction:(XCUIApplication *)app
                                weight:(double )weight {
    YHOCMonkeyActionBlock action = ^(void) {
        XCUICoordinate *offset = [app coordinateWithNormalizedOffset:CGVectorMake(0, 0)];
        XCUICoordinate *coordinate  = [offset coordinateWithOffset:[self randomOffset]];
        [coordinate pressForDuration:0.5];
    };
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestPublicDragAction:(XCUIApplication *)app
                           weight:(double )weight {
    YHOCMonkeyActionBlock action = ^(void) {
        XCUICoordinate *startOffset = [app coordinateWithNormalizedOffset:CGVectorMake(0, 0)];
        XCUICoordinate *startCoordinate  = [startOffset coordinateWithOffset:[self randomOffset]];

        XCUICoordinate *endOffset = [app coordinateWithNormalizedOffset:CGVectorMake(0, 0)];
        XCUICoordinate *endCoordinate  = [endOffset coordinateWithOffset:[self randomOffset]];
        [startCoordinate pressForDuration:0.2 thenDragToCoordinate:endCoordinate];
    };
    
    [self addActionWithWeight:weight action:action];
}
@end
