//
//  DetailsViewController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 09/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//
//This class manager detailsview from afnetwork
#import <UIKit/UIKit.h>
#import "Movie.h"
#import <MBProgressHUD.h>
#import "RLMMovie.h"
@interface DetailsViewController : UITableViewController{
RLMResults *tableDataArray;
}
@property (nonatomic, strong) NSString *imdbid;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UITextView *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UITextView *actorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (nonatomic,strong)Movie *movie;
@property (nonatomic, retain) MBProgressHUD *hud;
- (IBAction)favorite:(id)sender;
@end
