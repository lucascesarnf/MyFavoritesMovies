//
//  DetailsViewController.m
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 09/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Movie.h"
#import <AFNetworking.h>
#import "DetailsViewController.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize imdbid;
@synthesize movie;
- (void)viewDidLoad {
    //Get imdbID and search every movie informations
    [super viewDidLoad];
    //Network:
    NSLog(@"\n\nID: %@\n\n", imdbid);
    NSString *link = [NSString stringWithFormat:@"https://www.omdbapi.com/?i=%@&plot=short&r=json",imdbid];
    NSURL *URL = [NSURL URLWithString:link];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"An error has occurred!"
                                          message:@"Please check your internet connection."
                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* Ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];
            
            [alert addAction:Ok];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [_hud hideAnimated:YES];
            [_hud showAnimated:YES];
            movie = [[Movie alloc]initWithDictionary:responseObject];
            NSLog(@"\n\nMovies:%@", self.movie);
            self.titleLabel.text = self.movie.title;
            self.yearLabel.text = self.movie.year;
            self.runtimeLabel.text = self.movie.runtime;
            self.ratingLabel.text = self.movie.rating;
            self.genreLabel.text = self.movie.genre;
            self.directorLabel.text = self.movie.director;
            self.actorsLabel.text = self.movie.actors;
            self.synopsisLabel.text = self.movie.synopsis;
            //Get not-found image:
            if([self.movie.moviePosterURL isEqualToString:@"N/A"]){
               NSString *str = @"https://az853139.vo.msecnd.net/static/images/not-found.png";
                self.movie.moviePoster = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:str]];
            }else{
                NSString *str = [self.movie.moviePosterURL stringByReplacingOccurrencesOfString:@"http:"
                                                                                     withString:@"https:"];
                self.movie.moviePoster = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:str]];
            }
            self.posterImageView.image = [UIImage imageWithData: self.movie.moviePoster ];
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
            
        }
    }];
    //Show loading
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.label.text = @"Loading";
    [_hud hideAnimated:YES];
    [_hud showAnimated:YES];
    //Call function afnetwork dataTask
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)favorite:(id)sender {
    //If save movie is clicked
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Favorite Movie"
                                  message:@"Want to add this movie to your favorites?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       RLMRealm *realm = [RLMRealm defaultRealm];
                                                       RLMMovie *information = [[RLMMovie alloc] init];
                                                       information.title=movie.title;
                                                       information.year=movie.year;
                                                       information.rating=movie.rating;
                                                       information.synopsis=movie.synopsis;
                                                       information.moviePosterURL=movie.moviePosterURL;
                                                       information.actors=movie.actors;
                                                       information.director=movie.director;
                                                       information.genre=movie.genre;
                                                       information.runtime=movie.runtime;
                                                       information.imdbid=movie.imdbid;
                                                       information.moviePoster = movie.moviePoster;
                                                       RLMResults<RLMMovie *> *someDogs = [RLMMovie objectsWhere:@"imdbid = %@",movie.imdbid];
                                                      // Check if the movie is already saved
                                                       if(someDogs.firstObject == nil){
                                                           [realm beginWriteTransaction];
                                                           [realm addObject:information];
                                                           [realm commitWriteTransaction];
                                                       }else{
                                                           [self back:1];
                                                       }
                                                    
                                                           [self back:0];
                                                   }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:cancel];
    [alert addAction:save];
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(void) alert{
    //Show
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"This movie is Favorite!"
                                  message:@"This movie is already in favorites"
                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* Ok = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [self back:0];
                                                   }];
    
    [alert addAction:Ok];

    [self presentViewController:alert animated:YES completion:nil];
}
-(void) back:(int)id{
   
    if(id==1){
         //If movie is already saved show message
        [self alert];
    }else{
         //If movie is not already saved
    [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
