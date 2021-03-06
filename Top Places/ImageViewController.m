//
//  ImageViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "ImageViewController.h"
#import "TopPlacesAppDelegate.h"
@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ImageViewController

// resets the image whenever the URL changes

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}

// fetches the data from the URL
// turns it into an image
// adjusts the scroll view's content size to fit the image
// sets the image as the image view's image


- (void)resetImage
{
    if (self.scrollView) {
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
                       dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                           
                           if (image) {
                               NSLog(@"%g",self.scrollView.zoomScale);
                               self.scrollView.contentSize = image.size;
                               self.imageView.image = image;
                               self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
                               CGFloat widthFactor = [self.scrollView bounds].size.width / image.size.width;
                               CGFloat heightFactor = [self.scrollView bounds].size.height/ image.size.height;
                               if( widthFactor > heightFactor){
                                   self.scrollView.zoomScale = widthFactor;}
                               else{
                                   self.scrollView.zoomScale = heightFactor;
                               }
                           }

            });
        });

       
     
    }
}

// lazy instantiation

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

// returns the view which will be zoomed when the user pinches
// in this case, it is the image view, obviously
// (there are no other subviews of the scroll view in its content area)

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

// add the image view to the scroll view's content area
// setup zooming by setting min and max zoom scale
//   and setting self to be the scroll view's delegate
// resets the image in case URL was set before outlets (e.g. scroll view) were set

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.01;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    NSLog(@"Hello");
    [self resetImage];
   // [self.scrollView setZoomScale:5.0f animated:NO];

}

@end
