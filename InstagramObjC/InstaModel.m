//
//  InstaModel.m
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/8/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import "InstaModel.h"

@implementation InstaModel

- (void)instaPhotoFromDictionary:(NSDictionary *)instaPhotoDictionary {
    // user/full_name
    // images/thumbnail
    // images/standard_resolution
    // caption/text
    // likes/count
    NSDictionary *user = instaPhotoDictionary[@"user"];
    if ([self isDictionaryNull:user]) {
        _name = user[@"full_name"];
    }
    NSDictionary *images = instaPhotoDictionary[@"images"];
    if ([self isDictionaryNull:images]) {
        NSDictionary *thumbnail = images[@"thumbnail"];
        if ([self isDictionaryNull:thumbnail]) {
            _urlThumbnail = thumbnail[@"url"];
        }
        NSDictionary *standardResolution = images[@"standard_resolution"];
        if ([self isDictionaryNull:standardResolution]) {
            _urlStandardResolution = standardResolution[@"url"];
        }
    }
    NSDictionary *caption = instaPhotoDictionary[@"caption"];
    if ([self isDictionaryNull:caption]) {
        _caption = caption[@"text"];
    }
}

- (BOOL)isDictionaryNull:(NSDictionary *)dictionary {
    
    if (([dictionary isEqual:nil]) || ([dictionary isEqual:[NSNull null]])){
        return false;
    }
    else {
        return true;
    }
}

+ (NSMutableArray *)instaArrayFromResponse:(NSArray *)responseArray {
    NSMutableArray *instaArray = [[NSMutableArray alloc] init];
    for (NSDictionary *instaPhotoDictionary in responseArray) {
        InstaModel *instaPhoto = [[InstaModel alloc] init];
        [instaPhoto instaPhotoFromDictionary:instaPhotoDictionary];
        [instaArray addObject:instaPhoto];
    }
    return instaArray;
}

@end
