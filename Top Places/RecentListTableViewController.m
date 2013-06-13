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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"recent"];
    self.title = @"Recent";
    NSLog(@"INViewDidLoad");
    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"WEW");
    self.photos = [[NSUserDefaults standardUserDefaults] objectForKey:@"recent"];
    [self.tableView reloadData];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%d Bef",[self.photos count]);
        NSMutableArray *forEdit =  [[[NSUserDefaults standardUserDefaults] objectForKey:@"recent"] mutableCopy];
        [[NSUserDefaults standardUserDefaults] setObject:forEdit forKey:@"recent"];
        self.photos = forEdit;
       
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end