//
//  InstaModel.h
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/8/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstaModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *urlThumbnail;
@property (strong, nonatomic) NSString *urlStandardResolution;
@property (strong, nonatomic) NSString *caption;

+ (NSMutableArray *)instaArrayFromResponse:(NSArray *)responseArray;

@end
