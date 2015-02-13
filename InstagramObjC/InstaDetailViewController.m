//
//  InstaDetailViewController.m
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/8/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import "InstaDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "FullScreenPhotoViewController.h"

@interface InstaDetailViewController ()

@end

@implementation InstaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Photo";
    _name.text = _instaPhoto.name;
    _caption.text = _instaPhoto.caption;
    UIImage *placeHolderThumbnail = [UIImage imageNamed:@"placeHolderThumbnail"];
    NSURL *nsurlThumbnail = [NSURL URLWithString:_instaPhoto.urlStandardResolution];
    if (_instaPhoto.urlStandardResolution != nil && (![_instaPhoto.urlStandardResolution isEqual:@""])) {
        [_imageViewStandardResolution setImageWithURL:nsurlThumbnail placeholderImage:placeHolderThumbnail];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showFullPhotoWithZoom:(id)sender {

    [self performSegueWithIdentifier:@"showFullPhotoWithZoom" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier  isEqual: @"showFullPhotoWithZoom"]) {
    FullScreenPhotoViewController *fullScreenPhotoVC = [segue destinationViewController];
    fullScreenPhotoVC.photoImage = _imageViewStandardResolution.image;
        NSLog(@"Photo Detail Size Height %f", _imageViewStandardResolution.image.size.height);
        NSLog(@"Photo Detail Size Width %f", _imageViewStandardResolution.image.size.width);
    }
}


@end
