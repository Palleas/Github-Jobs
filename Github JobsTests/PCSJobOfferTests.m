//
//  PCSJobOfferTests.m
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-06-05.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCSJobOffer.h"

@interface PCSJobOfferTests : XCTestCase

@property (nonatomic, copy) NSDictionary *jobPayload;

@end

@implementation PCSJobOfferTests

- (void)setUp
{
    [super setUp];

    NSString *path = [[NSBundle bundleForClass: [self class]] pathForResource: @"job" ofType: @"json"];
    NSData *content = [NSData dataWithContentsOfFile: path];

    NSError *jsonError = nil;
    self.jobPayload = [NSJSONSerialization JSONObjectWithData: content options: 0 error: &jsonError];
    XCTAssertNil(jsonError, @"The Job payload should be loaded without error, got %@", jsonError);
    XCTAssertNotNil(self.jobPayload, @"The job payload should be properly loaded");
    XCTAssertTrue([self.jobPayload isKindOfClass: [NSDictionary class]], @"Job payload should be a dictionary");
}

- (void)tearDown
{
    self.jobPayload = nil;

    [super tearDown];
}

- (void)testThatDictionaryIsProperlyMappedToProperties {
    PCSJobOffer *offer = [[PCSJobOffer alloc] initWithPayload: self.jobPayload];
    XCTAssertEqualObjects([NSURL URLWithString: @"http://jobs.github.com/positions/abced-fghij-klmnop-1234567"], offer.url, @"URL should be http://jobs.github.com/positions/abced-fghij-klmnop-1234567");
    XCTAssertEqualObjects(@"iOS developer", offer.title, @"Title of the job offer should be \"iOS developer\"");
    XCTAssertEqualObjects(@"Bay Area, CA", offer.location, @"Location of the job offer soulld be \"Bay Area, CA\"");
}

@end
