//
//  TSTempData.m
//  TigglyStamp
//
//  Created by Sachin Patil on 05/10/13.
//  Copyright (c) 2013 Sachin Patil. All rights reserved.
//

#import "TSTempData.h"
#import "TConstant.h"

@implementation TSTempData

@synthesize emailId,childAgeGroup,subscriptionEmailId;

-(id) initWithEmailId:(NSString *) email withChildAgeGroup:(NSString *) ageGroup{
    DebugLog(@"");
    self = [super init];
    if (self) {
        self.emailId = email;
        self.childAgeGroup = ageGroup;
        self.subscriptionEmailId = @"";
    }
    return self;
}

-(id) initWithEmailId:(NSString *) email{
    DebugLog(@"");
    self = [super init];
    if (self) {
        self.emailId = @"";
        self.childAgeGroup = @"";
        self.subscriptionEmailId = email;
    }
    return self;
}


- (id) initWithCoder:(NSCoder *)aDecoder {
    DebugLog(@"");
    if ( (self = [super init] ) ) {
      
        emailId = [aDecoder decodeObjectForKey:@"emailId"];
        childAgeGroup = [aDecoder decodeObjectForKey:@"childAgeGroup"];
        subscriptionEmailId = [aDecoder decodeObjectForKey:@"subscriptionEmailId"];
        
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    DebugLog(@"");
  
    [aCoder encodeObject:emailId forKey:@"emailId"];
    [aCoder encodeObject:childAgeGroup  forKey:@"childAgeGroup"];
    [aCoder encodeObject:subscriptionEmailId forKey:@"subscriptionEmailId"];
}


@end
