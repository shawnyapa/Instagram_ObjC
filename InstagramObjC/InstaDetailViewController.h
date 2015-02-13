//
//  InstaDetailViewController.h
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/8/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstaModel.h"

@interface InstaDetailViewController : UIViewController

@property (strong, nonatomic) InstaModel *instaPhoto;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewStandardResolution;
@property (weak, nonatomic) IBOutlet UITextView *caption;

- (IBAction)showFullPhotoWithZoom:(id)sender;

@end
