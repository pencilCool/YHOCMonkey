//
//  YHOCMonekyPaws.h
//  YHOCMonkey
//
//  Created by pencilCool on 2018/12/1.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHOCMonkeyHeader.h"
#import "YHOCMonkeyPawConfig.h"
NS_ASSUME_NONNULL_BEGIN
@class YHOCMonkeyPawConfig;
@interface YHOCMonkeyPaws : NSObject

- (nullable instancetype)initWithView:(UIView *)view;

- (nullable instancetype)initWithView:(UIView *)view
            tapUIApplication:(BOOL)tapUIApplication
            bezierPathDrawer:(BezierPathDrawer)bezierPathDrawer;
@end

NS_ASSUME_NONNULL_END
