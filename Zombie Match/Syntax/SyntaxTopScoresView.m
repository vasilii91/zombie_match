//
//  SyntaxTopScoresView.m
//  Syntax
//
//  Created by Seby Moisei on 10/6/12.
//
//

#import "SyntaxTopScoresView.h"
#import "ViewController.h"

@implementation SyntaxTopScoresView

- (id)initWithFrame:(CGRect)frame andViewController:(ViewController *)controller {
    self = [super initWithFrame:frame andViewController:controller];
    if (self) {
        self.alpha = 0;
        
        titleLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        titleLabel.center = CGPointMake(160, 30);
        titleLabel.text = @"TOP SCORES";
        [titleLabel styleWithSize:35];
        titleLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:titleLabel];
        
        primaryLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
        primaryLabel.center = CGPointMake(50, 60);
        primaryLabel.text = @"Levels";
        [primaryLabel styleWithSize:25];
        primaryLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:primaryLabel];
        
        actionLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
        actionLabel.center = CGPointMake(160, 60);
        actionLabel.text = @"Timed";
        [actionLabel styleWithSize:25];
        actionLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:actionLabel];
        
        infinityLabel = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
        infinityLabel.center = CGPointMake(270, 60);
        infinityLabel.text = @"Endless";
        [infinityLabel styleWithSize:25];
        infinityLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        [self addSubview:infinityLabel];
        
        NSArray *topScores = [viewController.statsManager getTopTenScoresForGameMode:0];
        
        score1Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score1Label.text = [NSString stringWithFormat:@"1. %d", [[topScores objectAtIndex:0 ]intValue]];
        score1Label.center = CGPointMake(160, 100);
        [score1Label styleWithSize:20];
        score1Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score1Label];
        
        score2Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score2Label.text = [NSString stringWithFormat:@"2. %d", [[topScores objectAtIndex:1 ]intValue]];
        score2Label.center = CGPointMake(160, 130);
        [score2Label styleWithSize:19];
        score2Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score2Label];
        
        score3Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score3Label.text = [NSString stringWithFormat:@"3. %d", [[topScores objectAtIndex:2 ]intValue]];
        score3Label.center = CGPointMake(160, 160);
        [score3Label styleWithSize:18];
        score3Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score3Label];
        
        score4Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score4Label.text = [NSString stringWithFormat:@"4. %d", [[topScores objectAtIndex:3 ]intValue]];
        score4Label.center = CGPointMake(160, 190);
        [score4Label styleWithSize:17];
        score4Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score4Label];
        
        score5Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score5Label.text = [NSString stringWithFormat:@"5. %d", [[topScores objectAtIndex:4 ]intValue]];
        score5Label.center = CGPointMake(160, 220);
        [score5Label styleWithSize:16];
        score5Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score5Label];
        
        score6Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score6Label.text = [NSString stringWithFormat:@"6. %d", [[topScores objectAtIndex:5 ]intValue]];
        score6Label.center = CGPointMake(160, 250);
        [score6Label styleWithSize:15];
        score6Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score6Label];
        
        score7Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score7Label.text = [NSString stringWithFormat:@"7. %d", [[topScores objectAtIndex:6 ]intValue]];
        score7Label.center = CGPointMake(160, 280);
        [score7Label styleWithSize:14];
        score7Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score7Label];
        
        score8Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score8Label.text = [NSString stringWithFormat:@"8. %d", [[topScores objectAtIndex:7 ]intValue]];
        score8Label.center = CGPointMake(160, 310);
        [score8Label styleWithSize:13];
        score8Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score8Label];
        
        score9Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score9Label.text = [NSString stringWithFormat:@"9. %d", [[topScores objectAtIndex:8 ]intValue]];
        score9Label.center = CGPointMake(160, 340);
        [score9Label styleWithSize:12];
        score9Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score9Label];
        
        score10Label = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 22)];
        score10Label.text = [NSString stringWithFormat:@"10. %d", [[topScores objectAtIndex:9 ]intValue]];
        score10Label.center = CGPointMake(160, 370);
        [score10Label styleWithSize:11];
        score10Label.textAlignment = UITextAlignmentLeft;
        [self addSubview:score10Label];    
        
        backButton = [[SyntaxLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 22)];
        backButton.text = @"<< BACK";
        backButton.center = CGPointMake(50, 410);
        [backButton styleWithSize:25];
        [self addSubview:backButton];
        
    }
    return self;
}

- (void)didMoveToSuperview {
    if (!isVisible) {
        isVisible = YES;
        [self fadeInView:self withAction:^{
            //
        }];
    }
    else isVisible = NO;
}

- (void)updateLabelsForGameType:(int)thisGameType {
    NSArray *topScores = [viewController.statsManager getTopTenScoresForGameMode:thisGameType];
    
    score1Label.text = [NSString stringWithFormat:@"1. %d", [[topScores objectAtIndex:0 ]intValue]];
        
    score2Label.text = [NSString stringWithFormat:@"2. %d", [[topScores objectAtIndex:1 ]intValue]];
   
    score3Label.text = [NSString stringWithFormat:@"3. %d", [[topScores objectAtIndex:2 ]intValue]];
   
    score4Label.text = [NSString stringWithFormat:@"4. %d", [[topScores objectAtIndex:3 ]intValue]];
       
    score5Label.text = [NSString stringWithFormat:@"5. %d", [[topScores objectAtIndex:4 ]intValue]];
    
    score6Label.text = [NSString stringWithFormat:@"6. %d", [[topScores objectAtIndex:5 ]intValue]];
    
    score7Label.text = [NSString stringWithFormat:@"7. %d", [[topScores objectAtIndex:6 ]intValue]];
    
    score8Label.text = [NSString stringWithFormat:@"8. %d", [[topScores objectAtIndex:7 ]intValue]];
  
    score9Label.text = [NSString stringWithFormat:@"9. %d", [[topScores objectAtIndex:8 ]intValue]];
   
    score10Label.text = [NSString stringWithFormat:@"10. %d", [[topScores objectAtIndex:9 ]intValue]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == backButton) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:backButton withAction:^{
            [self fadeOutView:self withAction:^{
                [viewController showMoreView];
                [viewController removeView:self];
            }];
        }];
    }
    if ([touch view] == primaryLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:primaryLabel withAction:^{
            primaryLabel.alpha = 1;
            actionLabel.alpha = 0.3;
            infinityLabel.alpha = 0.3;
            [self updateLabelsForGameType:0];
        }];
    }
    if ([touch view] == actionLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:actionLabel withAction:^{
            primaryLabel.alpha = 0.3;
            actionLabel.alpha = 1;
            infinityLabel.alpha = 0.3;
            [self updateLabelsForGameType:1];
        }];
    }
    if ([touch view] == infinityLabel) {
        [viewController.soundController playSound:@"GeneralMenuButton"];
        [self touchButton:infinityLabel withAction:^{
            primaryLabel.alpha = 0.3;
            actionLabel.alpha = 0.3;
            infinityLabel.alpha = 1;
            [self updateLabelsForGameType:2];
        }];
    }
}

- (void)dealloc {
    [self removeSubView:titleLabel];
    [self removeSubView:primaryLabel];
    [self removeSubView:actionLabel];
    [self removeSubView:infinityLabel];
    [self removeSubView:score1Label];
    [self removeSubView:score2Label];
    [self removeSubView:score3Label];
    [self removeSubView:score4Label];
    [self removeSubView:score5Label];
    [self removeSubView:score6Label];
    [self removeSubView:score7Label];
    [self removeSubView:score8Label];
    [self removeSubView:score9Label];
    [self removeSubView:score10Label];
    [self removeSubView:backButton];
    [super dealloc];
}
@end