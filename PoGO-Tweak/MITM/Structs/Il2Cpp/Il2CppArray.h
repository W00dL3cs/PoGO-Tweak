//
//  Il2CppArray.h
//  PoXemon
//
//  Created by Alexandro Luongo on 03/05/17.
//
//

#ifndef Il2CppArray_h
#define Il2CppArray_h

#include "Il2CppObject.h"

#define ALIGN_TYPE(val) __attribute__((aligned(val)))
#define ALIGN_FIELD(val) ALIGN_TYPE(val)

typedef int32_t il2cpp_array_size_t;

struct Il2CppArray : public Il2CppObject
{
    /* bounds is NULL for szarrays */
    void* bounds;
    
    /* total number of elements of the array */
    il2cpp_array_size_t max_length;
};

#endif /* Il2CppArray_h */
