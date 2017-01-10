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
     [_mTableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    tableDataArray=[RLMMovie allObjects];
    [_mTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = 0;
    if ([tableDataArray count] > 0)
    {
        _mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        numOfSections                = 1;
        _mTableView.backgroundView = nil;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mTableView.bounds.size.width, _mTableView.bounds.size.height)];
        noDataLabel.text             = @"Please add Favorites";
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    RLMMovie *information = [tableDataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = information.title;
    cell.yearLabel.text=information.year;
    cell.posterImageView.image = [UIImage imageWithData:information.moviePoster];
    if(indexPath.row%2==0){
    cell.backgroundColor=[UIColor lightGrayColor];
    cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0.2];
    }else{
      cell.backgroundColor=[UIColor whiteColor];
    }
    return cell;
}

- (IBAction)deleteMovie{
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
