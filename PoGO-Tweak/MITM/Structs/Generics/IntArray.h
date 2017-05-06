//
//  IntArray.h
//  PoXemon
//
//  Created by Alexandro Luongo on 03/05/17.
//
//

#ifndef IntArray_h
#define IntArray_h

#include "Il2CppArray.h"

// System.Int[]
struct IntArray  : public Il2CppArray
{
public:
    ALIGN_FIELD (8) int32_t m_Items[1];
    
public:
    inline int32_t GetAt(il2cpp_array_size_t index) const
    {
        return m_Items[index];
    }
    inline int32_t* GetAddressAt(il2cpp_array_size_t index)
    {
        return m_Items + index;
    }
    inline void SetAt(il2cpp_array_size_t index, int32_t value)
    {
        m_Items[index] = value;
    }
    inline int32_t GetAtUnchecked(il2cpp_array_size_t index) const
    {
        return m_Items[index];
    }
    inline int32_t* GetAddressAtUnchecked(il2cpp_array_size_t index)
    {
        return m_Items + index;
    }
    inline void SetAtUnchecked(il2cpp_array_size_t index, int32_t value)
    {
        m_Items[index] = value;
    }
};

#endif /* IntArray_h */
