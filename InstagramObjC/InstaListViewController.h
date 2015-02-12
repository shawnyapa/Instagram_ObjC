//
//  InstaListViewController.h
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/8/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *instaList;
@property (strong, nonatomic) UIRefreshControl *refreshControl;


@end
