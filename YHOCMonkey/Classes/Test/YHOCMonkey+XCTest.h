//
//  YHOCMonkey+XCTest.h
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/9.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkey.h"
#import <XCTest/XCTest.h>
NS_ASSUME_NONNULL_BEGIN

@interface YHOCMonkey (XCTest)
- (void)addXCTestTapAlertAction:(NSTimeInterval)interval
                    application:(XCUIApplication *)application;
@end

NS_ASSUME_NONNULL_END
