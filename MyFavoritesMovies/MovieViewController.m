//
//  MovieViewController.m
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 30/12/16.
//  Copyright © 2016 Lucas César  Nogueira Fonseca. All rights reserved.
//
#import "MovieViewController.h"
#import "MovieCell.h"
#import "InformationViewController.h"

@interface MovieViewController ()

@end

@implementation MovieViewController
-(void)viewDidAppear:(BOOL)animated{
     [_mTableView reloadData];//Update table View whenever you open the screen
}
- (void)viewDidLoad {
    [super viewDidLoad];
    tableDataArray=[RLMMovie allObjects];//Get all objects stored in realm
    [_mTableView reloadData];//Update Table View
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Manager the number of sections in the application
    NSInteger numOfSections = 0;
    if ([tableDataArray count] > 0)
    {
        //Show cells
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _mTableView.backgroundView = nil;
    }
    else
    {
        //Show message
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
        noDataLabel.text             = @"Please add Favorites into Search";
        noDataLabel.textColor        = [UIColor blackColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        _mTableView.backgroundView = noDataLabel;
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableDataArray count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;//
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //Manager the swipe for delete
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       //Delete in realm
        RLMMovie *information = [tableDataArray objectAtIndex:indexPath.row];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:information];
        [realm commitWriteTransaction];
      //
        [_mTableView reloadData];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Shows the cells that are in realm
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    RLMMovie *information = [tableDataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = information.title;
    cell.yearLabel.text=information.year;
    cell.posterImageView.image = [UIImage imageWithData:information.moviePoster];
    //Toggles cell color
    if(indexPath.row%2==0){
    cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0.2];
    }else{
      cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0];
    }
    return cell;
}

- (IBAction)deleteMovie{
    //Delete selected movie
NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
RLMMovie *information = [tableDataArray objectAtIndex:indexPath.row];
RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:information];
    [realm commitWriteTransaction];
    [_mTableView reloadData];
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Transfer your information for next screen
    if ([segue.identifier isEqualToString:@"movieInformation"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        InformationViewController *destViewController = segue.destinationViewController;
        RLMMovie *information = [tableDataArray objectAtIndex:indexPath.row];
        destViewController.title = information.title;
        destViewController.year = information.year;
        destViewController.rating = information.rating;
        destViewController.moviePoster = information.moviePoster;
        destViewController.actors = information.actors;
        destViewController.director = information.director;
        destViewController.genre = information.genre;
        destViewController.synopsis = information.synopsis;
        destViewController.runtime = information.runtime;
        destViewController.father = self;
    }
}
@end
