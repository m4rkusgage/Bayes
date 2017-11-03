//
//  NaiveBayesClassifier.m
//  BayesClassifier
//
//  Created by Markus Gage on 2017-11-03.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "NaiveBayesClassifier.h"
#import <UIKit/UIKit.h>

@interface NaiveBayesClassifier ()
@property (strong, nonatomic) NSMutableDictionary *labelWords;
@property (strong, nonatomic) NSMutableDictionary *wordFrequency;
@end

@implementation NaiveBayesClassifier

- (void)trainClassifierWithString:(NSString *)string forLabel:(NSString *)label {
    NSArray *wordBag = [self tokenizeString:[string lowercaseString]];
    [self updateLabel:label withWordArray:wordBag];
}

- (NSString *)classifyString:(NSString *)string {
    NSString *currentClassification = @"UNKNOWN";
    CGFloat maxScore = 0;
    
    for (NSString *label in self.labelWords) {
        CGFloat currentScore = [self calculateScoreFromString:[string lowercaseString] againstLabel:label];
        if (currentScore > maxScore) {
            maxScore = currentScore;
            currentClassification = label;
        }
    }
    
    if (!maxScore) {
        //there is no classification
    }
    return currentClassification;
}

- (NSArray *)tokenizeString:(NSString *)string {
    NSMutableArray *tokenizeWords = [[NSMutableArray alloc] init];
    
    NSLinguisticTagger *wordTagger = [[NSLinguisticTagger alloc] initWithTagSchemes:@[NSLinguisticTagSchemeLemma] options:NSLinguisticTaggerOmitPunctuation|NSLinguisticTaggerOmitWhitespace|NSLinguisticTaggerJoinNames];
    wordTagger.string = string;
    
    NSRange range = NSMakeRange(0, string.length);
    
    [wordTagger enumerateTagsInRange:range unit:NSLinguisticTaggerUnitWord scheme:NSLinguisticTagSchemeLemma options:NSLinguisticTaggerOmitPunctuation|NSLinguisticTaggerOmitWhitespace|NSLinguisticTaggerJoinNames usingBlock:^(NSLinguisticTag  _Nullable tag, NSRange tokenRange, BOOL * _Nonnull stop) {
        
        NSString *token = [string substringWithRange:tokenRange];
        [tokenizeWords addObject:token];
        
    }];
    
    return tokenizeWords;
}

- (void)updateLabel:(NSString *)label withWordArray:(NSArray *)bagOfWords {
    for (NSString *word in bagOfWords) {
        if (self.wordFrequency[word]) {
            NSInteger wordCount = [self.wordFrequency[word] integerValue];
            wordCount += 1;
            self.wordFrequency[word] = [NSNumber numberWithInteger:wordCount];
        } else {
            self.wordFrequency[word] = @1;
        }
        
        NSMutableSet *wordSet = self.labelWords[label];
        if (wordSet) {
            [wordSet addObject:word];
        } else {
            wordSet = [[NSMutableSet alloc] initWithObjects:word, nil];
        }
        self.labelWords[label] = wordSet;
    }
}

- (CGFloat)calculateScoreFromString:(NSString *)string againstLabel:(NSString *)label {
    CGFloat score = 0.0f;
    NSArray *tokenizeWords = [self tokenizeString:string];
    
    for (NSString *word in tokenizeWords) {
        if ([self.labelWords[label] containsObject:word]) {
            score += (CGFloat)(1/[self.wordFrequency[word] integerValue]);
        }
    }
    return score;
}

- (NSMutableDictionary *)labelWords {
    if (!_labelWords) {
        _labelWords = [[NSMutableDictionary alloc] init];
    }
    return _labelWords;
}

- (NSMutableDictionary *)wordFrequency {
    if (!_wordFrequency) {
        _wordFrequency = [[NSMutableDictionary alloc] init];
    }
    return _wordFrequency;
}

@end

