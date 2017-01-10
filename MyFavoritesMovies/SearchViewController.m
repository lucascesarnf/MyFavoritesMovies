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
@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize movies;

- (void)viewDidLoad {
    [super viewDidLoad];
    _mSearchBar.delegate = self;
    movies = [NSMutableArray arrayWithCapacity:10];
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
        cell.backgroundColor=[UIColor lightGrayColor];
        cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0.2];
    }else{
        cell.backgroundColor=[UIColor whiteColor];
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
            //reload your tableview data
            [_mTableView reloadData];
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
            if(movies.count == 0){
                UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
                noDataLabel.text             = @"No results";
                noDataLabel.textColor        = [UIColor blackColor];
                noDataLabel.textAlignment    = NSTextAlignmentCenter;
                _mTableView.backgroundView = noDataLabel;
                _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }
            //self.movies = [[NSDictionary alloc] initWithDictionary:responseObject];
            //NSLog(@"\n\nMovies:%@", self.movies);
            //NSLog(@"\n\nSize:%lu", [[self.movies allKeys] count]);
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
}
/*
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    //Network:
    NSString *link = [NSString stringWithFormat:@"https://www.omdbapi.com/?s=%@&y=&plot=short&r=json",searchBar.text];
    NSURL *URL = [NSURL URLWithString:link];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            movies=[[NSMutableArray alloc]init];
            NSDictionary *resultDictinary = [responseObject objectForKey:@"Search"];
            for (NSDictionary *userDictionary in resultDictinary)
            {
                Movie *newUSer=[[Movie alloc]initWithDictionary:userDictionary];
                [movies addObject:newUSer];
            }
            
            NSLog(@"\n\nMovies:%@", self.movies);
            //reload your tableview data
            [_mTableView reloadData];
            //self.movies = [[NSDictionary alloc] initWithDictionary:responseObject];
            //NSLog(@"\n\nMovies:%@", self.movies);
            //NSLog(@"\n\nSize:%lu", [[self.movies allKeys] count]);
        }
    }];
    [dataTask resume];
}*/



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
