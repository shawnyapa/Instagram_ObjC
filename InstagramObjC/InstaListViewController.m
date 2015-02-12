//
//  InstaListViewController.m
//  InstagramObjC
//
//  Created by Shawn Yapa on 2/8/15.
//  Copyright (c) 2015 Shawn Yapa. All rights reserved.
//

#import "InstaListViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "InstaCellTableViewCell.h"
#import "InstaModel.h"
#import "InstaDetailViewController.h"

@interface InstaListViewController ()

@end

NSMutableArray *instaArray;
UIImage *placeHolderThumbnail;
InstaModel *selectedPhoto;
NSString *nextUrl;
BOOL fetchingInProgress;

@implementation InstaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fetchingInProgress = NO;
    self.navigationItem.title = @"Popular Photos";
    placeHolderThumbnail = [UIImage imageNamed:@"placeHolderThumbnail"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.instaList insertSubview:self.refreshControl atIndex:0];
    
    // Fetch Instagram Photos via AFNetworking
    //NSString *instagramUrlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=2c20e447eeed401ea9380d62d8f3b6cf"];
    NSString *instagramUrlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/22836073/media/recent/?client_id=2c20e447eeed401ea9380d62d8f3b6cf"];
        //Miami Heat Feed Includes nextUrl Pagination
    [self fetchInstragramPhotosViaAFNetworking:instagramUrlString addPhotos:NO];
    
}

- (void)onRefresh {
    //NSString *instagramUrlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=2c20e447eeed401ea9380d62d8f3b6cf"];
    NSString *instagramUrlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/22836073/media/recent/?client_id=2c20e447eeed401ea9380d62d8f3b6cf"];
    if (fetchingInProgress == NO) {
        fetchingInProgress = YES;
        [self fetchInstragramPhotosViaAFNetworking:instagramUrlString addPhotos:NO];
    }
}

- (void)fetchInstragramPhotosViaAFNetworking:(NSString *)instagramUrlString addPhotos:(BOOL)addPhotos{
    
    NSURL *instagramUrl = [NSURL URLWithString:instagramUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:instagramUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
                                         initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation
                                               , id responseObject) {
        NSError *Error = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                           options:0 error:&Error];
        NSArray *responseArray = responseDictionary[@"data"];
        // Get Pagination Data
        NSDictionary *paginationDictionary = responseDictionary[@"pagination"];
        nextUrl = paginationDictionary[@"next_url"];
        
        // Take data and serialize into InstaModel array
        NSMutableArray *photos = [InstaModel instaArrayFromResponse: responseArray];
        if (addPhotos) {
            // Add photos to instaArray
            [instaArray addObjectsFromArray:photos];
            // Remove Footer Loading View
            self.instaList.tableFooterView = nil;
        } else {
            instaArray = nil;
            instaArray = photos;
            [self.refreshControl endRefreshing];
        }
        [_instaList reloadData];
        fetchingInProgress = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Unable to Complete Instagram API Request");
        fetchingInProgress = NO;
        [self.refreshControl endRefreshing];
        self.instaList.tableFooterView = nil;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to connect and fetch Instagram Photos" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
    }
     ];
    [operation start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)loadAdditionalInstagramPhotos {
    if (fetchingInProgress == NO) {
        fetchingInProgress = YES;
        [self showFooterLoadingView];
        [self fetchInstragramPhotosViaAFNetworking:nextUrl addPhotos:YES];
    }
}

- (void)showFooterLoadingView {
    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [loadingView startAnimating];
    loadingView.center = tableFooterView.center;
    [tableFooterView addSubview:loadingView];
    self.instaList.tableFooterView = tableFooterView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [instaArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InstaCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if ((indexPath.row == [instaArray count]-1) && (indexPath.row != 0)) {
        // Fetch additional Instagram Photos & show Footer Activity View
        [self loadAdditionalInstagramPhotos];
    }
    // Implement CustomTableViewCell & AFNetworking Image Loader
    InstaModel *instaPhoto = (InstaModel *)instaArray[indexPath.row];
    cell.name.text = instaPhoto.name;
    cell.caption.text = instaPhoto.caption;
    // Async AFNetworking Image request with thumbnail
    NSURL *nsurlThumbnail = [NSURL URLWithString:instaPhoto.urlThumbnail];
    if (instaPhoto.urlThumbnail != nil && (![instaPhoto.urlThumbnail isEqual:@""])) {
        [cell.imageViewThumbnail setImageWithURL:nsurlThumbnail placeholderImage:placeHolderThumbnail];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Implement Segue Workflow for Selected Row->InstaDetail
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedPhoto = (InstaModel *)instaArray[indexPath.row];
    [self performSegueWithIdentifier:@"showInstagramPhotoDetail" sender:self];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showInstagramPhotoDetail"]) {
    InstaDetailViewController *destinationVC = [segue destinationViewController];
    destinationVC.instaPhoto = selectedPhoto;
    }
}

@end
