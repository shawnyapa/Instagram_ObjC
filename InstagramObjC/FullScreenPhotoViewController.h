//
//  FullScreenPhotoViewController.h
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/12/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullScreenPhotoViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) UIImage *photoImage;

@end
