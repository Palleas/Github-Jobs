//
//  PCSAppDelegate.m
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-03-16.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import "PCSAppDelegate.h"

@implementation PCSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *endpoint = [[NSBundle bundleForClass: [self class]] infoDictionary][@"GithubJobsEndpoint"];
    NSLog(@"Endpoint = %@", endpoint);

    NSLog(@"Hi, I'm a sample application for a book.");
    return YES;
}

@end
