//
//  PCSViewController.m
//  Github Jobs
//
//  Created by Romain Pouclet on 2014-03-16.
//  Copyright (c) 2014 Perfectly Cooked. All rights reserved.
//

#import "PCSViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface PCSViewController ()

@property (nonatomic, strong) NSArray *jobs;

@end

@implementation PCSViewController

- (void)viewWillAppear:(BOOL)animated {
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
                                                                    self.jobs = [NSJSONSerialization JSONObjectWithData: data
                                                                                                                options: 0
                                                                                                                  error: &jsonError];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.jobs[indexPath.row][@"title"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *jobUrl = [NSURL URLWithString: self.jobs[indexPath.row][@"url"]];
    [[UIApplication sharedApplication] openURL: jobUrl];
}

@end
