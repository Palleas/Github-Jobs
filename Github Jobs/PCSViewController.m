//
//  PCSViewController.m
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-03-16.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import "PCSViewController.h"
#import "PCSJobOffer.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface PCSViewController ()

@property (nonatomic, strong) NSArray *jobs;

@end

@implementation PCSViewController

- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear: animated];
    
    NSURL *url = [NSURL URLWithString: @"https://jobs.github.com/positions.json?description=ios&location=NY"];

    NSURLSessionDataTask *jobTask = [[NSURLSession sharedSession] dataTaskWithURL: url
                                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                    if (error) {
                                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                                            [SVProgressHUD dismiss];
                                                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"An error occured"
                                                                                                                            message: error.localizedDescription delegate: nil
                                                                                                                  cancelButtonTitle: @"Meh"
                                                                                                                  otherButtonTitles: nil];
                                                                            [alert show];
                                                                        });
                                                                        return;
                                                                    }

                                                                    NSError *jsonError = nil;



                                                                    NSArray *results = [NSJSONSerialization JSONObjectWithData: data
                                                                                                                options: 0
                                                                                                                  error: &jsonError];
                                                                    NSMutableArray *jobs = [NSMutableArray array];
                                                                    [results enumerateObjectsUsingBlock:^(NSDictionary *jobPayload, NSUInteger idx, BOOL *stop) {
                                                                        [jobs addObject: [[PCSJobOffer alloc] initWithPayload: jobPayload]];
                                                                    }];

                                                                    self.jobs = jobs;

                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        [SVProgressHUD showSuccessWithStatus: [NSString stringWithFormat: @"%lu jobs fetched", (unsigned long)[self.jobs count]] ];
                                                                        [self.tableView reloadData];
                                                                    });
                                                                }];
    [SVProgressHUD showWithStatus: @"Fetching jobs..." maskType: SVProgressHUDMaskTypeBlack];
    [jobTask resume];
}


#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PCSJobOffer *offer = self.jobs[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = offer.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *jobUrl = [NSURL URLWithString: self.jobs[indexPath.row][@"url"]];
    [[UIApplication sharedApplication] openURL: jobUrl];
}

@end
