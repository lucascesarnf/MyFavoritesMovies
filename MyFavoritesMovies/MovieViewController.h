//
//  MovieViewController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 30/12/16.
//  Copyright © 2016 Lucas César  Nogueira Fonseca. All rights reserved.
//
//This class manages the application's home screen
#import <UIKit/UIKit.h>
#import "RLMMovie.h"
@interface MovieViewController : UITableViewController
{
    RLMResults *tableDataArray;//Favorites storage array
    RLMMovie *selectedDataObject;//Selected object
}
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)deleteMovie;//Auxiliary function for delete selected movie
@end
