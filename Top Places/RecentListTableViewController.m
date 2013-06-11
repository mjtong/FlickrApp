//
//  RecentListTableViewController.m
//  Top Places
//
//  Created by Maynard Tong on 6/11/13.
//  Copyright (c) 2013 Maynard Tong. All rights reserved.
//

#import "RecentListTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"
@interface RecentListTableViewController ()

@end

@implementation RecentListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"recent"];
    self.title = @"Recent";
    NSLog(@"%@",self.photos);
    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"recent"];
    [self.tableView reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the title out of it
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewController *imageViewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
    NSString *stringUrl = [FlickrFetcher urlStringForPhotoWithFlickrInfo:self.photos[indexPath.row] format:FlickrFetcherPhotoFormatLarge];
    NSLog(@"%@",stringUrl);
    NSURL *url = [[NSURL alloc] initWithString:stringUrl];
    [imageViewController performSelector:@selector(setImageURL:) withObject:url];
    [imageViewController setTitle:[self titleForRow:indexPath.row]];
    [[self navigationController] pushViewController:imageViewController animated:YES];
}

- (NSString *)titleForRow:(NSUInteger)row
{
    if([self.photos[row][@"title"] isEqualToString:@""]){
        return @"Unknown";
    }
    return self.photos[row][@"title"]; // description because could be NSNull
}

// a helper method that looks in the Model for the photo dictionary at the given row
//  and gets the owner of the photo out of it

- (NSString *)subtitleForRow:(NSUInteger)row
{
    if([self.photos[row][@"description"][@"_content"] isEqualToString:@""]){
        return @"Unknown";
    }
    return self.photos[row][@"description"][@"_content"]; // description because could be NSNull
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
