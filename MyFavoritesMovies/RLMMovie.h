//
//  RLMMovie.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 10/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//
//This model is the local persistence
#import <Realm/Realm.h>

@interface RLMMovie : RLMObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *moviePosterURL;
@property (nonatomic, copy) NSString *actors;
@property (nonatomic, copy) NSString *director;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *runtime;
@property (nonatomic, copy) NSData *moviePoster;
@property (nonatomic, copy) NSString *imdbid;
@end
