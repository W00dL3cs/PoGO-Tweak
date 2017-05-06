//
//  ByteString.h
//  PoXemon
//
//  Created by Alexandro Luongo on 03/05/17.
//
//

#ifndef ByteString_h
#define ByteString_h

#include "ByteArray.h"

struct ByteString : public Il2CppObject
{
    ByteArray* bytes;
};

#endif /* ByteString_h */
