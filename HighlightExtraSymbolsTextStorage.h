//
//  TextStorage.h
//  TextStorageTest
//
//  Created by Maxim Smirnov on 29/04/15.
//  Copyright (c) 2015 Maxim Smirnov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighlightExtraSymbolsTextStorage : NSTextStorage

- (instancetype)initWithMaximumTextLength:(NSUInteger)maxLength;
- (instancetype)initWithMaximumTextLength:(NSUInteger)maxLength text:(NSString *)text;

@property (nonatomic, strong) NSDictionary *normalAttributes;
@property (nonatomic, strong) NSDictionary *highlightAttributes;

@end
