//
//  ByteStringArray.h
//  PoXemon
//
//  Created by Alexandro Luongo on 03/05/17.
//
//

#ifndef ByteStringArray_h
#define ByteStringArray_h

#include "Il2CppArray.h"
#include "ByteString.h"

struct ByteStringArray : public Il2CppArray
{
    ALIGN_FIELD (8) ByteString* m_Items[1];

    inline ByteString* GetAt(il2cpp_array_size_t index)
    {
        return m_Items[index];
    }
};

#endif /* ByteStringArray_h */
