//
//  FoolSaverView.m
//  FoolSaver
//
//  Created by Kevin Wojniak on 8/16/05.
//  Copyright (c) 2005, __MyCompanyName__. All rights reserved.
//

#import "FoolSaverView.h"
#import "PrefsController.h"


@implementation FoolSaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
	if (self = [super initWithFrame:frame isPreview:isPreview])
	{
		srandom(time(NULL));
		drawPoint = NSMakePoint(-1.0, -1.0);
		prefs = nil;
		[self updateImage:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateImage:) name:@"FoolPrefsClose" object:nil];
		
		[self setAnimationTimeInterval:10.0];
	}
	
	return self;
}

- (void)dealloc
{
	[winXPPro release];
	[prefs release];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[super dealloc];
}

- (void)updateImage:(NSNotification *)notification
{
	int windowsImage = 0;

	NSNumber *obj = [notification object];
	if (obj == nil)
	{
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[@"~/Library/Preferences/com.kainjow.FoolSaver.plist" stringByExpandingTildeInPath]];
		if (dict)
		{
			NSNumber *prefObj = [dict objectForKey:@"WindowsImage"];
			if (prefObj)
				windowsImage = [prefObj intValue];
		}
	}
	else
	{
		windowsImage = [obj intValue];
	}
	
	[winXPPro release];
	winXPPro = [[NSImage alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:[NSString stringWithFormat:@"%d",windowsImage] ofType:@"png"]];
	
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
	
	if (NSEqualPoints(drawPoint, NSMakePoint(-1.0, -1.0)))
		return;
	
	NSRect bounds = [self bounds];
	
	[[NSColor blackColor] set];
	[NSBezierPath fillRect:bounds];
	
	NSRect drawFromRect, drawInRect;
	drawFromRect.origin = NSMakePoint(0.0, 0.0);
	drawFromRect.size = [winXPPro size];
	
	drawInRect.origin = drawPoint;
	drawInRect.size = [winXPPro size];
	
	[winXPPro drawInRect:drawInRect
				fromRect:drawFromRect
			   operation:NSCompositeSourceOver
				fraction:1.0];
}

- (void)animateOneFrame
{
	NSRect bounds = [self bounds];
	drawPoint = NSMakePoint(random() % (int)(bounds.size.width - [winXPPro size].width), random() % (int)(bounds.size.height - [winXPPro size].height));
	[self setNeedsDisplay:YES];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow *)configureSheet
{
	if (prefs == nil)
		prefs = [[PrefsController alloc] init];
    return [prefs window];
}

@end
