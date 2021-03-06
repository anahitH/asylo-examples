/*
 *  This file is auto generated by oeedger8r. DO NOT EDIT.
 */
#ifndef SGX_ARGS_H
#define SGX_ARGS_H

#include <stdint.h>
#include <stdlib.h> /* for wchar_t */ 

#include <openenclave/bits/result.h>

#include "snake.h"
#include "conio.h"

typedef struct _setup_level_protected_args_t {
    oe_result_t _result;
	screen_t* screen;
	snake_t* snake;
	int level;
 } setup_level_protected_args_t;

typedef struct _move_protected_args_t {
    oe_result_t _result;
	snake_t* snake;
	char* keys;
	char key;
 } move_protected_args_t;

typedef struct _collide_object_protected_args_t {
    oe_result_t _result;
	int _retval;
	snake_t* snake;
	screen_t* screen;
	char object;
 } collide_object_protected_args_t;

typedef struct _collision_protected_args_t {
    oe_result_t _result;
	int _retval;
	snake_t* snake;
	screen_t* screen;
 } collision_protected_args_t;

typedef struct _eat_gold_protected_args_t {
    oe_result_t _result;
	int _retval;
	snake_t* snake;
	screen_t* screen;
 } eat_gold_protected_args_t;

typedef struct _show_score_app_args_t {
    oe_result_t _result;
	screen_t* screen;
 } show_score_app_args_t;

typedef struct _draw_line_app_args_t {
    oe_result_t _result;
	int col;
	int row;
 } draw_line_app_args_t;

/* trusted function ids */
enum {
    fcn_id_setup_level_protected = 0,
    fcn_id_move_protected = 1,
    fcn_id_collide_object_protected = 2,
    fcn_id_collision_protected = 3,
    fcn_id_eat_gold_protected = 4,
    fcn_id_trusted_call_id_max = OE_ENUM_MAX
};


/* untrusted function ids */
enum {
    fcn_id_show_score_app = 0,
    fcn_id_draw_line_app = 1,
    fcn_id_untrusted_call_max = OE_ENUM_MAX
};


#endif // SGX_ARGS_H
