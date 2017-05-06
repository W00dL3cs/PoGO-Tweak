//
//  ByteArray.h
//  PoXemon
//
//  Created by Alexandro Luongo on 03/05/17.
//
//

#ifndef ByteArray_h
#define ByteArray_h

#include "Il2CppArray.h"

// System.Byte[]
struct ByteArray  : public Il2CppArray
{
public:
    ALIGN_FIELD (8) uint8_t m_Items[1];
    
public:
    inline uint8_t GetAt(il2cpp_array_size_t index) const
    {
        return m_Items[index];
    }
    inline uint8_t* GetAddressAt(il2cpp_array_size_t index)
    {
        return m_Items + index;
    }
    inline void SetAt(il2cpp_array_size_t index, uint8_t value)
    {
        m_Items[index] = value;
    }
    inline uint8_t GetAtUnchecked(il2cpp_array_size_t index) const
    {
        return m_Items[index];
    }
    inline uint8_t* GetAddressAtUnchecked(il2cpp_array_size_t index)
    {
        return m_Items + index;
    }
    inline void SetAtUnchecked(il2cpp_array_size_t index, uint8_t value)
    {
        m_Items[index] = value;
    }
};

#endif /* ByteArray_h */
