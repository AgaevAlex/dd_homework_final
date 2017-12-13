//
//  PlaceFlickrPhotos.m
//  TopPlaces
//
//  Created by Tatiana Kornilova on 1/30/16.
//  Copyright © 2016 Tatiana Kornilova. All rights reserved.
//

#import "PlaceFlickrPhotos.h"
#import "FlickrFetcher.h"

@implementation PlaceFlickrPhotos
#define MAX_RESULTS 10


- (void)setPlace:(NSDictionary *)place
{
    _place = place;
    [self fetchPhotos];
}
- (IBAction)fetchPhotos
{
   
   NSURL *url = [FlickrFetcher URLforPhotosInPlace:self.place maxResults:MAX_RESULTS];
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

                   
                  });
              }];
    [task resume];
}

@end
