//
//  Header.h
//  Watch_Time
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define DCScreenW [UIScreen mainScreen].bounds.size.width
#define DCScreenH [UIScreen mainScreen].bounds.size.height


#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define autoSizeScaleX \
if([UIScreen mainScreen].bounds.size.height > 480){\
    \
    autoSizeScaleX = [UIScreen mainScreen].bounds.size.width/320;\
    \
}else{\
    \
    autoSizeScaleX = 1.0;\
}\


#define autoSizeScaleY \
if([UIScreen mainScreen].bounds.size.height > 480){\
\
    autoSizeScaleY = [UIScreen mainScreen].bounds.size.height/568;\
\
}else{\
    \
    autoSizeScaleY = 1.0;\
}\



#endif /* Header_h */
