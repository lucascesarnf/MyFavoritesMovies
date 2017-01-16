//
//  SearchViewController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 05/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//
//This class manager search screen
#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>
@interface SearchViewController : UITableViewController <UISearchBarDelegate,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic, retain) NSMutableArray *movies;//Searched movies
@property (nonatomic, retain) MBProgressHUD *hud;//Manager the loading
@property int numPages;
@property int currentPage;
@property NSString *searche;


@end
