//
//  RLMController.h
//  MyFavoritesMovies
//
//  Created by Lucas César  Nogueira Fonseca on 10/01/17.
//  Copyright © 2017 Lucas César  Nogueira Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLMMovie.h"
@interface RLMController : NSObject
{
    RLMResults *tableDataArray;
    RLMMovie *selectedDataObject;
}
@end
