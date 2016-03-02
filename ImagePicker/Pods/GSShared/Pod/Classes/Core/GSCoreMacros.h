//
//  GSCoreMacros.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 29/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INVALID_PROPERTY_SET {\
@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must not be called", __PRETTY_FUNCTION__] userInfo:nil]; \
}

#define ABSTRACT_METHOD_IMPL {\
@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]; \
__builtin_unreachable(); \
}

#define INVALID_INIT_METHOD_IMPL {\
@throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s is an invalid init method", __PRETTY_FUNCTION__] userInfo:nil]; \
__builtin_unreachable(); \
}

#define SINGLETON_METHOD_IMPL {\
    static id _sharedInstance = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _sharedInstance = [[self.class alloc] initSingleton]; \
    }); \
    return _sharedInstance; \
}

#define MakeWeakRef(A, B) __weak typeof(A) (B) = A
#define MakeStrongRef(A, B) __strong typeof(A) (B) = A

static inline id objectOrNil(id object)
{
    return (object == [NSNull null]) ? nil : object;
}

static inline id objectOrNull(id object)
{
    return (object == nil) ? [NSNull null] : object;
}

static inline BOOL nilEqual(id object1, id object2)
{
    return (objectOrNil(object1) == nil && objectOrNil(object2) == nil) || [object1 isEqual:object2];
}

static inline BOOL optionsIncludes(NSUInteger options, NSUInteger includes)
{
    return ((options & includes) == includes);
}
