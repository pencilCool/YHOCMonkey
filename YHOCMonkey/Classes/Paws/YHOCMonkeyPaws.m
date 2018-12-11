//
//  YHOCMonekyPaws.m
//  YHOCMonkey
//
//  Created by pencilCool on 2018/12/1.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkeyPaws.h"
#import "YHOCMonkeyPawDrawer.h"
#import <objc/objc.h>
#import <objc/runtime.h>




static UIBezierPath *customize(UIBezierPath *path,NSInteger seed) {
    CGFloat angle = 46 *((CGFloat)(fmod(seed * 0.279, 1)) * 2 - 1);
    BOOL mirrored = (seed  % 2 == 0);
    if (mirrored) {
        [path applyTransform:CGAffineTransformMakeScale(-1,1)];
    }
    [path applyTransform:CGAffineTransformMakeRotation(angle/180*M_PI)];
    return path;
}

static UIBezierPath *circlePath(CGFloat radius) {
    CGRect rect = CGRectMake(- radius, -radius, 2 * radius, 2 * radius);
    return [UIBezierPath bezierPathWithOvalInRect:rect];
}

static UIBezierPath *crossPath(CGFloat radius) {
    CGRect rect = CGRectMake(- radius, -radius, 2 * radius, 2 * radius);
    UIBezierPath *cross = [UIBezierPath bezierPath];
    [cross moveToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect))];
    [cross addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
    [cross addLineToPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect))];
    [cross addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect))];
    return cross;
}

@class YHOCMonkeyPaws;
@interface YHOCWeakReference : NSProxy
@property (nonatomic, weak) YHOCMonkeyPaws *value;
+ (instancetype)proxyWithValue:(YHOCMonkeyPaws *)value;
@end

@implementation YHOCWeakReference
+ (instancetype)proxyWithValue:(YHOCMonkeyPaws *)value {
    return [[YHOCWeakReference alloc] initWithValue:value];
}

- (instancetype)initWithValue:(YHOCMonkeyPaws *)value {
    _value = value;
    return self;
}
@end



static NSMutableArray *YHOCMonekyPawsTappingTracks = nil;
@class YHOCMonkeyGestureWithHash;

@interface YHOCMonkeyPaws()<CALayerDelegate>
@property (nonatomic, strong) YHOCMonkeyPawConfig *configuration;
@property (nonatomic, copy) BezierPathDrawer bezierPathDrawer;
@property (nonatomic, weak) UIView *view;
@property (nonatomic, strong) CALayer *layer;

@property (nonatomic, strong) NSMutableArray <YHOCMonkeyGestureWithHash *>*gestures;

- (void)appendEvent:(UIEvent *)event;
@end


@implementation UIApplication(YHOCMonekyPaws)
- (void)monkey_sendEvent:(UIEvent *)event {
    for (YHOCMonkeyPaws *track in YHOCMonekyPawsTappingTracks) {
        [track appendEvent:event];
    }
    [self monkey_sendEvent:event];
}
@end

@class YHOCMonkeyGesture;
@interface YHOCMonkeyGestureWithHash : NSObject
@property (nonatomic, assign) NSUInteger gestureHash;
@property (nonatomic, strong) YHOCMonkeyGesture *gesture;
@end

@implementation YHOCMonkeyGestureWithHash
@end

@interface YHOCMonkeyGesture:NSObject
@property (nonatomic, strong) NSMutableArray *points;
@property (nonatomic, assign) NSUInteger number;

- (instancetype)initFrom:(CGPoint)point
                 inLayer:(CALayer *)layer
        bezierPathDrawer:(BezierPathDrawer)bezierPathDrawer;
@end

@implementation YHOCMonkeyGesture {
    CALayer         *containerLayer;
    CAShapeLayer    *startLayer;
    CATextLayer     *numberLayer;
    CAShapeLayer    *pathLayer;
    CAShapeLayer    *endLayer;
    UIColor         *color;
    
}

static NSUInteger YHOCMonkeyGestureCounter = 0;
- (instancetype)initFrom:(CGPoint)point
                 inLayer:(CALayer *)layer
        bezierPathDrawer:(BezierPathDrawer)bezierPathDrawer {
    self = [super init];
    if (self) {
        NSValue *pointObj = [NSValue valueWithCGPoint:point];
        self.points = @[pointObj].mutableCopy;
        NSUInteger counter = YHOCMonkeyGestureCounter;
        YHOCMonkeyGestureCounter ++;
        color = [self pawsColor:counter];
        
        containerLayer = [CALayer layer];
        startLayer = [CAShapeLayer layer];
        numberLayer = [CATextLayer layer];
        endLayer = [CAShapeLayer layer];
        
        
        startLayer.path = customize(bezierPathDrawer(), counter).CGPath;
        startLayer.strokeColor = color.CGColor;
        startLayer.fillColor = nil;
        startLayer.position = point;
        [containerLayer addSublayer:startLayer];
        
        
        numberLayer.string = @"1";
        numberLayer.bounds = CGRectMake(0, 0, 32, 13);
        numberLayer.fontSize = 10;
        numberLayer.alignmentMode = kCAAlignmentCenter;
        numberLayer.foregroundColor = color.CGColor;
        numberLayer.position = point;
        numberLayer.contentsScale = UIScreen.mainScreen.scale;
        [containerLayer addSublayer:numberLayer];
        [layer addSublayer:containerLayer];
    }
    return self;
}

- (void)dealloc {
    [containerLayer removeFromSuperlayer];
}

- (void)setNumber:(NSUInteger)number {
    _number = number;
    numberLayer.string =  [NSString stringWithFormat:@"%lu", number];
    CGFloat fraction = (CGFloat)(number-1)/(CGFloat)(YHOCMonkeyPawsConfig.maxShown);
    CGFloat alpha = sqrt(1 - fraction);
    containerLayer.opacity = alpha;
}

- (void)extendToPoint:(CGPoint)toPoint {
    CGPathRef startPath =  startLayer.path;
    NSValue *startPointValue = self.points.firstObject;
    if (!startPointValue) return;
    CGPoint startPoint = [startPointValue CGPointValue];
    [self.points addObject:[NSValue valueWithCGPoint:toPoint]];
    if (!pathLayer) {
        CAShapeLayer *newLayer = [CAShapeLayer layer];
        newLayer.strokeColor = startLayer.strokeColor;
        newLayer.fillColor = nil;
        
        CGMutablePathRef maskPath = CGPathCreateMutable();
        CGPathAddRect(maskPath, nil, CGRectMake(-10000, -10000, 20000, 20000));

        CGPathAddPath(maskPath, nil, startPath);
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = maskPath;
        maskLayer.fillRule = kCAFillRuleEvenOdd;
        maskLayer.position = startLayer.position;
        newLayer.mask  = maskLayer;
        
        pathLayer = newLayer;
        [containerLayer addSublayer:pathLayer];
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y);
    NSMutableArray *pointsCopy = self.points.mutableCopy;
    [pointsCopy removeObject:pointsCopy.firstObject];
    for (NSValue *pointValue in pointsCopy) {
        CGPoint point = [pointValue CGPointValue];
        CGPathAddLineToPoint(path, nil, point.x, point.y);
    }
    
    pathLayer.path  = path;
    
}

- (void)endAt:(CGPoint)point {
    if (!endLayer) {
        @throw [NSException exceptionWithName:NSStringFromClass([self class])
                                       reason:@"endLayer should not be nil"
                                     userInfo:nil];
        return;
    }
    [self extendToPoint:point];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = startLayer.strokeColor;
    layer.fillColor = nil;
    layer.position = point;
    
    UIBezierPath *path = circlePath(YHOCMonkeyRadiusConfig.circle);
    layer.path = path.CGPath;
    [containerLayer addSublayer:layer];
    endLayer = layer;
}


- (void)cancelAt:(CGPoint)point {
    if (!endLayer) {
        @throw [NSException exceptionWithName:NSStringFromClass([self class])
                                       reason:@"endLayer should not be nil"
                                     userInfo:nil];
        return;
    }
    [self extendToPoint:point];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = startLayer.strokeColor;
    layer.fillColor = nil;
    layer.position = point;
    
    UIBezierPath *path = crossPath(YHOCMonkeyRadiusConfig.cross);
    layer.path = path.CGPath;
    [containerLayer addSublayer:layer];
    endLayer = layer;
    
}

- (UIColor *)pawsColor:(NSInteger)seed {
    return [[UIColor alloc] initWithHue:(CGFloat)(fmod(seed * 0.391, 1))
                             saturation:1
                             brightness:0.5
                                  alpha:1];
}


@end




@implementation YHOCMonkeyPaws

- (instancetype)initWithView:(UIView *)view {
    return [self initWithView:view
             tapUIApplication:YES
             bezierPathDrawer:YHOCMonkeyPawDrawer.monkeyHandPath];
}

- (instancetype)initWithView:(UIView *)view
            tapUIApplication:(BOOL)tapUIApplication
            bezierPathDrawer:(BezierPathDrawer)bezierPathDrawer {
    self = [super init];
    if (self) {
        self.gestures = @[].mutableCopy;
        self.bezierPathDrawer = bezierPathDrawer;
        YHOCMonekyPawsTappingTracks = @[].mutableCopy;
        
        self.view           = view;
        self.layer          = [CALayer layer];
        self.layer.delegate = self;
        self.layer.opaque   = NO;
        self.layer.frame    =  view.layer.bounds;
        self.layer.contentsScale = UIScreen.mainScreen.scale;
        self.layer.rasterizationScale = UIScreen.mainScreen.scale;
        [self.view.layer addSublayer:self.layer];
        if(tapUIApplication) {
            [self tapUIApplicationSendEvent];
        }
    }
    return self;
}


- (void)tapUIApplicationSendEvent {
    [YHOCMonkeyPaws swizzleMethods];
    [YHOCMonekyPawsTappingTracks addObject:self];
}




+ (void)swizzleMethods {
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        
        Class class = [UIApplication class];
        SEL originalSelector = @selector(sendEvent:);
        SEL swizzledSelector = @selector(monkey_sendEvent:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod = class_addMethod(class,originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
}

- (void)appendEvent:(UIEvent *)event {
    if (!(event.type == UIEventTypeTouches)) return;
    NSSet *touches = event.allTouches;
    if (!touches) return;
    for (UITouch *touch in touches) {
        [self appendTouch:touch];
    }
    [self bumpAndDisplayLayer];
}

- (void)appendTouch:(UITouch *)touch {
    
    if (!self.view) return;
    
    NSUInteger touchHash = touch.hash;
    CGPoint point = [touch locationInView:self.view];
    __block NSInteger index = -1;
    [self.gestures enumerateObjectsUsingBlock:
     ^(YHOCMonkeyGestureWithHash *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.gestureHash == touchHash) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index != -1) {
        YHOCMonkeyGestureWithHash *obj = self.gestures[index];
        YHOCMonkeyGesture *gesture = obj.gesture;
        if (touch.phase == UIPressPhaseEnded) {
            [gesture endAt:point];
            obj.gestureHash = 0;
        } else if (touch.phase == UIPressPhaseCancelled) {
            [gesture cancelAt:point];
            obj.gestureHash = 0;
        } else {
            [gesture extendToPoint:point];
        }
    } else {
        if (self.gestures.count > YHOCMonkeyPawsConfig.maxShown) {
            id firstObj = self.gestures.firstObject;
            [self.gestures removeObject:firstObj];
        }
        YHOCMonkeyGesture *gesture = [[YHOCMonkeyGesture alloc] initFrom:point inLayer:self.layer bezierPathDrawer:self.bezierPathDrawer];
        YHOCMonkeyGestureWithHash *gestureWithHash = [YHOCMonkeyGestureWithHash new];
        gestureWithHash.gestureHash = touchHash;
        gestureWithHash.gesture = gesture;
        [self.gestures addObject:gestureWithHash];
        
        for (NSUInteger idx = 0; idx < self.gestures.count; idx ++) {
            NSInteger number = self.gestures.count - idx;
            YHOCMonkeyGesture *gesture = self.gestures[idx].gesture;
            gesture.number = number;
        }
    }
    
}

- (void)bumpAndDisplayLayer {
    CALayer *superLayer = self.layer.superlayer;
    if (!superLayer) return;
    NSArray *layers = [superLayer sublayers];
    if (!layers) return;
    
    NSUInteger index = [layers indexOfObject:self.layer];
    
    if (index != layers.count - 1) {
        [self.layer removeFromSuperlayer];
        [superLayer addSublayer:self.layer];
    }
    
    self.layer.frame = superLayer.bounds;
    [self.layer setNeedsDisplay];
    [self.layer displayIfNeeded];
    
}
@end


