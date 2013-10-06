//
//  TSTempData.h
//  TigglySafari
//
//  Created by Sachin Patil on 05/10/13.
//  Copyright (c) 2013 Sachin Patil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSTempData : NSObject <NSCoding> {
    NSString *emailId;
    NSString *childAgeGroup;
    NSString *subscriptionEmailId;
}

@property(nonatomic,strong) NSString *emailId;
@property(nonatomic,strong) NSString *childAgeGroup;
@property(nonatomic,strong) NSString *subscriptionEmailId;

-(id) initWithEmailId:(NSString *) email withChildAgeGroup:(NSString *) ageGroup;
-(id) initWithEmailId:(NSString *) email;

@end
