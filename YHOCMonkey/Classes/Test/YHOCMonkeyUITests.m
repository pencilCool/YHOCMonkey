//
//  YHOCMonkeyUITests.m
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/11/30.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YHOCMonkey.h"
#import "YHOCMonkey+Private.h"
#import "YHOCMonkey+XCTest.h"

@interface YHOCMonkeyUITests : XCTestCase

@end

@implementation YHOCMonkeyUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    
}

- (void)testMonkey {
    XCUIApplication *application = [[XCUIApplication alloc] init];
    XCUIElementQuery *query = [application descendantsMatchingType:XCUIElementTypeAny];
    [query elementBoundByIndex:0].frame;
    YHOCMonkey *monkey = [[YHOCMonkey alloc] initWithFrame:application.frame];
    [monkey addDefaultXCTestPrivateActions];
    [monkey addXCTestTapAlertAction:100
                        application:application];
    [monkey monkeyAroundInfinity];
}

@end
