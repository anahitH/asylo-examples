/*
 *  This file is auto generated by oeedger8r. DO NOT EDIT.
 */
#include "sgx_u.h"
#include <openenclave/edger8r/host.h>
#include <stdlib.h>
#include <string.h>
#include <wchar.h>

OE_EXTERNC_BEGIN

/* Wrappers for ecalls */

oe_result_t setup_level_protected(
        oe_enclave_t* enclave,
        screen_t* screen,
        snake_t* snake,
        int level)
{
    oe_result_t _result = OE_FAILURE;

    /* Marshalling struct */ 
    setup_level_protected_args_t _args, *_pargs_in = NULL, *_pargs_out=NULL;

    /* Marshalling buffer and sizes */ 
    size_t _input_buffer_size = 0;
    size_t _output_buffer_size = 0;
    size_t _total_buffer_size = 0;
    uint8_t* _buffer = NULL;
    uint8_t* _input_buffer = NULL;
    uint8_t* _output_buffer = NULL;
    size_t _input_buffer_offset = 0;
    size_t _output_buffer_offset = 0;
    size_t _output_bytes_written = 0;

    /* Fill marshalling struct */
    memset(&_args, 0, sizeof(_args));
    _args.screen = (screen_t*) screen;
    _args.snake = (snake_t*) snake;
    _args.level = level;

    /* Compute input buffer size. Include in and in-out parameters. */
    OE_ADD_SIZE(_input_buffer_size, sizeof(setup_level_protected_args_t));
    if (screen) OE_ADD_SIZE(_input_buffer_size, sizeof(screen_t));
    if (snake) OE_ADD_SIZE(_input_buffer_size, sizeof(snake_t));

    /* Compute output buffer size. Include out and in-out parameters. */
    OE_ADD_SIZE(_output_buffer_size, sizeof(setup_level_protected_args_t));
    if (screen) OE_ADD_SIZE(_output_buffer_size, sizeof(screen_t));
    if (snake) OE_ADD_SIZE(_output_buffer_size, sizeof(snake_t));

    /* Allocate marshalling buffer */
    _total_buffer_size = _input_buffer_size;
    OE_ADD_SIZE(_total_buffer_size, _output_buffer_size);

    _buffer = (uint8_t*) malloc(_total_buffer_size);
    _input_buffer = _buffer;
    _output_buffer = _buffer + _input_buffer_size;
    if (_buffer == NULL) { 
        _result = OE_OUT_OF_MEMORY;
        goto done;
    }

    /* Serialize buffer inputs (in and in-out parameters) */
    *(uint8_t**)&_pargs_in = _input_buffer; 
    OE_ADD_SIZE(_input_buffer_offset, sizeof(*_pargs_in));

    OE_WRITE_IN_OUT_PARAM(screen, sizeof(screen_t));
    OE_WRITE_IN_OUT_PARAM(snake, sizeof(snake_t));

    /* Copy args structure (now filled) to input buffer */
    memcpy(_pargs_in, &_args, sizeof(*_pargs_in));

    /* Call enclave function */
    if((_result = oe_call_enclave_function(
                        enclave,
                        fcn_id_setup_level_protected,
                        _input_buffer, _input_buffer_size,
                        _output_buffer, _output_buffer_size,
                         &_output_bytes_written)) != OE_OK)
        goto done;

    /* Set up output arg struct pointer */
    *(uint8_t**)&_pargs_out = _output_buffer; 
    OE_ADD_SIZE(_output_buffer_offset, sizeof(*_pargs_out));

    /* Check if the call succeeded */
    if ((_result=_pargs_out->_result) != OE_OK)
        goto done;

    /* Currently exactly _output_buffer_size bytes must be written */
    if (_output_bytes_written != _output_buffer_size) {
        _result = OE_FAILURE;
        goto done;
    }

    /* Unmarshal return value and out, in-out parameters */
    OE_READ_IN_OUT_PARAM(screen, (size_t)(sizeof(screen_t)));
    OE_READ_IN_OUT_PARAM(snake, (size_t)(sizeof(snake_t)));

    _result = OE_OK;
done:    
    if (_buffer)
        free(_buffer);
    return _result;
}



oe_result_t move_protected(
        oe_enclave_t* enclave,
        snake_t* snake,
        char* keys,
        char key)
{
    oe_result_t _result = OE_FAILURE;

    /* Marshalling struct */ 
    move_protected_args_t _args, *_pargs_in = NULL, *_pargs_out=NULL;

    /* Marshalling buffer and sizes */ 
    size_t _input_buffer_size = 0;
    size_t _output_buffer_size = 0;
    size_t _total_buffer_size = 0;
    uint8_t* _buffer = NULL;
    uint8_t* _input_buffer = NULL;
    uint8_t* _output_buffer = NULL;
    size_t _input_buffer_offset = 0;
    size_t _output_buffer_offset = 0;
    size_t _output_bytes_written = 0;

    /* Fill marshalling struct */
    memset(&_args, 0, sizeof(_args));
    _args.snake = (snake_t*) snake;
    _args.keys = (char*) keys;
    _args.key = key;

    /* Compute input buffer size. Include in and in-out parameters. */
    OE_ADD_SIZE(_input_buffer_size, sizeof(move_protected_args_t));
    if (snake) OE_ADD_SIZE(_input_buffer_size, sizeof(snake_t));
    if (keys) OE_ADD_SIZE(_input_buffer_size, sizeof(char));

    /* Compute output buffer size. Include out and in-out parameters. */
    OE_ADD_SIZE(_output_buffer_size, sizeof(move_protected_args_t));
    if (snake) OE_ADD_SIZE(_output_buffer_size, sizeof(snake_t));
    if (keys) OE_ADD_SIZE(_output_buffer_size, sizeof(char));

    /* Allocate marshalling buffer */
    _total_buffer_size = _input_buffer_size;
    OE_ADD_SIZE(_total_buffer_size, _output_buffer_size);

    _buffer = (uint8_t*) malloc(_total_buffer_size);
    _input_buffer = _buffer;
    _output_buffer = _buffer + _input_buffer_size;
    if (_buffer == NULL) { 
        _result = OE_OUT_OF_MEMORY;
        goto done;
    }

    /* Serialize buffer inputs (in and in-out parameters) */
    *(uint8_t**)&_pargs_in = _input_buffer; 
    OE_ADD_SIZE(_input_buffer_offset, sizeof(*_pargs_in));

    OE_WRITE_IN_OUT_PARAM(snake, sizeof(snake_t));
    OE_WRITE_IN_OUT_PARAM(keys, sizeof(char));

    /* Copy args structure (now filled) to input buffer */
    memcpy(_pargs_in, &_args, sizeof(*_pargs_in));

    /* Call enclave function */
    if((_result = oe_call_enclave_function(
                        enclave,
                        fcn_id_move_protected,
                        _input_buffer, _input_buffer_size,
                        _output_buffer, _output_buffer_size,
                         &_output_bytes_written)) != OE_OK)
        goto done;

    /* Set up output arg struct pointer */
    *(uint8_t**)&_pargs_out = _output_buffer; 
    OE_ADD_SIZE(_output_buffer_offset, sizeof(*_pargs_out));

    /* Check if the call succeeded */
    if ((_result=_pargs_out->_result) != OE_OK)
        goto done;

    /* Currently exactly _output_buffer_size bytes must be written */
    if (_output_bytes_written != _output_buffer_size) {
        _result = OE_FAILURE;
        goto done;
    }

    /* Unmarshal return value and out, in-out parameters */
    OE_READ_IN_OUT_PARAM(snake, (size_t)(sizeof(snake_t)));
    OE_READ_IN_OUT_PARAM(keys, (size_t)(sizeof(char)));

    _result = OE_OK;
done:    
    if (_buffer)
        free(_buffer);
    return _result;
}



oe_result_t collide_object_protected(
        oe_enclave_t* enclave,
        int* _retval,
        snake_t* snake,
        screen_t* screen,
        char object)
{
    oe_result_t _result = OE_FAILURE;

    /* Marshalling struct */ 
    collide_object_protected_args_t _args, *_pargs_in = NULL, *_pargs_out=NULL;

    /* Marshalling buffer and sizes */ 
    size_t _input_buffer_size = 0;
    size_t _output_buffer_size = 0;
    size_t _total_buffer_size = 0;
    uint8_t* _buffer = NULL;
    uint8_t* _input_buffer = NULL;
    uint8_t* _output_buffer = NULL;
    size_t _input_buffer_offset = 0;
    size_t _output_buffer_offset = 0;
    size_t _output_bytes_written = 0;

    /* Fill marshalling struct */
    memset(&_args, 0, sizeof(_args));
    _args.snake = (snake_t*) snake;
    _args.screen = (screen_t*) screen;
    _args.object = object;

    /* Compute input buffer size. Include in and in-out parameters. */
    OE_ADD_SIZE(_input_buffer_size, sizeof(collide_object_protected_args_t));
    if (snake) OE_ADD_SIZE(_input_buffer_size, sizeof(snake_t));
    if (screen) OE_ADD_SIZE(_input_buffer_size, sizeof(screen_t));

    /* Compute output buffer size. Include out and in-out parameters. */
    OE_ADD_SIZE(_output_buffer_size, sizeof(collide_object_protected_args_t));
    if (snake) OE_ADD_SIZE(_output_buffer_size, sizeof(snake_t));
    if (screen) OE_ADD_SIZE(_output_buffer_size, sizeof(screen_t));

    /* Allocate marshalling buffer */
    _total_buffer_size = _input_buffer_size;
    OE_ADD_SIZE(_total_buffer_size, _output_buffer_size);

    _buffer = (uint8_t*) malloc(_total_buffer_size);
    _input_buffer = _buffer;
    _output_buffer = _buffer + _input_buffer_size;
    if (_buffer == NULL) { 
        _result = OE_OUT_OF_MEMORY;
        goto done;
    }

    /* Serialize buffer inputs (in and in-out parameters) */
    *(uint8_t**)&_pargs_in = _input_buffer; 
    OE_ADD_SIZE(_input_buffer_offset, sizeof(*_pargs_in));

    OE_WRITE_IN_OUT_PARAM(snake, sizeof(snake_t));
    OE_WRITE_IN_OUT_PARAM(screen, sizeof(screen_t));

    /* Copy args structure (now filled) to input buffer */
    memcpy(_pargs_in, &_args, sizeof(*_pargs_in));

    /* Call enclave function */
    if((_result = oe_call_enclave_function(
                        enclave,
                        fcn_id_collide_object_protected,
                        _input_buffer, _input_buffer_size,
                        _output_buffer, _output_buffer_size,
                         &_output_bytes_written)) != OE_OK)
        goto done;

    /* Set up output arg struct pointer */
    *(uint8_t**)&_pargs_out = _output_buffer; 
    OE_ADD_SIZE(_output_buffer_offset, sizeof(*_pargs_out));

    /* Check if the call succeeded */
    if ((_result=_pargs_out->_result) != OE_OK)
        goto done;

    /* Currently exactly _output_buffer_size bytes must be written */
    if (_output_bytes_written != _output_buffer_size) {
        _result = OE_FAILURE;
        goto done;
    }

    /* Unmarshal return value and out, in-out parameters */
    *_retval = _pargs_out->_retval;
    OE_READ_IN_OUT_PARAM(snake, (size_t)(sizeof(snake_t)));
    OE_READ_IN_OUT_PARAM(screen, (size_t)(sizeof(screen_t)));

    _result = OE_OK;
done:    
    if (_buffer)
        free(_buffer);
    return _result;
}



oe_result_t collision_protected(
        oe_enclave_t* enclave,
        int* _retval,
        snake_t* snake,
        screen_t* screen)
{
    oe_result_t _result = OE_FAILURE;

    /* Marshalling struct */ 
    collision_protected_args_t _args, *_pargs_in = NULL, *_pargs_out=NULL;

    /* Marshalling buffer and sizes */ 
    size_t _input_buffer_size = 0;
    size_t _output_buffer_size = 0;
    size_t _total_buffer_size = 0;
    uint8_t* _buffer = NULL;
    uint8_t* _input_buffer = NULL;
    uint8_t* _output_buffer = NULL;
    size_t _input_buffer_offset = 0;
    size_t _output_buffer_offset = 0;
    size_t _output_bytes_written = 0;

    /* Fill marshalling struct */
    memset(&_args, 0, sizeof(_args));
    _args.snake = (snake_t*) snake;
    _args.screen = (screen_t*) screen;

    /* Compute input buffer size. Include in and in-out parameters. */
    OE_ADD_SIZE(_input_buffer_size, sizeof(collision_protected_args_t));
    if (snake) OE_ADD_SIZE(_input_buffer_size, sizeof(snake_t));
    if (screen) OE_ADD_SIZE(_input_buffer_size, sizeof(screen_t));

    /* Compute output buffer size. Include out and in-out parameters. */
    OE_ADD_SIZE(_output_buffer_size, sizeof(collision_protected_args_t));
    if (snake) OE_ADD_SIZE(_output_buffer_size, sizeof(snake_t));
    if (screen) OE_ADD_SIZE(_output_buffer_size, sizeof(screen_t));

    /* Allocate marshalling buffer */
    _total_buffer_size = _input_buffer_size;
    OE_ADD_SIZE(_total_buffer_size, _output_buffer_size);

    _buffer = (uint8_t*) malloc(_total_buffer_size);
    _input_buffer = _buffer;
    _output_buffer = _buffer + _input_buffer_size;
    if (_buffer == NULL) { 
        _result = OE_OUT_OF_MEMORY;
        goto done;
    }

    /* Serialize buffer inputs (in and in-out parameters) */
    *(uint8_t**)&_pargs_in = _input_buffer; 
    OE_ADD_SIZE(_input_buffer_offset, sizeof(*_pargs_in));

    OE_WRITE_IN_OUT_PARAM(snake, sizeof(snake_t));
    OE_WRITE_IN_OUT_PARAM(screen, sizeof(screen_t));

    /* Copy args structure (now filled) to input buffer */
    memcpy(_pargs_in, &_args, sizeof(*_pargs_in));

    /* Call enclave function */
    if((_result = oe_call_enclave_function(
                        enclave,
                        fcn_id_collision_protected,
                        _input_buffer, _input_buffer_size,
                        _output_buffer, _output_buffer_size,
                         &_output_bytes_written)) != OE_OK)
        goto done;

    /* Set up output arg struct pointer */
    *(uint8_t**)&_pargs_out = _output_buffer; 
    OE_ADD_SIZE(_output_buffer_offset, sizeof(*_pargs_out));

    /* Check if the call succeeded */
    if ((_result=_pargs_out->_result) != OE_OK)
        goto done;

    /* Currently exactly _output_buffer_size bytes must be written */
    if (_output_bytes_written != _output_buffer_size) {
        _result = OE_FAILURE;
        goto done;
    }

    /* Unmarshal return value and out, in-out parameters */
    *_retval = _pargs_out->_retval;
    OE_READ_IN_OUT_PARAM(snake, (size_t)(sizeof(snake_t)));
    OE_READ_IN_OUT_PARAM(screen, (size_t)(sizeof(screen_t)));

    _result = OE_OK;
done:    
    if (_buffer)
        free(_buffer);
    return _result;
}



oe_result_t eat_gold_protected(
        oe_enclave_t* enclave,
        int* _retval,
        snake_t* snake,
        screen_t* screen)
{
    oe_result_t _result = OE_FAILURE;

    /* Marshalling struct */ 
    eat_gold_protected_args_t _args, *_pargs_in = NULL, *_pargs_out=NULL;

    /* Marshalling buffer and sizes */ 
    size_t _input_buffer_size = 0;
    size_t _output_buffer_size = 0;
    size_t _total_buffer_size = 0;
    uint8_t* _buffer = NULL;
    uint8_t* _input_buffer = NULL;
    uint8_t* _output_buffer = NULL;
    size_t _input_buffer_offset = 0;
    size_t _output_buffer_offset = 0;
    size_t _output_bytes_written = 0;

    /* Fill marshalling struct */
    memset(&_args, 0, sizeof(_args));
    _args.snake = (snake_t*) snake;
    _args.screen = (screen_t*) screen;

    /* Compute input buffer size. Include in and in-out parameters. */
    OE_ADD_SIZE(_input_buffer_size, sizeof(eat_gold_protected_args_t));
    if (snake) OE_ADD_SIZE(_input_buffer_size, sizeof(snake_t));
    if (screen) OE_ADD_SIZE(_input_buffer_size, sizeof(screen_t));

    /* Compute output buffer size. Include out and in-out parameters. */
    OE_ADD_SIZE(_output_buffer_size, sizeof(eat_gold_protected_args_t));
    if (snake) OE_ADD_SIZE(_output_buffer_size, sizeof(snake_t));
    if (screen) OE_ADD_SIZE(_output_buffer_size, sizeof(screen_t));

    /* Allocate marshalling buffer */
    _total_buffer_size = _input_buffer_size;
    OE_ADD_SIZE(_total_buffer_size, _output_buffer_size);

    _buffer = (uint8_t*) malloc(_total_buffer_size);
    _input_buffer = _buffer;
    _output_buffer = _buffer + _input_buffer_size;
    if (_buffer == NULL) { 
        _result = OE_OUT_OF_MEMORY;
        goto done;
    }

    /* Serialize buffer inputs (in and in-out parameters) */
    *(uint8_t**)&_pargs_in = _input_buffer; 
    OE_ADD_SIZE(_input_buffer_offset, sizeof(*_pargs_in));

    OE_WRITE_IN_OUT_PARAM(snake, sizeof(snake_t));
    OE_WRITE_IN_OUT_PARAM(screen, sizeof(screen_t));

    /* Copy args structure (now filled) to input buffer */
    memcpy(_pargs_in, &_args, sizeof(*_pargs_in));

    /* Call enclave function */
    if((_result = oe_call_enclave_function(
                        enclave,
                        fcn_id_eat_gold_protected,
                        _input_buffer, _input_buffer_size,
                        _output_buffer, _output_buffer_size,
                         &_output_bytes_written)) != OE_OK)
        goto done;

    /* Set up output arg struct pointer */
    *(uint8_t**)&_pargs_out = _output_buffer; 
    OE_ADD_SIZE(_output_buffer_offset, sizeof(*_pargs_out));

    /* Check if the call succeeded */
    if ((_result=_pargs_out->_result) != OE_OK)
        goto done;

    /* Currently exactly _output_buffer_size bytes must be written */
    if (_output_bytes_written != _output_buffer_size) {
        _result = OE_FAILURE;
        goto done;
    }

    /* Unmarshal return value and out, in-out parameters */
    *_retval = _pargs_out->_retval;
    OE_READ_IN_OUT_PARAM(snake, (size_t)(sizeof(snake_t)));
    OE_READ_IN_OUT_PARAM(screen, (size_t)(sizeof(screen_t)));

    _result = OE_OK;
done:    
    if (_buffer)
        free(_buffer);
    return _result;
}




/* ocall functions */

void ocall_show_score_app(
        uint8_t* input_buffer, size_t input_buffer_size,
        uint8_t* output_buffer, size_t output_buffer_size,
        size_t* output_bytes_written)
{
    oe_result_t _result = OE_FAILURE;
    OE_UNUSED(input_buffer_size);

    /* Prepare parameters */
    show_score_app_args_t* pargs_in = (show_score_app_args_t*) input_buffer;
    show_score_app_args_t* pargs_out = (show_score_app_args_t*) output_buffer;

    size_t input_buffer_offset = 0;
    size_t output_buffer_offset = 0;
    OE_ADD_SIZE(input_buffer_offset, sizeof(*pargs_in));
    OE_ADD_SIZE(output_buffer_offset, sizeof(*pargs_out));

    /* Make sure input and output buffers are valid */
    if (!input_buffer || !output_buffer) {
        _result = OE_INVALID_PARAMETER;
        goto done;

    }
    /* Set in and in-out pointers */
    OE_SET_IN_OUT_POINTER(screen, sizeof(screen_t));

    /* Set out and in-out pointers. In-out parameters are copied to output buffer. */
    OE_COPY_AND_SET_IN_OUT_POINTER(screen, sizeof(screen_t));

    /* Call user function */
    show_score_app(
        pargs_in->screen);

    /* Success. */
    _result = OE_OK; 
    *output_bytes_written = output_buffer_offset;

done:
    if (pargs_out && output_buffer_size >= sizeof(*pargs_out)) 
        pargs_out->_result = _result;
}

void ocall_draw_line_app(
        uint8_t* input_buffer, size_t input_buffer_size,
        uint8_t* output_buffer, size_t output_buffer_size,
        size_t* output_bytes_written)
{
    oe_result_t _result = OE_FAILURE;
    OE_UNUSED(input_buffer_size);

    /* Prepare parameters */
    draw_line_app_args_t* pargs_in = (draw_line_app_args_t*) input_buffer;
    draw_line_app_args_t* pargs_out = (draw_line_app_args_t*) output_buffer;

    size_t input_buffer_offset = 0;
    size_t output_buffer_offset = 0;
    OE_ADD_SIZE(input_buffer_offset, sizeof(*pargs_in));
    OE_ADD_SIZE(output_buffer_offset, sizeof(*pargs_out));

    /* Make sure input and output buffers are valid */
    if (!input_buffer || !output_buffer) {
        _result = OE_INVALID_PARAMETER;
        goto done;

    }
    /* Set in and in-out pointers */

    /* Set out and in-out pointers. In-out parameters are copied to output buffer. */

    /* Call user function */
    draw_line_app(
        pargs_in->col,
        pargs_in->row);

    /* Success. */
    _result = OE_OK; 
    *output_bytes_written = output_buffer_offset;

done:
    if (pargs_out && output_buffer_size >= sizeof(*pargs_out)) 
        pargs_out->_result = _result;
}


/*ocall function table*/
static oe_ocall_func_t __sgx_ocall_function_table[]= {
    (oe_ocall_func_t) ocall_show_score_app,
    (oe_ocall_func_t) ocall_draw_line_app,
    NULL
};

oe_result_t oe_create_sgx_enclave(const char* path,
                                 oe_enclave_type_t type,
                                 uint32_t flags,
                                 const void* config,
                                 uint32_t config_size,
                                 oe_enclave_t** enclave)
{
    return oe_create_enclave(path,
               type,
               flags,
               config,
               config_size,
               __sgx_ocall_function_table,
               2,
               enclave);
}

OE_EXTERNC_END