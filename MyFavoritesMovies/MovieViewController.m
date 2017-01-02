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

- (void)viewDidLoad {
    [super viewDidLoad];
    tableDataArray=[Favorites allObjects];
    [_mTableView reloadData];
    /*
    [self insertDataIntoDataBaseWithTitle:@"Batman" WithYear:@"1999" WithRating:@"7" WithSinopse:@"Eu sou o Batman" WithPoster:@"batman.jpg"];
    
    [self insertDataIntoDataBaseWithTitle:@"Frozen" WithYear:@"2016" WithRating:@"4" WithSinopse:@"Você quer brincar na neve? Um boneco quer fazer?" WithPoster:@"frozen.jpg"];
    
    [self insertDataIntoDataBaseWithTitle:@"Star Wars" WithYear:@"1897" WithRating:@"10" WithSinopse:@"A long Time Ago" WithPoster:@"starwars.jpg"];
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableDataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Favorites *information = [tableDataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text = information.title;
    cell.yearLabel.text=information.year;
    cell.ratingLabel.text=information.rating;
    cell.sinopseLabel.text=information.sinopse;\
    cell.posterImageView.image = [UIImage imageNamed:information.poster];
    if(indexPath.row%2==0){
    cell.backgroundColor=[UIColor lightGrayColor];
    cell.backgroundColor = [cell.backgroundColor colorWithAlphaComponent:0.2];
    }else{
      cell.backgroundColor=[UIColor whiteColor];
    }
    return cell;
}


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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"movieInformation"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
         InformationViewController *destViewController = segue.destinationViewController;
        Favorites *information = [tableDataArray objectAtIndex:indexPath.row];
        destViewController.title = information.title;
        destViewController.year = information.year;
        destViewController.rating = information.rating;
        destViewController.sinopse = information.sinopse;
        destViewController.poster = information.poster;
    
    }
}

-(void)insertDataIntoDataBaseWithTitle:(NSString *)title WithYear:(NSString *)year WithRating:(NSString *)rating WithSinopse:(NSString *)sinopse WithPoster:(NSString *)poster
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    Favorites *information = [[Favorites alloc] init];
    information.title=title;
    information.year=year;
    information.rating=rating;
    information.sinopse=sinopse;
    information.poster=poster;
    [realm addObject:information];
    [realm commitWriteTransaction];
     [_mTableView reloadData];
}

@end
