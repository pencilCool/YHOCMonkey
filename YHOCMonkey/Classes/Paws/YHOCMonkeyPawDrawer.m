//
//  YHOCMonkeyPawDrawer.m
//  YHOCMonkey
//
//  Created by pencilCool on 2018/12/1.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkeyPawDrawer.h"

@implementation YHOCMonkeyPawDrawer
+ (BezierPathDrawer)monkeyHandPath {
    BezierPathDrawer result = ^UIBezierPath*(void) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(-5.91,8.76)];
        [bezierPath addCurveToPoint: CGPointMake( -10.82,  2.15) controlPoint1: CGPointMake( -9.18,  7.11) controlPoint2: CGPointMake( -8.09,  4.9)];
        [bezierPath addCurveToPoint: CGPointMake( -16.83,  -1.16) controlPoint1: CGPointMake( -13.56,  -0.6) controlPoint2: CGPointMake( -14.65,  0.5)];
        [bezierPath addCurveToPoint: CGPointMake( -14.65,  -6.11) controlPoint1: CGPointMake( -19.02,  -2.81) controlPoint2: CGPointMake( -19.57,  -6.66)];
        [bezierPath addCurveToPoint: CGPointMake( -8.09,  -2.81) controlPoint1: CGPointMake( -9.73,  -5.56) controlPoint2: CGPointMake( -8.64,  -0.05)];
        [bezierPath addCurveToPoint: CGPointMake( -11.37,  -13.82) controlPoint1: CGPointMake( -7.54,  -5.56) controlPoint2: CGPointMake( -7,  -8.32)];
        [bezierPath addCurveToPoint: CGPointMake( -7.54,  -17.13) controlPoint1: CGPointMake( -15.74,  -19.33) controlPoint2: CGPointMake( -9.73,  -20.98)];
        [bezierPath addCurveToPoint: CGPointMake( -4.27,  -8.87) controlPoint1: CGPointMake( -5.36,  -13.27) controlPoint2: CGPointMake( -6.45,  -7.76)];
        [bezierPath addCurveToPoint: CGPointMake( -4.27,  -18.23) controlPoint1: CGPointMake( -2.08,  -9.97) controlPoint2: CGPointMake( -3.72,  -12.72)];
        [bezierPath addCurveToPoint: CGPointMake( 0.65,  -18.23) controlPoint1: CGPointMake( -4.81,  -23.74) controlPoint2: CGPointMake( 0.65,  -25.39)];
        [bezierPath addCurveToPoint: CGPointMake( 1.2,  -8.32) controlPoint1: CGPointMake( 0.65,  -11.07) controlPoint2: CGPointMake( -0.74,  -9.29)];
        [bezierPath addCurveToPoint: CGPointMake( 3.93,  -18.78) controlPoint1: CGPointMake( 2.29,  -7.76) controlPoint2: CGPointMake( 3.93,  -9.3)];
        [bezierPath addCurveToPoint: CGPointMake( 8.3,  -16.03) controlPoint1: CGPointMake( 3.93,  -23.19) controlPoint2: CGPointMake( 9.96,  -21.86)];
        [bezierPath addCurveToPoint: CGPointMake( 5.57,  -6.11) controlPoint1: CGPointMake( 7.76,  -14.1) controlPoint2: CGPointMake( 3.93,  -6.66)];
        [bezierPath addCurveToPoint: CGPointMake( 9.4,  -10.52) controlPoint1: CGPointMake( 7.21,  -5.56) controlPoint2: CGPointMake( 9.16,  -10.09)];
        [bezierPath addCurveToPoint: CGPointMake( 12.13,  -6.66) controlPoint1: CGPointMake( 12.13,  -15.48) controlPoint2: CGPointMake( 15.41,  -9.42)];
        [bezierPath addCurveToPoint: CGPointMake( 8.3,  -1.16) controlPoint1: CGPointMake( 8.85,  -3.91) controlPoint2: CGPointMake( 8.85,  -3.91)];
        [bezierPath addCurveToPoint: CGPointMake( 8.3,  7.11) controlPoint1: CGPointMake( 7.76,  1.6) controlPoint2: CGPointMake( 9.4,  4.35)];
        [bezierPath addCurveToPoint: CGPointMake( -5.91,  8.76) controlPoint1: CGPointMake( 7.21,  9.86) controlPoint2: CGPointMake( -2.63,  10.41)];
        [bezierPath closePath];
        return bezierPath;
    };
    
    return result;
}
@end
