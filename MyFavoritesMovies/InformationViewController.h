//
//  InformationViewController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 02/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieViewController.h"
@interface InformationViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UITextView *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *sinopseLabel;
@property (nonatomic, strong)  MovieViewController *father;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *sinopse;
@property (nonatomic, strong) NSString *poster;
- (IBAction)deleteMovie:(id)sender;


@end
