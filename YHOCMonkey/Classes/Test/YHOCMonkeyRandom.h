//
//  YHOCMonkeyRandom.h
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/8.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHOCMonkeyRandom : NSObject
- (instancetype)initWithSeed:(uint32_t)seed;
- (instancetype)initWithSeed:(uint32_t)seed sequence:(uint32_t)sequence;
- (uint32_t)randomUInt32;
- (NSInteger)randomIntLessThan:(NSInteger)limit;
- (NSUInteger)randomUIntLessThan:(NSUInteger)limit;
- (float)randomFloat;
- (float)randomFloatLessThan:(float)limit;
- (double)randomDouble;
- (double)randomDoubleLessThan:(double)limit;
@end

NS_ASSUME_NONNULL_END
