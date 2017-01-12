//
//  MovieCell.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 30/12/16.
//  Copyright © 2016 Lucas César  Nogueira Fonseca. All rights reserved.
//
//This model show movie cell information
#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end
