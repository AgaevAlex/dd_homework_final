//
//  CurrentHotTagsTVC.m
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//

#import "CurrentHotTagsTVC.h"
#import "FlickrFetcher.h"

@interface CurrentHotTagsTVC ()

@end

@implementation CurrentHotTagsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTopPlaces];
}

-(IBAction)fetchTopPlaces{
    [self.refreshControl beginRefreshing];
    
    NSURL *url = [FlickrFetcher URLforHotTags];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
                                      ^(NSURL *location, NSURLResponse *response, NSError *error) {
                                          if (!error) {
                                              NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                                              NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                                                      options:0
                                                                                                        error:NULL];
                                              NSArray *tags = [results valueForKeyPath:FLICKR_RESULTS_TAGS];
                                              self.tags =tags;
                                          }
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.refreshControl endRefreshing];
                                          });
                                      }];
    [task resume];
}

@end

