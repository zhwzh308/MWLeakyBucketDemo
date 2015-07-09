//
//  MWLeakyBucket.h
//  MWLeakyBuckeyDemo
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

@import Foundation;
/**
 *  Subscribers to this delegate will get notified when a sample was released from the FIFO queue.
 */
@protocol MWLeakyBucketDelegate <NSObject>

@required
/**
 *  MWLeakyBucketDelegate method to notify delegate that a new sample was leaked by the bucket.
 *
 *  @param sample A NSNumber representation of the sample value.
 */
- (void)bucketDidLeakSample: (NSNumber *)sample;

@end

/**
 *  MWLeakyBucket is a Objective-C FIFO Queue with addition of a variable rate leaky bucket. Currently it is loosely set to expect only NSNumber object in the queue. But you are free to expand it anyway you want.
 */
@interface MWLeakyBucket : NSObject

/**
 *  Object delegate requires you to implement bucketDidLeakSample: method in your own class.
 */
@property (weak) id <MWLeakyBucketDelegate> delegate;
/**
 *  The actual bucket which holds an array of NSNumber objects.
 */
@property (atomic, strong) NSMutableArray *bucket;
/**
 *  The rate data is supposed to be released from the bucket.
 */
@property (nonatomic) NSNumber *sampleRate;

/**
 *  Custom initialization method with a capacity constraint.
 *
 *  @param capacity The number of objects which the bucket can hold.
 *
 *  @return A sized leaky bucket.
 */
- (instancetype)initBucketWithCapacity: (NSUInteger)capacity;

/**
 *  Add one sample to the bucket.
 *
 *  @param sample The sample to be added.
 */
- (void)addSampleToBucket: (NSNumber *)sample;

/**
 *  Add an array of samples to the bucket. (No error checking implemented.
 *
 *  @param samples The array of objects to add into bucket.
 */
- (void)fillBucketWithSamples: (NSArray *)samples;

/**
 *  Remove all the objects from the bucket.
 */
- (void)emptyBucket;

/**
 *  The number of objects in the bucket.
 *
 *  @return An integer indicating the number of objects in the bucket.
 */
- (NSUInteger)bucketSize;

@end
