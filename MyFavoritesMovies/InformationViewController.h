//
//  InformationViewController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 02/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//
//This class manager detailsview from Realm
#import <UIKit/UIKit.h>
#import "MovieViewController.h"
@interface InformationViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UITextView *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UITextView *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UITextView *actorsLabel;
@property (nonatomic, strong)  MovieViewController *father;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *moviePosterURL;
@property (nonatomic, copy) NSString *actors;
@property (nonatomic, copy) NSString *director;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *runtime;
@property (nonatomic, copy) NSData *moviePoster;
@property (nonatomic, copy) NSString *imdbid;
- (IBAction)deleteMovie:(id)sender;//call father deletemovie
@end
