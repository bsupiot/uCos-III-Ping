/*
 * Copyright (C) 2008-2012, Freescale Semiconductor, Inc. All Rights Reserved
 * THIS SOURCE CODE IS CONFIDENTIAL AND PROPRIETARY AND MAY NOT
 * BE USED OR DISTRIBUTED WITHOUT THE WRITTEN PERMISSION OF
 * Freescale Semiconductor, Inc.
*/

/*!
 * @file io.h
 * @brief       Basic defines
 *
 * @ingroup init
 */
#ifndef __IO_H__
#define __IO_H__

#ifndef NULL
#define NULL				0
#endif

typedef unsigned long long u64;
typedef unsigned int u32;
typedef unsigned short u16;
typedef unsigned char u8;

typedef signed long long s64;
typedef signed int s32;
typedef signed short s16;
typedef signed char s8;

typedef unsigned long long U64;
typedef unsigned int U32;
typedef unsigned short U16;
typedef unsigned char U8;

typedef unsigned short uint16_t;
typedef unsigned char uint8_t;

typedef int bool;
#define true                1
#define false               0

#define NONE_CHAR           0xFF

#define REG8_VAL(a)          ((unsigned char)(a))
#define REG16_VAL(a)         ((unsigned short)(a))
#define REG32_VAL(a)         ((unsigned int)(a))

#define REG8_PTR(a)          ((volatile unsigned char *)(a))
#define REG16_PTR(a)         ((volatile unsigned short *)(a))
#define REG32_PTR(a)         ((volatile unsigned int *)(a))

#define REG8(a)             (*(volatile unsigned char *)(a))
#define REG16(a)            (*(volatile unsigned short *)(a))
#define REG32(a)            (*(volatile unsigned int *)(a))
#define SET_REG8(v, a)      (*(volatile unsigned char *)(a) = (v))
#define SET_REG16(v, a)     (*(volatile unsigned short *)(a) = (v))
#define SET_REG32(v, a)     (*(volatile unsigned int *)(a) = (v))
#define readb(a)            REG8(a)
#define readw(a)            REG16(a)
#define readl(a)            REG32(a)
#define writeb(v, a)        SET_REG8(v, a)
#define writew(v, a)        SET_REG16(v, a)
#define writel(v, a)        SET_REG32(v, a)

/*
 * This macro is used to get certain bit field from a number
 */
#define MXC_GET_FIELD(val, len, sh)          ((val >> sh) & ((1 << len) - 1))

//TODO:
#define MOD_REG8()
#define MOD_REG16()
#define MOD_REG32()

/*
 * This macro is used to get certain bit field from a number
 */
#define GET_FIELD(val, len, sh)          ((val >> sh) & ((1 << len) - 1))

/*
 * This macro is used to set certain bit field inside a number
 */
#define SET_FIELD(val, len, sh, nval)    ((val & ~(((1 << len) - 1) << sh)) | (nval << sh))

#endif // __IO_H__
