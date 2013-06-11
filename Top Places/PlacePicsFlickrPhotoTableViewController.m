//
//  PlacePicsFlickrPhotoTableViewController.m
//  Top Places
//
//  Created by Maynard Tong on 6/11/13.
//  Copyright (c) 2013 Maynard Tong. All rights reserved.
//

#import "PlacePicsFlickrPhotoTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"
#import "TopPlacesAppDelegate.h"
@interface PlacePicsFlickrPhotoTableViewController ()

@end

@implementation PlacePicsFlickrPhotoTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSMutableArray *recentList = [[[NSUserDefaults standardUserDefaults] objectForKey:@"recent"]mutableCopy];
    if(recentList){
        if(![recentList containsObject:self.photos[indexPath.row]]){
        [recentList addObject:self.photos[indexPath.row]];
        }
    }
    else{
        recentList = [[NSMutableArray alloc] init];
        [recentList addObject:self.photos[indexPath.row]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:recentList forKey:@"recent"];
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
