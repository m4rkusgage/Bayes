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
    [classifier trainClassifierWithFile:@"training"];
    
    BOOL test = [classifier isString:@"how i want lunch" classifiedAs:@"greeting"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
