//
//  MovieViewController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 30/12/16.
//  Copyright © 2016 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorites.h"
@interface MovieViewController : UITableViewController
{
    RLMResults *tableDataArray;
    Favorites *selectedDataObject;
}
@property (strong, nonatomic) IBOutlet UITableView *mTableView;

@end
