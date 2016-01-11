//
//  Quote.h
//  Test5_objc
//
//  Created by Mohammed Abushawish on 2014-11-16.
//  Copyright (c) 2014 Mohammed Abushawish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject

@property (nonatomic, copy) NSString *quoteText;
@property (nonatomic, copy) NSString *quoteAuthor;
@property (nonatomic, copy) NSString *quoteLink;

//Constructor for the Quote class
- (id) initWithQuoteText: (NSString *) tempQuoteText andQuoteAuthor:
                          (NSString *) tempQuoteAuthor andQuoteLink:
                          (NSString *) tempQuoteLink;

@end