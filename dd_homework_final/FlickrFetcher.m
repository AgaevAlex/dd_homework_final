//
//  FlickrFetcher.m
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//
#import "FlickrFetcher.h"
#import "FlickrAPIKey.h"

@implementation FlickrFetcher

+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString
             stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@",
             query, FlickrAPIKey];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    query = [query stringByAddingPercentEncodingWithAllowedCharacters:set];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforHotTags

{
    return [self URLForQuery:@"https://api.flickr.com/services/rest/?method=flickr.tags.getHotList&period=week&count=10"];
}
+ (NSURL *)URLforPhotos:(id)tag maxResults:(int)maxResults;
{
    return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&tags=%@&per_page=%d", tag, maxResults]];
}


@end
