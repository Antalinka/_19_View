//
//  GRViewController.m
//  _19_View
//
//  Created by Exo-terminal on 4/11/14.
//  Copyright (c) 2014 Evgenia. All rights reserved.
//

#import "GRViewController.h"

@interface GRViewController ()

@property (strong, nonatomic) UIView* whiteView;
@property (strong, nonatomic)NSDictionary* dictionary;
@end

@implementation GRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    NSInteger width = (self.view.frame.size.width-30)/8;
    
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - width*8)/2,
                                                             (self.view.bounds.size.height - width*8)/2,
                                                             width * 8, width * 8)];
    
    self.whiteView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin |
                                       UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    self.whiteView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    
    [self.view addSubview:self.whiteView];
    
    [self createChessboad];

}

-(NSDictionary*) createChessboad{
    
    NSInteger x,y;
    NSInteger numberOfBlock = 1;
    NSInteger numberOfLine = 0;
    NSInteger width = (self.view.frame.size.width-30)/8;
    NSMutableArray* arrayTop = [[NSMutableArray alloc]init];
    NSMutableArray* arrayBottom = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j = j + 2) {
            if (numberOfLine %2) {
                x = width * j + width ;
                y = width * numberOfLine;
            }else{
                x = width * j;
                y = width * numberOfLine;
            }
            CGRect rect = CGRectMake(x + (self.view.bounds.size.height - width*8)/2, y + (self.view.bounds.size.width - width*8)/2, width, width);
            
            if (numberOfLine < 3) {
                [arrayTop addObject:[NSValue valueWithCGRect:rect]];
            }else if(numberOfLine > 4) {
                 [arrayBottom addObject:[NSValue valueWithCGRect:rect]];
            }
            
            UIView* blackSquare = [[UIView alloc]initWithFrame:rect];
            blackSquare.tag = 1;
            blackSquare.backgroundColor = [UIColor blackColor];
            [self.view addSubview:blackSquare];
            
           numberOfBlock++;
        }
        numberOfLine++;
    }
    NSDictionary* dict = [[NSDictionary alloc]initWithObjectsAndKeys:arrayTop,@"top",
                                                                     arrayBottom,@"bottom",nil];
    return dict;
 }

-(NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(void) changeColor: (UIColor*) color{
    
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            
            if (view.tag == 1) {
                
                view.backgroundColor = color;

             }
        }
    }
}

-(void) removeSubview{
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            
            if (view.tag == 1 || view.tag == 2) {
                
                [view removeFromSuperview];
                
            }
        }
    }
}
/*
-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self removeSubview];
    [self createChessboadWithWidth];
    
    UIColor* color = [[UIColor alloc]init];
    
    switch (fromInterfaceOrientation) {
        case UIInterfaceOrientationLandscapeRight:             color = [UIColor colorWithRed:0.22 green:0.04 blue: 0.08 alpha:1.1];
            break;
        case UIInterfaceOrientationPortrait:                   color = [UIColor blackColor];
            break;
        case UIInterfaceOrientationLandscapeLeft:              color = [UIColor colorWithRed:0.62 green:0.87 blue:0.89 alpha:1];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:         color = [UIColor colorWithRed:0.37 green:0.72 blue:0.75 alpha:1];
    }
    [self changeColor:color];
}*/

- (NSMutableArray*) createSmallSquareWithArray: (NSArray*) arrayAll color:(UIColor*) color{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    for (NSValue *value in arrayAll) {
        
        CGRect rect = [value CGRectValue];
        rect = CGRectInset(rect, 24, 24);
        
        UIView *view = [[UIView alloc]initWithFrame:rect];
        view.backgroundColor = color;
        view.tag = 2;
        [self.view addSubview:view];
        
        NSInteger i = [self.view.subviews indexOfObject:view];
       
        [array addObject:[NSNumber numberWithInteger:i]];
     }
    return array;
}

-(void) rotateСhequersWithArrayOne: (NSMutableArray*) arrayPlayerOne{
    
    for(UIView * obj in [self.view subviews]) {

        if(obj.tag == 2){
            
        NSInteger intPlayerOne = arc4random()%([arrayPlayerOne count]-1);
        
        NSNumber* playerOne = [arrayPlayerOne objectAtIndex:intPlayerOne];
        
        intPlayerOne = [playerOne integerValue];
        
        UIView* viewOne = [self.view.subviews objectAtIndex:intPlayerOne];
            
        CGRect rectOne = viewOne.frame;
        CGRect rectTwo = obj.frame;
       
        obj.frame = CGRectMake(rectOne.origin.x, rectOne.origin.y, rectOne.size.width, rectOne.size.height);
            
         [UIView animateWithDuration:0.5f
                                  delay:0.5f
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^
            {
                viewOne.frame = CGRectMake(rectTwo.origin.x, rectTwo.origin.y, rectTwo.size.width, rectTwo.size.height);
            } completion:^(BOOL finished) {
            }];
   
        [self.view insertSubview:obj belowSubview:[self.view.subviews objectAtIndex:intPlayerOne]];
        }
    }
}


-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
 
    [self removeSubview];
    
    NSDictionary* dict = [self createChessboad];
    
    NSMutableArray* arrayTop = [[NSMutableArray alloc]init];
    NSMutableArray* arrayBottom = [[NSMutableArray alloc]init];
    
    NSMutableArray* arrayTopIndex = [[NSMutableArray alloc]init];
    NSMutableArray* arrayBottomIndex = [[NSMutableArray alloc]init];
    
    arrayTop = [dict objectForKey:@"top"];
    arrayBottom = [dict objectForKey:@"bottom"];
    
    arrayTopIndex = [self createSmallSquareWithArray:arrayTop color:[UIColor grayColor]];
    arrayBottomIndex = [self createSmallSquareWithArray:arrayBottom color:[UIColor whiteColor]];
    
    [arrayTopIndex addObjectsFromArray:arrayBottomIndex];
    
    [self performSelector:@selector(rotateСhequersWithArrayOne:) withObject:arrayTopIndex afterDelay:1.0 ];
    
    
    UIColor* color = [[UIColor alloc]init];
    
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationLandscapeRight:             color = [UIColor colorWithRed:0.22 green:0.04 blue: 0.08 alpha:1.1];
            break;
        case UIInterfaceOrientationPortrait:                   color = [UIColor blackColor];
            break;
        case UIInterfaceOrientationLandscapeLeft:              color = [UIColor colorWithRed:0.62 green:0.87 blue:0.89 alpha:1];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:         color = [UIColor colorWithRed:0.37 green:0.72 blue:0.75 alpha:1];
    }
    [self changeColor:color];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
