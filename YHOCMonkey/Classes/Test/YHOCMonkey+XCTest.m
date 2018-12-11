//
//  YHOCMonkey+XCTest.m
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/9.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkey+XCTest.h"

@implementation YHOCMonkey (XCTest)
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


@end
