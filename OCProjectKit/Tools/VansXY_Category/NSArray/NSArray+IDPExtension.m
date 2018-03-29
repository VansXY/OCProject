//
//  NSArray+IDPExtension.m
//  IDP
//
//  Created by douj on 13-3-6.
//  Copyright (c) 2012年 baidu. All rights reserved.
//

#import "NSArray+IDPExtension.h"

@implementation NSArray (IDPExtension)

- (NSArray *)head:(NSUInteger)count
{
	if ( [self count] < count  || count == 0  )
	{
		return self;
	}
	else
	{
		NSMutableArray * tempFeeds = [NSMutableArray array];
		for ( NSObject * elem in self )
		{
			[tempFeeds addObject:elem];
			if ( [tempFeeds count] >= count )
				break;
		}
		return tempFeeds;
	}
}

- (NSArray *)tail:(NSUInteger)count
{
    if ( [self count] < count) {
        return self;
    }
    NSRange range;
    range.location = [self count] -count;
    range.length = count;
	return [self subarrayWithRange:range];
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
	if ( index >= self.count )
		return nil;
    
	return [self objectAtIndex:index];
}

-(NSData*)data
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}
@end

#pragma mark -

@implementation NSMutableArray (IDPExtension)

- (NSMutableArray *)pushHead:(NSObject *)obj
{
	if ( obj )
	{
		[self insertObject:obj atIndex:0];
	}
	
	return self;
}

- (NSMutableArray *)pushHeadN:(NSArray *)all
{
	if ( [all count] )
	{
		for ( NSUInteger i = [all count]; i > 0; --i )
		{
			[self insertObject:[all objectAtIndex:i - 1] atIndex:0];
		}
	}
	
	return self;
}

- (NSMutableArray *)popTail
{
	if ( [self count] > 0 )
	{
		[self removeObjectAtIndex:[self count] - 1];
	}
	
	return self;
}

- (NSMutableArray *)popTailN:(NSUInteger)n
{
	if ( [self count] > 0 )
	{
		if ( n >= [self count] )
		{
			[self removeAllObjects];
		}
		else
		{
			NSRange range;
			range.location = [self count] - n;
			range.length =n;
			
			[self removeObjectsInRange:range];
		}
	}
	
	return self;
}

- (NSMutableArray *)pushTail:(NSObject *)obj
{
	if ( obj )
	{
		[self addObject:obj];
	}
	
	return self;
}

- (NSMutableArray *)pushTailN:(NSArray *)all
{
	if ( [all count] )
	{
		[self addObjectsFromArray:all];
	}
	
	return self;
}

- (NSMutableArray *)popHead
{
	if ( [self count] )
	{
		[self removeObjectAtIndex:0];
	}
	
	return self;
}

- (NSMutableArray *)popHeadN:(NSUInteger)n
{
	if ( [self count] > 0 )
	{
		if ( n >= [self count] )
		{
			[self removeAllObjects];
		}
		else
		{
			NSRange range;
			range.location = 0;
			range.length = n;
			
			[self removeObjectsInRange:range];
		}
	}
	
	return self;
}

- (NSMutableArray *)keepHead:(NSUInteger)n
{
	if ( [self count] > n )
	{
		NSRange range;
		range.location = n;
		range.length = [self count] - n;
		
		[self removeObjectsInRange:range];
	}
	
	return self;
}

- (NSMutableArray *)keepTail:(NSUInteger)n
{
	if ( [self count] > n )
	{
		NSRange range;
		range.location = 0;
		range.length = [self count] - n;
		
		[self removeObjectsInRange:range];
	}
	
	return self;
}

-(bool)safeInsertObject:(id)anObject atIndex:(NSUInteger)index
{
    if ( index >= self.count )
	{
        return NO;
    }
    [self insertObject:anObject atIndex:index];
    return YES;
}

-(bool)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if ( index >= self.count )
	{
        return NO;
    }
    [self removeObjectAtIndex:index];
    return YES;

}
-(bool)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if ( index >= self.count )
	{
        return NO;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
    return YES;
}


@end
