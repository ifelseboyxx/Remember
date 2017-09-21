//
//  UIViewController+PresentInWindow.h
//  TCTravel_IPhone
//
//  Created by Yimin Huang on 15/5/25.
//
//

#import <UIKit/UIKit.h>
#import "XXDebugTool.h"

#if _INTERNAL_XX_ENABLED

@interface UIViewController (PresentInWindow)

- (void)xx_presentInWindow;

- (void)xx_dismissWithAnimation:(BOOL)animation;

@end

#endif
