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
    _mSearchBar.delegate = self;
    self.mSearchBar.placeholder = @"Search movies";
    self.hud.tintColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*if (self.movies && self.movies.count) {
        return self.movies.count;
    } else {
        return 0;
    }*/
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(movies.count == 0){
        
    }
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *movi=(Movie *)[movies objectAtIndex:indexPath.row];
    cell.titleLabel.text = movi.title;
    cell.yearLabel.text=movi.year;
    if([movi.moviePosterURL isEqualToString:@"N/A"]){
        cell.posterImageView.image = [UIImage imageNamed:@"not-found.png"];
    }else{
    NSString *str = [movi.moviePosterURL stringByReplacingOccurrencesOfString:@"http:"
                                                              withString:@"https:"];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:str]];
    cell.posterImageView.image = [UIImage imageWithData: imageData];
    }
    if(indexPath.row%2==0){
        cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0.2];
    }else{
       cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0];
    }
    return cell;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSString *str = [searchBar.text stringByReplacingOccurrencesOfString:@" "
                                         withString:@"+"];
    NSLog(@"\n\nString New:%@",str);
    //Network:
    
    NSString *link = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&y=&plot=short&r=json",str];
    NSURL *URL = [NSURL URLWithString:link];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"\n\nMovies:%@", responseObject);
            movies=[[NSMutableArray alloc]init];
            NSDictionary *resultDictinary = [responseObject objectForKey:@"Search"];
            for (NSDictionary *movieDictionary in resultDictinary)
            {
                Movie *newUSer=[[Movie alloc]initWithDictionary:movieDictionary];
                [movies addObject:newUSer];
            }
            
            NSLog(@"\n\nMovies:%@", self.movies);
            if(movies.count == 0){
                UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
                noDataLabel.text             = @"No results";
                noDataLabel.textColor        = [UIColor blackColor];
                noDataLabel.textAlignment    = NSTextAlignmentCenter;
                _mTableView.backgroundView = noDataLabel;
                _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }
            [_mTableView reloadData];
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
        }
    }];
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.label.text = @"Loading";
    [_hud hideAnimated:YES];
    [_hud showAnimated:YES];
    [dataTask resume];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *destViewController = segue.destinationViewController;
        Movie *movi=(Movie *)[movies objectAtIndex:indexPath.row];
        destViewController.imdbid = movi.imdbid;
        
    }
        if ([segue.identifier isEqualToString:@"searchMovie"]) {
            MovieViewController *destViewController = segue.destinationViewController;
            [destViewController.mTableView reloadData];
        }
}
@end
