//
//  FlickrFetcher.h
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLICKR_RESULTS_PHOTOS @"photos.photo"
#define FLICKR_PHOTO_TITLE @"title"
#define FLICKR_PHOTO_DESCRIPTION @"description._content"
#define FLICKR_PHOTO_ID @"id"
#define FLICKR_PHOTO_OWNER @"ownername"
#define FLICKR_PHOTO_UPLOAD_DATE @"dateupload"
#define FLICKR_PHOTO_PLACE_ID @"place_id"
#define FLICKR_PLACE_NAME @"_content"
#define FLICKR_PLACE_ID @"tag"
#define FLICKR_LATITUDE @"latitude"
#define FLICKR_LONGITUDE @"longitude"
#define FLICKR_TAGS @"tags"


@interface FlickrFetcher : NSObject

+ (NSURL *)URLforHotTags;
+ (NSURL *)URLforPhotos:(id)tag maxResults:(int)maxResults;
@end
