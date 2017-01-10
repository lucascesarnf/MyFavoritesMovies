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
        } else {
           // NSLog(@"\n\nMovies:%@", responseObject);
           // NSDictionary *resultDictinary = [responseObject objectForKey:@"Search"];
            /*for (NSDictionary *movieDictionary in resultDictinary)
            {
                Movie *newUSer=[[Movie alloc]initWithDictionary:movieDictionary];
                [movies addObject:newUSer];
            }*/
            movie = [[Movie alloc]initWithDictionary:responseObject];
            NSLog(@"\n\nMovies:%@", self.movie);
            self.titleLabel.text = self.movie.title;
            self.yearLabel.text = self.movie.year;
            self.runtimeLabel.text = self.movie.runtime;
            self.ratingLabel.text = self.movie.rating;
            self.genreLabel.text = self.movie.genre;
            self.directorLabel.text = self.movie.director;
            //reload your tableview data
            [_hud hideAnimated:NO];
            [_hud showAnimated:NO];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
