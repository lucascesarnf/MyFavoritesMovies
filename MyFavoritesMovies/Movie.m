//
//  Movie.m
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 09/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import "Movie.h"

@implementation Movie
@synthesize title,year,rating,moviePoster,moviePosterURL,actors,director,genre,synopsis,runtime;


-(id)initWithDictionary:(NSDictionary *)sourceDictionary
{
    self = [super init];
    if (self != nil)
    {
        self.moviePosterURL    = [sourceDictionary objectForKey:@"Poster"];
        self.title             = [sourceDictionary objectForKey:@"Title"];
        self.year              = [sourceDictionary objectForKey:@"Year"];
        self.actors            = [sourceDictionary objectForKey:@"Actors"];
        self.director          = [sourceDictionary objectForKey:@"Director"];
        self.genre             = [sourceDictionary objectForKey:@"Genre"];
        self.runtime           = [sourceDictionary objectForKey:@"Runtime"];
        self.rating            = [sourceDictionary objectForKey:@"imdbRating"];
        self.synopsis          = [sourceDictionary objectForKey:@"Plot"];
        self.imdbid            = [sourceDictionary objectForKey:@"imdbID"];
    }
    return self;
    
}
@end
