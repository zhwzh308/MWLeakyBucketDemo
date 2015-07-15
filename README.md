# MWLeakyBucketDemo

## Introduction
An Objective-C leaky bucket class with variable drain rate for numeric data.
You can customize the bucket capacity when initializing the object.
The expected object type in the bucket is `NSDictionary`.

## Usage
`MWLeakyBucket` is under MIT License. You can use it to smooth out data from
non-uniform data source by conforming your class to `MWLeakyBucketDelegate`.
The delegate method `- bucketDidLeakSample:` will emit data at a constant rate,
which can be changed by setting `sampleRate` property of the `MWLeakyBucket`
instance.

## Background
Leaky bucket is commonly used in traffic shaping (i.e. on a computer network)
where regulation is required for non-uniform data stream.
