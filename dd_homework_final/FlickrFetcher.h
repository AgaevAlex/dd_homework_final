//
//  FlickrFetcher.h
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLICKR_RESULTS_PHOTOS @"photos.photo"
#define FLICKR_RESULTS_TAGS @"hottags.tag"
#define FLICKR_PHOTO_TITLE @"title"
#define FLICKR_PHOTO_DESCRIPTION @"description._content"

#define FLICKR_LATITUDE @"latitude"
#define FLICKR_LONGITUDE @"longitude"
#define FLICKR_TAGS @"tags"

typedef enum {
    FlickrPhotoFormatSquare = 1,    
    FlickrPhotoFormatLarge = 2,
    FlickrPhotoFormatOriginal = 64
} FlickrPhotoFormat;


@interface FlickrFetcher : NSObject

+ (NSURL *)URLforHotTags;
+ (NSURL *)URLforPhotos:(id)tag maxResults:(int)maxResults;

+ (NSURL *)URLforPhoto:(NSDictionary *)photo format:(FlickrPhotoFormat)format;
@end
