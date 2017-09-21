//
//  XXDebugTool.h
//  XXDebugToolDemo
//
//  Created by Jason on 2017/9/20.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//



//1: open   0: close

#define XX_DEBUG_TOOL_ENABLED 0

#ifdef XX_DEBUG_TOOL_ENABLED
#define _INTERNAL_XX_ENABLED XX_DEBUG_TOOL_ENABLED
#else
#define _INTERNAL_XX_ENABLED DEBUG
#endif

#ifdef XX_DEBUG_TOOL_ENABLED
#define _INTERNAL_MLF_ENABLED XX_DEBUG_TOOL_ENABLED
#else
#define _INTERNAL_MLF_ENABLED DEBUG
#endif


#ifdef XX_DEBUG_TOOL_ENABLED
#define _INTERNAL_MLF_RC_ENABLED XX_DEBUG_TOOL_ENABLED
#elif COCOAPODS
#define _INTERNAL_MLF_RC_ENABLED COCOAPODS
#endif
