//
//  ViewController.m
//  Example
//
//  Created by Markus Gage on 2017-11-03.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "ViewController.h"
#import "BayesClassifier.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NaiveBayesClassifier *classifier = [[NaiveBayesClassifier alloc] init];
    [classifier trainClassifierWithFile:@"Greetings"];
    
    NSString *testString = @"hello";
    NSString *testStringTwo = @"how i want lunch";
    BOOL test = [classifier isString:testString classifiedAs:@"greetings"];
    BOOL testTwo = [classifier isString:testStringTwo classifiedAs:@"greetings"];
    
    NSLog(@"is: '%@' a greeting: %@",testString,@(test));
    NSLog(@"is: '%@' a greeting: %@",testStringTwo,@(testTwo));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
