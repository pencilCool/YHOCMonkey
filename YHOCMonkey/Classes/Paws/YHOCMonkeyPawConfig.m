//
//  YHOCMonkeyPawConfig.m
//  YHOCMonkey
//
//  Created by pencilCool on 2018/12/1.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkeyPawConfig.h"
@implementation YHOCMonkeyPawsConfig
+ (YHOCMonkeyPawsColor)color {
    return YHOCMonkeyPawsColor_randomized;
}
+ (CGFloat)brightness {
    return 0.5;
}
+ (NSUInteger)maxShown {
    return 15;
}
@end


@implementation YHOCMonkeyRadiusConfig
+ (CGFloat)cross {
    return 7;
}
+ (CGFloat)circle {
    return 7;
}
@end


