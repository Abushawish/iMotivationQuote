//
//  Quote.m
//  Test5_objc
//
//  Created by Mohammed Abushawish on 2014-11-16.
//  Copyright (c) 2014 Mohammed Abushawish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quote.h"

@implementation Quote
@synthesize quoteText, quoteAuthor, quoteLink;

//Constructor for the Quote class
- (id) initWithQuoteText: (NSString *) tempQuoteText andQuoteAuthor: (NSString *) tempQuoteAuthor andQuoteLink: (NSString *) tempQuoteLink {
    
    if(self = [super init]) {
        [self setQuoteText:tempQuoteText];
        [self setQuoteAuthor:tempQuoteAuthor];
        [self setQuoteLink:tempQuoteLink];
    }
    
    return self;
}

@end