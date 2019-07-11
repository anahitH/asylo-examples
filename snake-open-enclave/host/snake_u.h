/*
 *  This file is auto generated by oeedger8r. DO NOT EDIT.
 */
#ifndef EDGER8R_SNAKE_U_H
#define EDGER8R_SNAKE_U_H

#include <openenclave/host.h>
#include "snake_args.h"

OE_EXTERNC_BEGIN

oe_result_t oe_create_snake_enclave(const char* path,
                                 oe_enclave_type_t type,
                                 uint32_t flags,
                                 const void* config,
                                 uint32_t config_size,
                                 oe_enclave_t** enclave);

/* List of ecalls */

oe_result_t eat_gold(
        oe_enclave_t* enclave,
        int* _retval,
        snake_t* snake,
        screen_t* screen);

OE_EXTERNC_END

#endif // EDGER8R_SNAKE_U_H