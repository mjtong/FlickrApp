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
@end