//
//  PCSGithubJobTests.m
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-03-26.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCSGithubJob.h"

@interface PCSGithubJobTests : XCTestCase

@end

@implementation PCSGithubJobTests

- (void)testAJobProvidingLaundryWillMakeYouHappy {
    PCSGithubJob *job = [[PCSGithubJob alloc] init];
    job.includedServices = @{@"laundry" : @YES};

    XCTAssertTrue([job willMakeYouHappy], @"A job handling your laundry should make you happy");
}

@end
