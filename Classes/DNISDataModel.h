//
//  DNISDataModel.h
//  Gateway Church and DoubleNode.com
//
//  Copyright (c) 2014 Gateway Church. All rights reserved.
//
//  Derived from work originally created by Darren Ehlers
//  Portions Copyright (c) 2012 DoubleNode.com and Darren Ehlers.
//  All rights reserved.
//

#import "DNDataModel.h"

@interface DNISDataModel : DNDataModel

@property (assign, atomic)      BOOL        useIncrementalStore;

+ (id)dataModel;
+ (NSString*)dataModelName;

- (id)init;

- (NSString*)storeType;
- (NSURL*)getPersistentStoreURL;

- (void)deletePersistentStore;
- (void)saveContext;

- (NSManagedObjectContext*)createNewManagedObjectContext;

- (void)performWithContext:(NSManagedObjectContext*)context
              blockAndWait:(void (^)(NSManagedObjectContext*))block;
- (void)performWithContext:(NSManagedObjectContext*)context
                     block:(void (^)(NSManagedObjectContext*))block;

@end
