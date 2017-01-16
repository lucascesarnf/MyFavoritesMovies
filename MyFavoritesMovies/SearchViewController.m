//
//  SearchViewController.m
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 05/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//
#import "Movie.h"
#import "SearchViewController.h"
#import <AFNetworking.h>
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "MovieViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize movies;

- (void)viewDidLoad {
    [super viewDidLoad];
    _mSearchBar.delegate = self;//Delegate data
    self.mSearchBar.placeholder = @"Search movies";
    self.currentPage = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Show cell
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *movi=(Movie *)[movies objectAtIndex:indexPath.row];
    cell.titleLabel.text = movi.title;
    cell.yearLabel.text=movi.year;
    if([movi.moviePosterURL isEqualToString:@"N/A"]){
       // If the movie has no picture add not-found image
        cell.posterImageView.image = [UIImage imageNamed:@"not-found.png"];
    }else{
   //exchang every "http:" for "https:"
    NSString *str = [movi.moviePosterURL stringByReplacingOccurrencesOfString:@"http:"
                                                              withString:@"https:"];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:str]];
    cell.posterImageView.image = [UIImage imageWithData: imageData];
    }
    //Toggles cell color
    if(indexPath.row%2==0){
        cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0.2];
    }else{
       cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0];
    }
    return cell;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //exchange every "space" for "+"
    NSString *str = [searchBar.text stringByReplacingOccurrencesOfString:@" "
                                         withString:@"+"];
    NSLog(@"\n\nString New:%@",str);
    _searche = str;
    //Network:
    NSString *link = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&y=&plot=short&r=json",str];
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
            self.currentPage = 1;
            NSLog(@"\n\nMovies:%@", responseObject);
            movies=[[NSMutableArray alloc]init];
            NSDictionary *resultDictinary = [responseObject objectForKey:@"Search"];
            int number = [[responseObject objectForKey:@"totalResults"] intValue];
            if((number % 10)>0){
                _numPages = (number /10)+1;
            }else{
                _numPages = (number / 10);
            }
            NSLog(@"\n%@",responseObject);
            for (NSDictionary *movieDictionary in resultDictinary)
            {
                Movie *newUSer=[[Movie alloc]initWithDictionary:movieDictionary];
                [movies addObject:newUSer];
            }
            
           // NSLog(@"\n\nMovies:%@", self.movies);
            if(movies.count == 0){
                UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
                noDataLabel.text             = @"No results";
                noDataLabel.textColor        = [UIColor blackColor];
                noDataLabel.textAlignment    = NSTextAlignmentCenter;
                _mTableView.backgroundView = noDataLabel;
                _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }else{
                _mTableView.backgroundView = nil;

            }
            [_mTableView reloadData];
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
        }
    }];
    //Show Loading:
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.label.text = @"Loading";
    [_hud hideAnimated:YES];
    [_hud showAnimated:YES];
    //call afnetwork in dataTask
    [dataTask resume];
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger lastSectionIndex = [tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:lastSectionIndex] - 1;
    if ((indexPath.section == lastSectionIndex) && (indexPath.row == lastRowIndex)) {
    //AFNetwork:
        //Network:
        self.currentPage += 1;
        if(_currentPage<=_numPages){
        NSString *link = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&page=%d",_searche,_currentPage];
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
                NSDictionary *resultDictinary = [responseObject objectForKey:@"Search"];
                for (NSDictionary *movieDictionary in resultDictinary)
                {
                    Movie *newUSer=[[Movie alloc]initWithDictionary:movieDictionary];
                    [movies addObject:newUSer];
                }
                
                _mTableView.backgroundView = nil;
                    
                
                [_mTableView reloadData];
                [_hud hideAnimated:NO];
                [_hud showAnimated:NO];
            }
        }];
        //Show Loading:
        _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        _hud.label.text = @"Loading";
        [_hud hideAnimated:YES];
        [_hud showAnimated:YES];
        //call afnetwork in dataTask
        [dataTask resume];
       }
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ////Transfer your information for next screen
    if ([segue.identifier isEqualToString:@"ShowDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *destViewController = segue.destinationViewController;
        Movie *movi=(Movie *)[movies objectAtIndex:indexPath.row];
        destViewController.imdbid = movi.imdbid;
        
    }
}
@end
