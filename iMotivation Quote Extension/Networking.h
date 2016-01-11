//
//  Networking.h
//  Test5_objc
//
//  Created by Mohammed Abushawish on 2014-11-16. 
//  Copyright (c) 2014 Mohammed Abushawish. All rights reserved.
//

#import "Quote.h"
#import <Foundation/Foundation.h>

@interface Networking : NSObject

@property (nonatomic, copy) Quote *quoteFetched;

-(NSInteger) retrieveAndParseJson;
-(Quote*)    getFetchedQuote;

@end
