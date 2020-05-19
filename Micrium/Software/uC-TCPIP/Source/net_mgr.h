/*
*********************************************************************************************************
*                                              uC/TCP-IP
*                                      The Embedded TCP/IP Suite
*
*                         (c) Copyright 2004-2019; Silicon Laboratories Inc.,
*                                400 W. Cesar Chavez, Austin, TX 78701
*
*                   All rights reserved. Protected by international copyright laws.
*
*                  Your use of this software is subject to your acceptance of the terms
*                  of a Silicon Labs Micrium software license, which can be obtained by
*                  contacting info@micrium.com. If you do not agree to the terms of this
*                  license, you may not use this software.
*
*                  Please help us continue to provide the Embedded community with the finest
*                  software available. Your honesty is greatly appreciated.
*
*                    You can find our product's documentation at: doc.micrium.com
*
*                          For more information visit us at: www.micrium.com
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                      NETWORK LAYER MANAGEMENT
*
* Filename : net_mgr.h
* Version  : V3.05.00
*********************************************************************************************************
* Note(s)  : (1) Network layer manager MAY eventually maintain each interface's network address(s)
*                & address configuration. #### NET-809
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*********************************************************************************************************
*                                            INCLUDE FILES
*********************************************************************************************************
*********************************************************************************************************
*/

#include  "net_cfg_net.h"
#include  "net_err.h"
#include  "../IF/net_if.h"

/*
*********************************************************************************************************
*********************************************************************************************************
*                                               MODULE
*********************************************************************************************************
*********************************************************************************************************
*/

#ifndef  NET_MGR_MODULE_PRESENT
#define  NET_MGR_MODULE_PRESENT

/*
*********************************************************************************************************
*********************************************************************************************************
*                                         FUNCTION PROTOTYPES
*********************************************************************************************************
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                     EXTERNAL C LANGUAGE LINKAGE
*
* Note(s) : (1) C++ compilers MUST 'extern'ally declare ALL C function prototypes & variable/object
*               declarations for correct C language linkage.
*********************************************************************************************************
*/

#ifdef  __cplusplus
extern "C" {
#endif

/*
*********************************************************************************************************
*                                         INTERNAL FUNCTIONS
*********************************************************************************************************
*/

void         NetMgr_Init                     (NET_ERR            *p_err);


                                                                                    /* ------ NET MGR ADDR FNCTS ------ */
void         NetMgr_GetHostAddrProtocol      (NET_IF_NBR          if_nbr,
                                              NET_PROTOCOL_TYPE   protocol_type,
                                              CPU_INT08U         *p_addr_protocol_tbl,
                                              CPU_INT08U         *p_addr_protocol_tbl_qty,
                                              CPU_INT08U         *p_addr_protocol_len,
                                              NET_ERR            *p_err);

NET_IF_NBR   NetMgr_GetHostAddrProtocolIF_Nbr(NET_PROTOCOL_TYPE   protocol_type,
                                              CPU_INT08U         *p_addr_protocol,
                                              CPU_INT08U          addr_protocol_len,
                                              NET_ERR            *p_err);


CPU_BOOLEAN  NetMgr_IsValidAddrProtocol      (NET_PROTOCOL_TYPE   protocol_type,
                                              CPU_INT08U         *p_addr_protocol,
                                              CPU_INT08U          addr_protocol_len);

CPU_BOOLEAN  NetMgr_IsAddrsCfgdOnIF          (NET_IF_NBR          if_nbr,
                                              NET_ERR            *p_err);

CPU_BOOLEAN  NetMgr_IsAddrProtocolInit       (NET_PROTOCOL_TYPE   protocol_type,
                                              CPU_INT08U         *p_addr_protocol,
                                              CPU_INT08U          addr_protocol_len);

#ifdef  NET_MCAST_MODULE_EN
CPU_BOOLEAN  NetMgr_IsAddrProtocolMulticast  (NET_PROTOCOL_TYPE   protocol_type,
                                              CPU_INT08U         *p_addr_protocol,
                                              CPU_INT08U          addr_protocol_len);
#endif

#ifdef  NET_IPv4_MODULE_EN
CPU_BOOLEAN  NetMgr_IsAddrProtocolConflict   (NET_IF_NBR          if_nbr);
#endif

void         NetMgr_ChkAddrProtocolConflict  (NET_IF_NBR          if_nbr,
                                              NET_PROTOCOL_TYPE   protocol_type,
                                              CPU_INT08U         *p_addr_protocol,
                                              CPU_INT08U          addr_protocol_len,
                                              NET_ERR            *p_err);


/*
*********************************************************************************************************
*                                   EXTERNAL C LANGUAGE LINKAGE END
*********************************************************************************************************
*/

#ifdef  __cplusplus
}
#endif

/*
*********************************************************************************************************
*********************************************************************************************************
*                                             MODULE END
*********************************************************************************************************
*********************************************************************************************************
*/

#endif  /* NET_MGR_MODULE_PRESENT */
