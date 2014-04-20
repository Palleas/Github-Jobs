//
//  PCSGithubJob.h
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-03-26.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCSGithubJob : NSObject

@property (nonatomic, copy) NSDictionary *includedServices;

- (BOOL)willMakeYouHappy;

@end
