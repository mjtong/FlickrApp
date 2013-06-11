//
//  TopPlacesFlickrTableViewController.m
//  Top Places
//
//  Created by Maynard Tong on 6/11/13.
//  Copyright (c) 2013 Maynard Tong. All rights reserved.
//

#import "TopPlacesFlickrTableViewController.h"
#import "FlickrFetcher.h"
#import "TopPlacesAppDelegate.h"
@interface TopPlacesFlickrTableViewController ()
@end

@implementation TopPlacesFlickrTableViewController

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
    self.title = @"Top Places";
    
    self.photos = [FlickrFetcher topPlaces];

   
  
}


@end
