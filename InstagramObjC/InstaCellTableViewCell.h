//
//  InstaCellTableViewCell.h
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/8/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstaCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *caption;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThumbnail;

@end
