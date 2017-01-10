//
//  Movie.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 09/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Movie : NSObject
{
    NSString *title;
    NSString *year;
    NSString *rating;
    NSString *shortSynopsis;
    NSString *fullSynopsis;
    NSString *moviePosterURL;
    NSString *actors;
    NSString *director;
    NSString *genre;
    NSString *rated;
    NSString *runtime;
    UIImage *moviePoster;
    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, copy) NSString *moviePosterURL;
@property (nonatomic, copy) NSString *actors;
@property (nonatomic, copy) NSString *director;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, copy) NSString *synopsis;
@property (nonatomic, copy) NSString *runtime;
@property (nonatomic, copy) UIImage *moviePoster;
@property (nonatomic, copy) NSString *imdbid;
//@property (nonatomic, copy) NSData *moviePosterData;

-(id)initWithDictionary:(NSDictionary *)sourceDictionary;


@end
