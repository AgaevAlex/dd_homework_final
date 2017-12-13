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
@interface HotTagsTVC () <UITextFieldDelegate>



@property (nonatomic, strong) NSMutableArray *HotTags;
@property (strong, nonatomic) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *HotTagss;

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


-(void)createHotTags:(NSArray *)place
{
    NSMutableArray *HotTags = [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *tag in _tags) {
        [HotTags addObject:[tag objectForKey:@"_content"]];
        
    }
    
    self.HotTags = HotTags;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, 30.0)];
    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.backgroundColor = [UIColor lightGrayColor];
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTextField.delegate = self;
    
}
- (IBAction)showSearchPhotoByTextField:(id)sender {
    if (self.tableView.tableHeaderView) {
        [self showHeaderWithTextField:nil];
        [self.searchTextField endEditing:YES];
    } else {
        [self showHeaderWithTextField:self.searchTextField];
        [self.searchTextField becomeFirstResponder];
        self.searchTextField.text = @"Search";
        [self.searchTextField selectAll:nil];
    }
}

- (void)showHeaderWithTextField:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.tableHeaderView = textField;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.searchTextField) {
        if ([textField hasText]) {
            self.HotTagss = self.searchTextField.text;
            [self performSegueWithIdentifier:@"HotCollection" sender:self];
        }
        return NO;
    }
    return YES;
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
            if ([segue.identifier isEqual:@"HotCollection"]) {
                if ([segue.destinationViewController isKindOfClass:[CollectionFlickrPhotos class]]) {
                        NSDictionary *tag = self.HotTags[indexPath.row];
                        [segue.destinationViewController setTag:tag ];
                        [segue.destinationViewController setTitle:[[sender textLabel] text]];
                    }
                   
                }
            }
        }
    if ([segue.identifier isEqual:@"HotCollection"]) {
    if(self.HotTagss!=nil){
        NSDictionary *tag = self.HotTagss;
        [segue.destinationViewController setTag:tag ];
        [segue.destinationViewController setTitle:tag];
    }
    }
    }




@end

