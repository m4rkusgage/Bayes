//
//  NaiveBayesClassifier.h
//  BayesClassifier
//
//  Created by Markus Gage on 2017-11-03.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NaiveBayesClassifier : NSObject

//Methods to train the classifier
- (void)trainClassifierWithString:(NSString *)string forLabel:(NSString *)label;
- (void)trainClassifierWithDictionary:(NSDictionary *)dictionary;
- (void)trainClassifierWithArray:(NSArray *)array;

//Method to check how well the classifier is trained
- (BOOL)isString:(NSString *)string classifiedAs:(NSString *)label;

//Method to determine the classification of a string
- (NSString *)classifyString:(NSString *)string;

@end
