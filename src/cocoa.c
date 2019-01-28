#include <stdio.h>

#import <Cocoa/Cocoa.h>


#ifdef __cplusplus
    extern "C" {
#endif
void test_render(void* win2) {
        NSWindow* win = win2;

        /* NSView* containerView = [[NSView alloc] init]; */
        NSView* view = [win contentView];

        /* [containerView addSubview:view]; */
       /* [win setContentView:containerView]; */

       NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(100, 100, 200, 200)];
       [input setStringValue:@"Hello World"];
       [input autorelease];
       /* [input setAccessoryView:win]; */
       [view addSubview:input positioned:NSWindowAbove relativeTo:nil];

       input.drawsBackground = YES;
        input.wantsLayer = YES;

       [input display];
       /* [win setContentView:input]; */
};
#ifdef __cplusplus
}
#endif
