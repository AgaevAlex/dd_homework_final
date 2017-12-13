//
//  HotTagsTVC.m	
//  dd_homework_final
//
//  Created by Admin on 03.12.17.
//  Copyright © 2017 Alex Agaev. All rights reserved.
//

#import "HotTagsTVC.h"
#import "FlickrFetcher.h"

@interface HotTagsTVC ()


@property (nonatomic, strong) NSMutableArray *HotTags;

@end


@implementation HotTagsTVC



- (void)setTags:(NSArray *)tags
{
    _tags = tags;
    [self createHotTags:_tags];
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
         });
}


-(void)createHotTags:(NSArray *)tags
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




@end

