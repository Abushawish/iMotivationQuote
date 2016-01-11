//
//  Networking.m
//  Test5_objc
//
//  Created by Mohammed Abushawish on 2014-11-16.
//  Copyright (c) 2014 Mohammed Abushawish. All rights reserved.
//

#import "Networking.h"

@implementation Networking
@synthesize quoteFetched;


- (NSInteger)retrieveAndParseJson {
    
    //Prepare POST request details
    NSInteger success             = 1;
    NSURL     *url                = [NSURL URLWithString:
                                     @"http://api.forismatic.com/api/1.0/"];
    NSString  *post               = [NSString stringWithFormat:
                                     @"method=getQuote&format=json&lang=en"];
    NSData    *postData           = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString  *postLength         = [NSString stringWithFormat:
                                     @"%lu", (unsigned long)[postData length]];
    NSMutableURLRequest *request  = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSError *requestError       = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData             = [NSURLConnection sendSynchronousRequest:request
                                                        returningResponse:&response
                                                                    error:&requestError];
    
    //Communication succeeded
    if ([response statusCode] >= 200 && [response statusCode] < 300) {
        NSError *serializeError = nil;
        NSDictionary *jsonData  = [NSJSONSerialization
                                   JSONObjectWithData:urlData
                                   options:NSJSONReadingMutableContainers
                                   error:&serializeError];
        success                 = [jsonData[@"ERROR"] integerValue];
        
        if (success == 0) {
            NSString *quoteText   = jsonData[@"quoteText"];
            NSString *quoteAuthor = jsonData[@"quoteAuthor"];
            NSString *quoteLink   =  jsonData[@"quoteLink"];
            quoteFetched          = [[Quote alloc] initWithQuoteText:quoteText
                                                      andQuoteAuthor:quoteAuthor
                                                        andQuoteLink:quoteLink];
            NSLog(@"%@", quoteFetched.quoteText);
            return 0; //No error
        } else {
            return 1; //Error from server
        }
    } else {
        return 2; //Cannot communicate with server
    }
}

-(Quote*) getFetchedQuote {
    return quoteFetched;
}

@end