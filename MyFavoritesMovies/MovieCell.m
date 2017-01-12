//
//  MovieCell.m
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 30/12/16.
//  Copyright © 2016 Lucas César  Nogueira Fonseca. All rights reserved.
//
#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.posterImageView.layer.cornerRadius = self.posterImageView.frame.size.width /2;
    self.posterImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
