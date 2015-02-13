//
//  FullScreenPhotoViewController.m
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/12/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import "FullScreenPhotoViewController.h"

@interface FullScreenPhotoViewController ()

@end

@implementation FullScreenPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoView.image = self.photoImage;
    self.scrollView.contentSize = self.photoView.image.size;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.photoView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
