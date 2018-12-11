//
//  YHOCMonkey+Private.h
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/9.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkey.h"
@protocol XCEventGenerator<NSObject>
+(id<XCEventGenerator>)sharedGenerator;
@property(nonatomic,assign) NSInteger generation;
- (CGFloat)rotateInRect:(CGRect)rect
           withRotation:(CGFloat)rotation
               velocity:(CGFloat)velocity
            orientation:(UIDeviceOrientation)orientation
                handler:(void(^)(void))handler;

- (CGFloat)pinchInRect:(CGRect)rect
              withScale:(CGFloat)scale
               velocity:(CGFloat)velocity
            orientation:(UIDeviceOrientation)orientation
                handler:(void(^)(void))handler;

- (CGFloat)pressAtPoint:(CGPoint)point
            forDuration:(NSTimeInterval)duration
            liftAtPoint:(CGPoint)liftAtPoint
               velocity:(CGFloat)velocity
            orientation:(UIDeviceOrientation)orientation
                   name:(id)name
                handler:(void(^)(void))handler;

- (CGFloat)pressAtPoint:(CGPoint)point
            forDuration:(NSTimeInterval)duration
            orientation:(UIDeviceOrientation)orientation
                handler:(void(^)(void))handler;

- (double)tapAtTouchLocations:(NSArray *)pointsValue
                  numberOfTaps:(NSUInteger)numberOfTaps
                  orientation:(UIDeviceOrientation)orientation
                       handler:(void(^)(void))handler;

- (void)_startEventSequenceWithSteppingCallback:(void(^)(void))callBack;
- (void)_scheduleCallback:(void(^)(void))callBack
            afterInterval:(NSTimeInterval)interval;

@end
NS_ASSUME_NONNULL_BEGIN

@interface YHOCMonkey (Private)
- (void)addDefaultXCTestPrivateActions;
@end

NS_ASSUME_NONNULL_END
