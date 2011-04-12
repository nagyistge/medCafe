// <editor-fold defaultstate="collapsed">
/*
 * Copyright (C) 2009  Medsphere Systems Corporation
 * All rights reserved.
 *
 * This source code contains the intellectual property
 * of its copyright holder(s), and is made available
 * under a license. If you do not know the terms of
 * the license, please stop and do not read further.
 *
 * Please read LICENSES for detailed information about
 * the license this source code file is available under.
 * Questions should be directed to legal@medsphere.com
 *
 */
// </editor-fold>

package com.medsphere.cia;

class CIAConnectAction extends CIAAction {

    public CIAConnectAction(String address, String uci) {
        addParam("IP", address);
        addParam("UCI", uci);
        addParam("DBG", "0");
        addParam("LP", "0");
        addParam("VER", "1.6.5.26");
    }

    @Override
    byte getCommand() {
        return 'C';
    }

}