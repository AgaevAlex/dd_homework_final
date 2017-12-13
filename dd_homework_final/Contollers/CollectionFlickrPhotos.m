//
//  PlaceFlickrPhotos.m
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//
#import "CollectionFlickrPhotos.h"
#import "FlickrFetcher.h"

@implementation CollectionFlickrPhotos
#define MAX_RESULTS 10


- (void)setTag:(NSDictionary *)tag
{
    _tag = tag;
    [self fetchPhotos];
}
- (IBAction)fetchPhotos
{
    [self.refreshControl beginRefreshing];
    
     [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.frame.size.height)
                             animated:YES];
    
   NSURL *url = [FlickrFetcher URLforPhotos: _tag maxResults:MAX_RESULTS] ;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
              ^(NSURL *location, NSURLResponse *response, NSError *error) {
                  if (!error) {
                      NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                      NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                              options:0
                                                                                error:NULL];
                      NSArray *photos =[results valueForKeyPath:FLICKR_RESULTS_PHOTOS];
                      self.photos =photos;
                  }
                  dispatch_async(dispatch_get_main_queue(), ^{
                      [self.refreshControl endRefreshing];
                  });
              }];
    [task resume];
}

@end
