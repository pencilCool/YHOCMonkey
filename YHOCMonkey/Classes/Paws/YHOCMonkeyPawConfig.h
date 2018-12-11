//
//  YHOCMonkeyPawConfig.h
//  YHOCMonkey
//
//  Created by pencilCool on 2018/12/1.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YHOCMonkeyPawsColor) {
    YHOCMonkeyPawsColor_randomized,
    YHOCMonkeyPawsColor_constant,
};
@interface YHOCMonkeyPawsConfig:NSObject
+ (YHOCMonkeyPawsColor)color;
+ (CGFloat)brightness;
+ (NSUInteger)maxShown;
@end


@interface YHOCMonkeyRadiusConfig:NSObject
+ (CGFloat)cross;
+ (CGFloat)circle;
@end



NS_ASSUME_NONNULL_END


