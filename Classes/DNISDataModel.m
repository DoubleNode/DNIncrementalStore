//
//  DNISDataModel.m
//  Gateway Church and DoubleNode.com
//
//  Copyright (c) 2014 Gateway Church. All rights reserved.
//
//  Derived from work originally created by Darren Ehlers
//  Portions Copyright (c) 2012 DoubleNode.com and Darren Ehlers.
//  All rights reserved.
//

#import "DNISDataModel.h"

#import "NSManagedObjectContext+description.h"

#import "DNIncrementalStore.h"

#import "DNUtilities.h"

#define SAVE_TO_DISK_TIME_INTERVAL 1.0f

@interface DNISDataModel ()
{
}

@end

@implementation DNISDataModel

@synthesize persistentStore = _persistentStore;

+ (id)dataModel
{
    DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

    NSException*    exception = [NSException exceptionWithName:@"DNISDataModel Exception"
                                                        reason:@"dataModel class MUST be overridden!"
                                                      userInfo:nil];
    @throw exception;
}

+ (NSString*)dataModelName
{
    if ([self class] == [DNISDataModel class])
    {
        DLog(LL_Debug, LD_CoreData, @"Should NOT be here!");

        NSException*    exception = [NSException exceptionWithName:@"DNISDataModel Exception"
                                                            reason:@"dataModel class MUST be overridden!"
                                                          userInfo:nil];
        @throw exception;
    }

    // Assign DataModel class name format of: CD{DataModelName}DataModel
    return [NSStringFromClass([self class]) substringWithRange:NSMakeRange(2, [NSStringFromClass([self class]) length] - 11)];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.useIncrementalStore    = YES;
    }

    return self;
}

- (NSPersistentStore*)persistentStore
{
    if (_persistentStore)
    {
        return _persistentStore;
    }

    NSError*    error   = nil;

    if ([self useIncrementalStore] == NO)
    {
        return [super persistentStore];
    }
    else
    {
        NSString*   incrmentalStoreClass    = [NSString stringWithFormat:@"%@IncrementalStore", [[self class] dataModelName]];

        DNIncrementalStore* ist = (DNIncrementalStore*)[[self persistentStoreCoordinator] addPersistentStoreWithType:[NSClassFromString(incrmentalStoreClass) type]
                                                                                                       configuration:nil
                                                                                                                 URL:nil
                                                                                                             options:nil
                                                                                                               error:&error];
        if (ist != nil)
        {
            _persistentStore = [self persistentStoreWithPersistentStoreCoordinator:ist.backingPersistentStoreCoordinator];
            if (_persistentStore == nil)
            {
                DLog(LL_Critical, LD_CoreData, @"Error creating persistent store");
                abort();
            }
        }
    }

    return _persistentStore;
}

@end
