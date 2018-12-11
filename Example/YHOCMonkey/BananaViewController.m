//
//  ViewController.m
//  YHOCMonkey
//
//  Created by pencilCool on 2018/11/30.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "BananaViewController.h"

@interface BananaViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *banana;

@property (nonatomic, assign) CGPoint maxOffset;
@property (nonatomic, assign) CGFloat maxYOffset;
@property (nonatomic, assign) CGAffineTransform currentTransform;
@end

@implementation BananaViewController {
    CGPoint offset;
    CGFloat scale;
    CGFloat angle;
    
    CGFloat maxScale;
    CGFloat minScale;
    
    CGPoint startOffSet;
    CGFloat startScale;
    
    CGFloat startAngle;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        offset  = CGPointZero;
        scale   = 1;
        angle   = 0;
        
        maxScale = 2;
        minScale = 1/2;
        
        startOffSet = CGPointZero;
        startScale = 0;
        startAngle = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
}

- (void)addGesture {
    UIPanGestureRecognizer *pan =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pannedWith:)];
    [self.view addGestureRecognizer:pan];
    
    UIPinchGestureRecognizer *pinch =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchedWith:)];
    [self.view addGestureRecognizer:pinch];
    
    UIRotationGestureRecognizer *rotate =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatedWith:)];
    [self.view addGestureRecognizer:rotate];
    
    UITapGestureRecognizer *bananaTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bananaTapped:)];
    [self.banana addGestureRecognizer:bananaTap];
}

- (void)pannedWith:(UIPanGestureRecognizer *)recogniser {
  
    if (recogniser.state == UIGestureRecognizerStateBegan) {
        startOffSet = offset;
    } else {
        CGPoint translation =  [recogniser translationInView:self.view];
        offset.x = startOffSet.x + translation.x;
        offset.y = startOffSet.y + translation.y;
        
        CGPoint max = self.maxOffset;
        if (offset.x > max.x) {offset.x = max.x;}
        if (offset.y > max.y) {offset.y = max.y;}
        if (offset.x < - max.x) {offset.x = - max.x;}
        if (offset.y < - max.y) {offset.y = - max.y;}
    }
    if (self.banana) {
        self.banana.transform = self.currentTransform;
    }
}


- (void)pinchedWith:(UIPinchGestureRecognizer *)recogniser {
    if (recogniser.state == UIGestureRecognizerStateBegan) {
        startScale = scale;
    } else {
        scale = startScale * recogniser.scale;
        if (scale > maxScale) {
            scale = maxScale;
        }
        if (scale < minScale) {
            scale = minScale;
        }
        if (self.banana) {
            self.banana.transform = self.currentTransform;
        }
    }
}


- (void)rotatedWith:(UIRotationGestureRecognizer *)recogniser {
    if (recogniser.state == UIGestureRecognizerStateBegan) {
        startAngle = angle;
    } else {
        angle = startAngle + recogniser.rotation;
        if (self.banana) {
            self.banana.transform = self.currentTransform;
        }
    }
}

- (void)bananaTapped:(UITapGestureRecognizer *)recogniser {
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        NSUInteger steps = 24;
        for (int i = 0; i < steps; i ++) {
            double frameLength = 1.0 / steps;
            double startTime = i * frameLength;
            double endTime =  (i+1) * frameLength;
            double curve = (1 - cos(2 * M_PI *endTime *3)) / 2 * exp(-endTime * 5);
            CGFloat scale = (CGFloat)(1 + 0.5 * curve);
            [UIView addKeyframeWithRelativeStartTime:startTime relativeDuration:frameLength animations:^{
                self.banana.transform = CGAffineTransformScale(self.currentTransform, scale, scale);
            }];
        }
    } completion:nil];
}



#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (CGAffineTransform)currentTransform {
    CGAffineTransform
    t = CGAffineTransformMakeScale(scale,scale);
    t = CGAffineTransformRotate(t,angle);
    t = CGAffineTransformTranslate(t, offset.x, offset.y);
    
    return t;
}

- (CGPoint)maxOffset {
    CGSize size = self.view.frame.size;
    CGFloat bananaWidth  = (self.banana)?(self.banana.frame.size.width):0;
    CGFloat bananaHeight = (self.banana)?(self.banana.frame.size.height):0;
    return CGPointMake(size.width - bananaWidth/2 , size.height - bananaHeight/2);
}

- (CGFloat)maxYOffset {
    CGSize size = self.view.frame.size;
    CGFloat bananaHeight = (self.banana)?(self.banana.frame.size.height):0;
    return (size.height - bananaHeight/2);
}
@end
