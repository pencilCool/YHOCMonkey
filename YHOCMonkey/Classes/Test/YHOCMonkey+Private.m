//
//  YHOCMonkey+Private.m
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/9.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkey+Private.h"

UIDeviceOrientation orientationValue = UIDeviceOrientationPortrait;
@implementation YHOCMonkey (Private)

- (id<XCEventGenerator>)sharedXCEventGenerator {
    Class class = NSClassFromString(@"XCEventGenerator");
    id<XCEventGenerator> caseClass = (id<XCEventGenerator>)class;
    return [caseClass sharedGenerator];
}

- (void)addDefaultXCTestPrivateActions {
    [self addXCTestTapActionWithWeight:25];
    [self addXCTestLongPressActionWithWeight:1];
    [self addXCTestDragActionWithWeight:1];
    [self addXCTestPinchCloseActionWithWeight:1];
    [self addXCTestPinchOpenActionWithWeight:1];
    [self addXCTestRotateActionWithWeight:1];
}

- (void)addXCTestTapActionWithWeight:(double)weight {
    [self addXCTestTapActionWithWeight:weight
                multipleTapProbability:0.05
              multipleTouchProbability:0.05];
}
- (void)addXCTestTapActionWithWeight:(double)weight
              multipleTapProbability:(double)multipleTapProbability
            multipleTouchProbability:(double)multipleTouchProbability {
    YHOCMonkeyActionBlock action = ^(void) {
        NSUInteger numberOfTaps;
        if (self.r.randomDouble < multipleTapProbability) {
            numberOfTaps = (NSUInteger)(self.r.randomUInt32 % 2) + 2;
        } else {
            numberOfTaps = 1;
        }
        NSMutableArray *locationsValue;
        if (self.r.randomDouble < multipleTouchProbability) {
            NSInteger numberOfTouches = (NSInteger)(self.r.randomUInt32 % 3) + 2;
            CGRect rect = self.randomRect;
            for (int i = 1; i< numberOfTouches; i++) {
                CGPoint point = [self randomPointInRect:rect];
                [locationsValue addObject:[NSValue valueWithCGPoint:point]];
            }
        } else {
            CGPoint point = [self randomPoint];
            locationsValue = @[[NSValue valueWithCGPoint:point]].mutableCopy;
        }
        
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [[self sharedXCEventGenerator]
         tapAtTouchLocations:locationsValue
         numberOfTaps:numberOfTaps
         orientation:orientationValue
         handler:^{
             dispatch_semaphore_signal(semaphore);
         }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
    
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestLongPressActionWithWeight:(double)weight {
    YHOCMonkeyActionBlock action = ^(void) {
        CGPoint point = self.randomPoint;
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [[self sharedXCEventGenerator] pressAtPoint:point forDuration:0.5 orientation:orientationValue handler:^{
             dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestDragActionWithWeight:(double)weight {
    YHOCMonkeyActionBlock action = ^(void) {
        CGPoint start = [self randomPointAvoidingPanelAreas];
        CGPoint end = [self randomPoint];
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [[self sharedXCEventGenerator]
        pressAtPoint:start
        forDuration:0
        liftAtPoint:end
        velocity:1000
        orientation:orientationValue
        name:@"Monkey drag"
        handler:^{
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestPinchCloseActionWithWeight:(double)weight {
    YHOCMonkeyActionBlock action = ^(void) {
        CGRect rect = [self randomRectSizeFraction:2];
        CGFloat scale = 1 / (CGFloat)(self.r.randomDouble * 4 + 1);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [[self sharedXCEventGenerator]
        pinchInRect:rect
        withScale:scale
        velocity:1
        orientation:orientationValue
        handler:^{
            dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestPinchOpenActionWithWeight:(double)weight {
    YHOCMonkeyActionBlock action = ^(void) {
        CGRect rect = [self randomRectSizeFraction:2];
        CGFloat scale = 1 / (CGFloat)(self.r.randomDouble * 4 + 1);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [[self sharedXCEventGenerator]
         pinchInRect:rect
         withScale:scale
         velocity:3
         orientation:orientationValue
         handler:^{
           dispatch_semaphore_signal(semaphore);
        }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestRotateActionWithWeight:(double)weight {
    YHOCMonkeyActionBlock action = ^(void) {
        CGRect rect = [self randomRectSizeFraction:2];
        CGFloat angle = (CGFloat)(self.r.randomDouble *2 * 3.141592);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        [[self sharedXCEventGenerator]
         rotateInRect:rect
         withRotation:angle
         velocity:5
         orientation:orientationValue
         handler:^{
             dispatch_semaphore_signal(semaphore);
         }];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    };
    [self addActionWithWeight:weight action:action];
}

- (void)addXCTestOrientationActionWithWeight:(double)weight {
    YHOCMonkeyActionBlock action = ^(void) {
         orientationValue  = (UIDeviceOrientation)(self.r.randomUInt32 % 6) + 1;
    };
    [self addActionWithWeight:weight action:action];
}


@end

