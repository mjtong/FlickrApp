//
//  FlickrPhotoTVC.m
//  Shutterbug
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "FlickrPhotoTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"
#import "PlacePicsFlickrPhotoTableViewController.h"

@implementation FlickrPhotoTableViewController 
// sets the Model
// reloads the UITableView (since Model is changing)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}



#pragma mark - UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the title out of it
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *photoItems = [FlickrFetcher photosAtPlace:self.photos[indexPath.row][@"place_id"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            PlacePicsFlickrPhotoTableViewController *placePicsViewController = [[PlacePicsFlickrPhotoTableViewController alloc] initWithNibName:@"GenericTableView" bundle:nil];
            
            [placePicsViewController performSelector:@selector(setPhotos:) withObject:photoItems];
            [placePicsViewController setTitle:[self titleForRow:indexPath.row]];
            [[self navigationController] pushViewController:placePicsViewController animated:YES];

        });
    });
 }

- (NSString *)titleForRow:(NSUInteger)row
{
    NSLog(@"%@",self.photos[row][@"woe_name"]);
    return self.photos[row][@"woe_name"]; // description because could be NSNull
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the owner of the photo out of it

- (NSString *)subtitleForRow:(NSUInteger)row
{
    NSMutableArray* components = [[(self.photos[row][@"_content"]) componentsSeparatedByString:@", "] mutableCopy];
    [components removeObjectAtIndex:0];
    return [components componentsJoinedByString:@", "];
}

// loads up a table view cell with the title and owner of the photo at the given row in the Model

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow:indexPath.row];
    
    return cell;
}

@end
