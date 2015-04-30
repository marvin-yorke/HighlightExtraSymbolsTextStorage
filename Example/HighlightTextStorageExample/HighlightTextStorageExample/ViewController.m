//
//  ViewController.m
//  HighlightTextStorageExample
//
//  Created by Maxim Smirnov on 30/04/15.
//  Copyright (c) 2015 Maxim Smirnov. All rights reserved.
//

#import "ViewController.h"
#import "HighlightExtraSymbolsTextStorage.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, strong) HighlightExtraSymbolsTextStorage *textStorage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. Create the text storage that backs the editor
    NSDictionary* attrs = @{NSFontAttributeName:
                                [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:@"Hello world"
                                                                     attributes:attrs];
    
    _textStorage = [[HighlightExtraSymbolsTextStorage alloc] initWithMaximumTextLength:100];
    [_textStorage appendAttributedString:attrString];
    
    // 2. Create the layout manager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    
    CGRect rect = CGRectInset(self.view.bounds, 10, 10);
    rect.origin.y += 10;
    
    // 3. Create a text container
    CGSize containerSize = CGSizeMake(rect.size.width,  CGFLOAT_MAX);
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:containerSize];
    container.widthTracksTextView = YES;
    [layoutManager addTextContainer:container];
    [_textStorage addLayoutManager:layoutManager];
    
    // 4. Create a UITextView
    UITextView *textView = [[UITextView alloc] initWithFrame:rect
                                               textContainer:container];
    
    [self.view addSubview:textView];
    
    self.textView = textView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
