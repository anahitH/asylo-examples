/*
 *  This file is auto generated by oeedger8r. DO NOT EDIT.
 */
#ifndef EDGER8R_SGX_U_H
#define EDGER8R_SGX_U_H

#include <openenclave/host.h>
#include "sgx_args.h"

OE_EXTERNC_BEGIN

oe_result_t oe_create_sgx_enclave(const char* path,
                                 oe_enclave_type_t type,
                                 uint32_t flags,
                                 const void* config,
                                 uint32_t config_size,
                                 oe_enclave_t** enclave);

/* List of ecalls */

oe_result_t setup_level_protected(
        oe_enclave_t* enclave,
        screen_t* screen,
        snake_t* snake,
        int level);
oe_result_t move_protected(
        oe_enclave_t* enclave,
        snake_t* snake,
        char* keys,
        char key);
oe_result_t collide_object_protected(
        oe_enclave_t* enclave,
        int* _retval,
        snake_t* snake,
        screen_t* screen,
        char object);
oe_result_t collision_protected(
        oe_enclave_t* enclave,
        int* _retval,
        snake_t* snake,
        screen_t* screen);
oe_result_t eat_gold_protected(
        oe_enclave_t* enclave,
        int* _retval,
        snake_t* snake,
        screen_t* screen);

/* List of ocalls */

void show_score_app(screen_t* screen);
void draw_line_app(int col,
        int row);

OE_EXTERNC_END

#endif // EDGER8R_SGX_U_H
