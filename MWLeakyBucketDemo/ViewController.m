//
//  ViewController.m
//  MWLeakyBucketDemo
//
//  Created by Wenzhong Zhang on 2015-07-09.
//  Copyright (c) 2015 MagniWare Ltd. All rights reserved.
//

#import "ViewController.h"
#import "MWLeakyBucket.h"

@interface ViewController () <MWLeakyBucketDelegate>

@end

@implementation ViewController {
    MWLeakyBucket *leakybucket;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    leakybucket = [[MWLeakyBucket alloc] initBucketWithCapacity:30];
    leakybucket.delegate = self;
    leakybucket.sampleRate = @(2);
    // Note that the bucket is FIFO
    [leakybucket fillBucketWithSamples:@[@{@"sampleTypeA":@(1)},
                                         @{@"sampleTypeA":@(2)},
                                         @{@"sampleTypeA":@(3)},
                                         @{@"sampleTypeA":@(4)},
                                         @{@"sampleTypeA":@(5)},
                                         @{@"sampleTypeA":@(6)},
                                         @{@"sampleTypeA":@(7)},
                                         @{@"sampleTypeA":@(8)},
                                         @{@"sampleTypeA":@(9)},
                                         @{@"sampleTypeA":@(10)},
                                         // More key-value pairs can be added.
                                         @{@"sampleTypeB":@(11),
                                           @"sampleTypeB":@(11)},
                                         @{@"sampleTypeB":@(12),
                                           @"sampleTypeB":@(12)},
                                         @{@"sampleTypeB":@(13),
                                           @"sampleTypeB":@(13)},
                                         @{@"sampleTypeB":@(14),
                                           @"sampleTypeB":@(14)},
                                         @{@"sampleTypeB":@(15),
                                           @"sampleTypeB":@(15)},
                                         // Funny types
                                         @{@"horizontal":@(16),
                                           @"vertical":@(16)},
                                         @{@"chicken":@(17),
                                           @"egg":@(17)},
                                         @{@"x":@(18),
                                           @"y":@(18)},
                                         @{@"x":@(19),
                                           @"y":@(19),
                                           @"z":@(19)},
                                         @{@"a":@(20),
                                           @"b":@(20)},
                                         @{@"yes":@(21),
                                           @"no":@(21)}]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bucketDidLeakSample:(NSNumber *)sample {
    NSLog(@"%@", sample);
}

@end
