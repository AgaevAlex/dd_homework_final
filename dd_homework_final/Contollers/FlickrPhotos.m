//
//  FlickrPhotos.m
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//
#import "FlickrPhotos.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"
@interface FlickrPhotos ()

@property (nonatomic,strong) ImageViewController *imageViewController;

@end

@implementation FlickrPhotos

-(void)setPhotos:(NSArray *)photos
{
    _photos =photos;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

  
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
  
    
    return cell;
}

#pragma mark - Navigation
-(void)prepareImageViewController:(ImageViewController *)ivc
                   toDisplayPhoto:(NSDictionary *)photo
                           forRow:(NSUInteger)row
{
    ivc.imageURL = [FlickrFetcher URLforPhoto:photo
                                       format:FlickrPhotoFormatLarge];
    ivc.title = [self titleForRow:row];
    ivc.navigationItem.leftBarButtonItem.title = self.title;
    ivc.navigationItem.leftBarButtonItem =
    self.splitViewController.displayModeButtonItem;
    ivc.navigationItem.leftItemsSupplementBackButton = YES;
    

    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        
        NSIndexPath *indexPath =[self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Display Photo"]) {
                id vc = segue.destinationViewController;
                id ivc =vc;
                if ([vc isKindOfClass:[UINavigationController class]]) {
                    ivc = [(UINavigationController  *)vc topViewController] ;
                }
                
                if ([ivc isKindOfClass:[ImageViewController class]]) {
                    self.imageViewController = ivc;
                    [self prepareImageViewController:ivc
                                      toDisplayPhoto:self.photos[indexPath.row]
                                              forRow:indexPath.row];
                    
                    
                }
            }
        }
    }
}
@end
