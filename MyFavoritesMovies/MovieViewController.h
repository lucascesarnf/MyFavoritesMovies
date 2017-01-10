//
//  MovieViewController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 30/12/16.
//  Copyright © 2016 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RLMMovie.h"
@interface MovieViewController : UITableViewController
{
    RLMResults *tableDataArray;
    RLMMovie *selectedDataObject;
}
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)deleteMovie;
@end
