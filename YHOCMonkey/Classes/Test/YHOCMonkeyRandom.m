//
//  YHOCMonkeyRandom.m
//  YHOCMonkeyUITests
//
//  Created by pencilCool on 2018/12/8.
//  Copyright © 2018 pencilCool. All rights reserved.
//

#import "YHOCMonkeyRandom.h"
#import <math.h>
@implementation YHOCMonkeyRandom {
    uint64_t state;
    uint64_t increment;
}

- (instancetype)init {
    return [self initWithSeed:0];
}
- (instancetype)initWithSeed:(uint32_t)seed {
    return [self initWithSeed:0 sequence:0];
}
- (instancetype)initWithSeed:(uint32_t)seed sequence:(uint32_t)sequence {
    self = [super init];
    if (self) {
        state = 0;
        increment = ((uint64_t)sequence << 1) | 1;
        [self randomUInt32];
        state = state + (uint64_t)seed;
        [self randomUInt32];
    }
    return self;
}

- (uint32_t)randomUInt32 {
    uint64_t oldstate = state;
    state = oldstate * 6364136223846793005 + increment;
    uint32_t xorshifted = (uint32_t)((uint32_t)(((oldstate >> 18)^oldstate) >> 27) & 0xffffffff);
    uint32_t rot = (uint32_t)(oldstate >> 59);
    uint32_t result = (xorshifted >> rot) | (xorshifted << (uint32_t)(-(int)(rot) & 31));
    
    return result;
}
    

- (NSInteger)randomIntLessThan:(NSInteger)limit {
    uint32_t random =  [self randomUInt32];
    return (NSInteger)(random % (uint32_t)limit);
}

- (NSUInteger)randomUIntLessThan:(NSUInteger)limit {
    uint32_t random =  [self randomUInt32];
    return (NSUInteger)(random % (uint32_t)limit);
}

- (float)randomFloat {
    return (float)([self randomUInt32] / 4294967296.0);
}
- (float)randomFloatLessThan:(float)limit {
    return [self randomFloat] * limit;
}

- (double)randomDouble {
    return (double)([self randomUInt32] / 4294967296.0);
}
- (double)randomDoubleLessThan:(double)limit {
    return [self randomDouble] * limit;
}
@end
