//
//  PCSJobOffer.h
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-06-05.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCSJobOffer : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSURL *url;

@end
