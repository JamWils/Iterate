//
//  DecimalValueFormatter.m
//  IterateOSX
//
//  Created by James Wilson on 9/19/14.
//  Copyright (c) 2014 Noesis Ingenuity LLC. All rights reserved.
//

#import "DecimalValueFormatter.h"

@implementation DecimalValueFormatter

//- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString *__autoreleasing *)newString errorDescription:(NSString *__autoreleasing *)error {
//    BOOL returnValue = YES;
////    if (partialString.length == 0) {
////        returnValue = YES;
////    }
////    
////    NSScanner *scanner = [NSScanner scannerWithString:partialString];
////    
////    if (!([scanner scanInt:0] && [scanner isAtEnd])) {
//////        NSBeep();
////        returnValue = NO;
////    }
//    
//    if (newString) { *newString = nil;}
//    if (error) {*error = nil;}
//    
//    static NSCharacterSet *nonDecimalCharacters = nil;
//    if (nonDecimalCharacters == nil) {
//        nonDecimalCharacters = [[NSCharacterSet decimalDigitCharacterSet] invertedSet] ;
////        [DecimalValueFormatter logCharacterSet:nonDecimalCharacters];
//    }
//    
//    if ([partialString length] == 0) {
//        returnValue = YES; // The empty string is okay (the user might just be deleting everything and starting over)
//    } else if ([partialString rangeOfCharacterFromSet:nonDecimalCharacters].location != NSNotFound) {
//        returnValue = NO; // Non-decimal characters aren't cool!
//    }
//    
//    
//    return returnValue;
//}

- (BOOL)getObjectValue:(out __autoreleasing id *)obj forString:(NSString *)string errorDescription:(out NSString *__autoreleasing *)error
{
    if (error != NULL) {
        NSLog(@"Error %@", *error);
    }
    
    return [super getObjectValue:obj forString:string errorDescription:error];
}

+ (void) logCharacterSet:(NSCharacterSet*)characterSet
{
    unichar unicharBuffer[20];
    int index = 0;
    
    for (unichar uc = 0; uc < (0xFFFF); uc ++)
    {
        if ([characterSet characterIsMember:uc])
        {
            unicharBuffer[index] = uc;
            
            index ++;
            
            if (index == 20)
            {
                NSString * characters = [NSString stringWithCharacters:unicharBuffer length:index];
                NSLog(@"%@", characters);
                
                index = 0;
            }
        }
    }
    
    if (index != 0)
    {
        NSString * characters = [NSString stringWithCharacters:unicharBuffer length:index];
        NSLog(@"%@", characters);
    }
}

@end
