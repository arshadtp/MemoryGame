//
//  Macro.h
//  MemoryGame
//
//  Created by Arshad T P on 5/6/17.
//  Copyright © 2017 Ab'initio. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define isDictionary(object)\
[object isKindOfClass:[NSDictionary class]]?YES:NO

// Check if valid array
#define isArray(object)\
[object isKindOfClass:[NSArray class]]?YES:NO

// Check if dictionary has a valid string for perticular Key
#define dictionaryHasValidString(dictionary,aKey)\
[[dictionary objectForKey:aKey] isEqual:[NSNull null]] ? NO : ![[dictionary objectForKey:aKey] isKindOfClass:[NSString class]] ? NO :((NSString *)[dictionary objectForKey:aKey]).length > 0 ?YES: NO

// Check if valid string
#define isString(object)\
[object isKindOfClass:[NSString class]]?YES:NO

#endif /* Macro_h */
