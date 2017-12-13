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
+ (NSURL *)URLforPhotosInPlace:(id)tag maxResults:(int)maxResults;
{
    return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&tags=%@&per_page=%d", tag, maxResults]];
}
+ (NSURL *)URLforPhoto:(NSDictionary *)photo format:(FlickrPhotoFormat)format;
{
    return [NSURL URLWithString:[self urlStringForPhoto:photo format:format]];
}
+ (NSString *)urlStringForPhoto:(NSDictionary *)photo format:(FlickrPhotoFormat)format
{
    id farm = [photo objectForKey:@"farm"];
    id server = [photo objectForKey:@"server"];
    id photo_id = [photo objectForKey:@"id"];
    id secret = [photo objectForKey:@"secret"];
    if (format == FlickrPhotoFormatOriginal) secret = [photo objectForKey:@"originalsecret"];
    
    NSString *fileType = @"jpg";
    if (format == FlickrPhotoFormatOriginal) fileType = [photo objectForKey:@"originalformat"];
    
    if (!farm || !server || !photo_id || !secret) return nil;
    
    NSString *formatString = @"s";
    switch (format) {
        case FlickrPhotoFormatSquare:    formatString = @"s"; break;
        case FlickrPhotoFormatLarge:     formatString = @"b"; break;
        case FlickrPhotoFormatOriginal:  formatString = @"o"; break;
    }
    return [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_%@.%@", farm, server, photo_id, secret, formatString, fileType];
}
@end
