//
//  InformationViewController.m
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 02/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController
@synthesize title;
@synthesize year;
@synthesize rating;
@synthesize moviePosterURL;
@synthesize actors;
@synthesize director;
@synthesize genre;
@synthesize synopsis;
@synthesize runtime;
@synthesize moviePoster;
@synthesize imdbid;
- (void)viewDidLoad {
    [super viewDidLoad];
    //Set segue information
    _titleLabel.text = title;
    _yearLabel.text = year;
    _ratingLabel.text = rating;
    _posterImageView.image =[UIImage imageWithData: moviePoster];;
    _actorsLabel.text =actors;
    _directorLabel.text = director;
    _genreLabel.text= genre;
    _synopsisLabel.text =synopsis;
    _runtimeLabel.text = runtime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (IBAction)deleteMovie:(id)sender {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Delete Movie"
                                  message:@"You want delete the movie?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action) {
                                                     [_father deleteMovie];//Call father deleteMovie
                                                     [self back];
                                                 }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:cancel];
    [alert addAction:delete];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
