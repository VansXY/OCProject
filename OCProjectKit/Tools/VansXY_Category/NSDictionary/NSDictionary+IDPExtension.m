//
//
//  NSDictionary+IDPExtension.m
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import "NSDictionary+IDPExtension.h"

@implementation NSDictionary (IDPExtension)

- (NSObject *)objectAtPath:(NSString *)path
{
    if (!path || path.length <=0 ) {
        return nil;
    }
	NSDictionary *dictProgress = [self copy];
    NSArray *strings = [path componentsSeparatedByString:@"/"];
    NSString *lastkey=[strings lastObject];
    for (int i=0;i<[strings count]-1;i++){
        NSString *pth=[strings objectAtIndex:i];
        if ([pth length]>0){
            if ([dictProgress isKindOfClass:[NSDictionary class]]){
                dictProgress=[dictProgress objectForKey:pth];
            }
            else
            {
//                @throw [NSException exceptionWithName:NSInvalidArchiveOperationException
//                                               reason:@"NSDictionnary::Path incorrect"
//                                             userInfo:nil];
                return nil;
            }
        }
    }
    if (dictProgress && [dictProgress isKindOfClass:[NSDictionary class]]) {
        return [dictProgress objectForKey:lastkey];
    }else
    {
        return nil;
    }
    
}

- (NSObject *)objectAtPath:(NSString *)path otherwise:(NSObject *)other
{
	NSObject * obj = [self objectAtPath:path];
	return obj ? obj : other;
}

- (BOOL)boolAtPath:(NSString *)path
{
	return [self boolAtPath:path otherwise:NO];
}

- (BOOL)boolAtPath:(NSString *)path otherwise:(BOOL)other
{
	NSObject * obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] )
	{
		return NO;
	}
	else if ( [obj isKindOfClass:[NSNumber class]] )
	{
		return [(NSNumber *)obj intValue] ? YES : NO;
	}
	else if ( [obj isKindOfClass:[NSString class]] )
	{
		if ( [(NSString *)obj hasPrefix:@"y"] ||
			[(NSString *)obj hasPrefix:@"Y"] ||
			[(NSString *)obj hasPrefix:@"T"] ||
			[(NSString *)obj hasPrefix:@"t"] ||
			[(NSString *)obj isEqualToString:@"1"] )
		{
			// YES/Yes/yes/TRUE/Ture/true/1
			return YES;
		}
		else
		{
			return NO;
		}
	}
    
	return other;
}

- (NSNumber *)numberAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] )
	{
		return nil;
	}
	else if ( [obj isKindOfClass:[NSNumber class]] )
	{
		return (NSNumber *)obj;
	}
	else if ( [obj isKindOfClass:[NSString class]] )
	{
		return [NSNumber numberWithDouble:[(NSString *)obj doubleValue]];
	}
    
	return nil;
}

- (NSNumber *)numberAtPath:(NSString *)path otherwise:(NSNumber *)other
{
	NSNumber * obj = [self numberAtPath:path];
	return obj ? obj : other;
}

- (NSString *)stringAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	if ( [obj isKindOfClass:[NSNull class]] )
	{
		return nil;
	}
	else if ( [obj isKindOfClass:[NSNumber class]] )
	{
        return [NSString stringWithFormat:@"%@",(NSNumber *)obj];
//		return [NSString stringWithFormat:@"%d", [(NSNumber *)obj intValue]];
	}
	else if ( [obj isKindOfClass:[NSString class]] )
	{
		return (NSString *)obj;
	}
	
	return nil;
}

- (NSString *)stringAtPath:(NSString *)path otherwise:(NSString *)other
{
	NSString * obj = [self stringAtPath:path];
	return obj ? obj : other;
}

- (NSArray *)arrayAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSArray class]] ? (NSArray *)obj : nil;
}

- (NSArray *)arrayAtPath:(NSString *)path otherwise:(NSArray *)other
{
	NSArray * obj = [self arrayAtPath:path];
	return obj ? obj : other;
}

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSMutableArray class]] ? (NSMutableArray *)obj : nil;
}

- (NSMutableArray *)mutableArrayAtPath:(NSString *)path otherwise:(NSMutableArray *)other
{
	NSMutableArray * obj = [self mutableArrayAtPath:path];
	return obj ? obj : other;
}

- (NSDictionary *)dictAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSDictionary class]] ? (NSDictionary *)obj : nil;
}

- (NSDictionary *)dictAtPath:(NSString *)path otherwise:(NSDictionary *)other
{
	NSDictionary * obj = [self dictAtPath:path];
	return obj ? obj : other;
}

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path
{
	NSObject * obj = [self objectAtPath:path];
	return [obj isKindOfClass:[NSMutableDictionary class]] ? (NSMutableDictionary *)obj : nil;
}

- (NSMutableDictionary *)mutableDictAtPath:(NSString *)path otherwise:(NSMutableDictionary *)other
{
	NSMutableDictionary * obj = [self mutableDictAtPath:path];
	return obj ? obj : other;
}

-(NSData*)data
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}
@end
