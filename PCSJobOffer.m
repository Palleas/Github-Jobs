//
//  PCSJobOffer.m
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-06-05.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import "PCSJobOffer.h"

@implementation PCSJobOffer

- (instancetype)initWithPayload:(NSDictionary *)payload {
    self = [super init];
    if (self) {
        self.title = @"No job for you!"; //= payload[@"title"];
        self.url = [NSURL URLWithString: payload[@"url"]];
        self.location = payload[@"location"];
    }

    return self;
}

@end
