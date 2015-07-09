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
    [leakybucket fillBucketWithSamples:@[@(1), @(2), @(3), @(4), @(5), @(6), @(7), @(8), @(9), @(10), @(11), @(12), @(13), @(14), @(15), @(16), @(17), @(18), @(19), @(20), @(21)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bucketDidLeakSample:(NSNumber *)sample {
    NSLog(@"%@", sample);
}

@end
