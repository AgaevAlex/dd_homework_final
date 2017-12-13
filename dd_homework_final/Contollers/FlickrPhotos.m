//
//  FlickrPhotos.m
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//
#import "FlickrPhotos.h"
#import "FlickrFetcher.h"

@interface FlickrPhotos ()



@end

@implementation FlickrPhotos

-(void)setPhotos:(NSArray *)photos
{
    _photos =photos;
    [self.tableView reloadData];
}


#define FLICKR_UNKNOWN_PHOTO @"Unknown"

-(NSString *)titleForRow:(NSUInteger)row
{
    NSString *titleCell = [self.photos[row] valueForKeyPath:FLICKR_PHOTO_TITLE];
    if ([titleCell length]== 0) {
        titleCell = [self.photos[row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        if ([titleCell length]== 0) {
            titleCell = FLICKR_UNKNOWN_PHOTO;
        }
    }
    return titleCell;
    
}

-(NSString *)subTitleForRow:(NSUInteger)row
{
    NSString *subTitle = [self.photos[row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    
    if ([[self titleForRow:row] isEqualToString:subTitle] ||
        [[self titleForRow:row] isEqualToString:FLICKR_UNKNOWN_PHOTO]) {
        subTitle = @"";
    }
    return subTitle;
    
}

#pragma mark - UITableViewDaraSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
                                        numberOfRowsInSection:(NSInteger)section
{
  
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
                                     cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subTitleForRow:indexPath.row];
    
    return cell;
}

#pragma mark - Navigation

@end
