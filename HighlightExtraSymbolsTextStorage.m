//
//  TextStorage.m
//  TextStorageTest
//
//  Created by Maxim Smirnov on 29/04/15.
//  Copyright (c) 2015 Maxim Smirnov. All rights reserved.
//

#import "HighlightExtraSymbolsTextStorage.h"

@interface HighlightExtraSymbolsTextStorage ()
{
    NSMutableAttributedString *_backingStore;
    NSUInteger _maxLength;
}

@end

@implementation HighlightExtraSymbolsTextStorage

- (instancetype)init
{
    return [self initWithMaximumTextLength:5000];
}

- (instancetype)initWithMaximumTextLength:(NSUInteger)maxLength
{
    return [self initWithMaximumTextLength:maxLength text:@""];
}

- (instancetype)initWithMaximumTextLength:(NSUInteger)maxLength text:(NSString *)text
{
    self = [super init];
    if (self) {
        _normalAttributes = @{ NSBackgroundColorAttributeName : [UIColor whiteColor],
                               NSForegroundColorAttributeName : [UIColor blackColor],
                               NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:16.0f] };
        
        _highlightAttributes = @{ NSBackgroundColorAttributeName : [UIColor colorWithRed:1 green:0.921 blue:0.901 alpha:1],
                                  NSForegroundColorAttributeName : [UIColor blackColor],
                                  NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:16.0f] };
        
        _backingStore = [[NSMutableAttributedString alloc] initWithString:text attributes:_normalAttributes];
        _maxLength = maxLength;
        
        [self applyAttributes];
    }
    
    return self;
}

- (NSString *)string
{
    return [_backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location
                             effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    NSLog(@"replaceCharactersInRange:%@ withString:%@", NSStringFromRange(range), str);
    
    [self beginEditing];
    
    [_backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes
            range:range changeInLength:str.length - range.length];
    
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    NSLog(@"setAttributes:%@ range:%@", attrs, NSStringFromRange(range));
    
    [self beginEditing];
    
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    
    [self endEditing];
}

- (void)processEditing
{
    [self applyAttributes];
    [super processEditing];
}

- (void)applyAttributes
{
    [_backingStore setAttributes:self.normalAttributes
                           range:NSMakeRange(0, _backingStore.length)];
    
    if (_backingStore.length > _maxLength) {
        [_backingStore setAttributes:self.highlightAttributes
                               range:NSMakeRange(_maxLength, _backingStore.length - _maxLength)];
    }
}
@end
