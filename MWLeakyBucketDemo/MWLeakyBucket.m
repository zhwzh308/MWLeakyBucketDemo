//
//  MWLeakyBucket.m
//  MWLeakyBucketDemo
//
//  Created by Wenzhong Zhang on 2015-07-09.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 MagniWare Ltd. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "MWLeakyBucket.h"

@implementation MWLeakyBucket {
    /**
     *  The time interval between each leaked data.
     */
    double drainRate;
    /**
     *  Timer to trigger the next leakage event.
     */
    NSTimer *bucketHole;
}

@synthesize sampleRate = _sampleRate;

- (instancetype)init {
    self = [super init];
    if (self) {
        // default size
        self.bucket = [[NSMutableArray alloc] initWithCapacity:24];
        bucketHole = nil;
    }
    return self;
}

- (instancetype)initBucketWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (self) {
        self.bucket = [[NSMutableArray alloc] initWithCapacity:capacity];
        bucketHole = nil;
    }
    return self;
}

- (void)fillBucketWithSamples:(NSArray *)samples {
    [self.bucket addObjectsFromArray:samples];
    if (!bucketHole) {
        [self drainBucket];
    }
}

- (void)addSampleToBucket:(NSNumber *)sample {
    [self.bucket addObject:sample];
    if (!bucketHole) {
        [self drainBucket];
    }
}

- (void)emptyBucket {
    [self.bucket removeAllObjects];
    [self stopBucketDrain];
}

- (NSUInteger)bucketSize {
    NSUInteger bucketsize = 0;
    if (self.bucket) {
        bucketsize = [self.bucket count];
    }
    return bucketsize;
}

/**
 *  Setter to change the bucket draining rate.
 *
 *  @param sampleRate The sample rate in Hz.
 */
- (void)setSampleRate:(NSNumber *)sampleRate {
    _sampleRate = sampleRate;
    drainRate = 1.0 / sampleRate.doubleValue;
    [self resizeBucketHole];
}

#pragma mark - Bucket actions

/**
 *  Leak sample, notify subscriber of the leaked object.
 */
- (void)leakSample {
    NSNumber *sample = [self.bucket lastObject];
    if (sample) {
        [self.bucket removeLastObject];
        [self.delegate bucketDidLeakSample:sample];
    } else {
        [self stopBucketDrain];
    }
}

/**
 *  Start draining the bucket.
 */
- (void)drainBucket {
    bucketHole = [NSTimer scheduledTimerWithTimeInterval:drainRate
                                                  target:self
                                                selector:@selector(leakSample)
                                                userInfo:nil
                                                 repeats:YES];
}

/**
 *  Refresh timer to reflect the updates to the sample rate.
 */
- (void)resizeBucketHole {
    if (bucketHole) {
        [bucketHole invalidate];
        [self drainBucket];
    }
}

/**
 *  Stop the bucket drain.
 */
- (void)stopBucketDrain {
    if (bucketHole) {
        [bucketHole invalidate];
        bucketHole = nil;
    }
}

@end
