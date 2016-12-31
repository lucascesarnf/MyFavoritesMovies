//
//  Favorites.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 30/12/16.
//  Copyright © 2016 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import <Realm/Realm.h>

@interface Favorites : RLMObject
@property NSString *title;
@property NSString *year;
@property NSString *rating;
@property NSString *sinopse;
@property NSString *poster;

@end
