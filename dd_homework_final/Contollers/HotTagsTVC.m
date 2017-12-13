//
//  HotTagsTVC.m
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//

#import "HotTagsTVC.h"
#import "FlickrFetcher.h"
#import "CollectionFlickrPhotos.h"
@interface HotTagsTVC ()



@property (nonatomic, strong) NSMutableArray *HotTags;

@end


@implementation HotTagsTVC



- (void)setTags:(NSArray *)tags
{
    _tags = tags;
    [self createPlacesByCountryForPlaces:_tags];
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
         });
}


-(void)createPlacesByCountryForPlaces:(NSArray *)place
{
    NSMutableArray *HotTags = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *tag in _tags) {
        [HotTags addObject:[tag objectForKey:@"_content"]];
        
    }
    
    self.HotTags = HotTags;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{

    return self.HotTags.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Hot Tags";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    
    cell.textLabel.text = self.HotTags[indexPath.row];
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath =[self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"HotCollection"]) {
                if ([segue.destinationViewController isKindOfClass:[CollectionFlickrPhotos class]]) {
                    
               
                    NSDictionary *place = self.HotTags[indexPath.row];
                    
                    [segue.destinationViewController setTag:place ];
                    [segue.destinationViewController setTitle:[[sender textLabel] text]];
                }
            }
        }
    }
}



@end

