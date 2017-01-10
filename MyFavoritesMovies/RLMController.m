//
//  RLMController.m
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 10/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import "RLMController.h"

@implementation RLMController
-(void)insertDataIntoDataBaseWithTitle:(NSString *)title WithYear:(NSString *)year WithRating:(NSString *)rating WithSinopse:(NSString *)synopsis WithPoster:(NSString *)poster WithActors:(NSString *)actors WithDirector:(NSString *)director WithGenre:(NSString *)genre WithRuntime:(NSString *)runtime WithImdbid:(NSString *)imdbid
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    RLMMovie *information = [[RLMMovie alloc] init];
    information.title=title;
    information.year=year;
    information.rating=rating;
    information.synopsis=synopsis;
    information.moviePosterURL=poster;
    information.actors=actors;
    information.director=director;
    information.genre=genre;
    information.runtime=runtime;
    information.imdbid=imdbid;
    //SaveImageData:
    NSURL *imageURL = [NSURL URLWithString:poster];
    information.moviePoster = [NSData dataWithContentsOfURL:imageURL];
    //
    [realm addObject:information];
    [realm commitWriteTransaction];
}
@end
