/*
 * Copyright (C) 2007-2009  Medsphere Systems Corporation
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

package com.medsphere.ovid.model;

import com.medsphere.common.cache.GenericCache;
import com.medsphere.common.cache.GenericCacheReaper;
import com.medsphere.fmdomain.FMDisplayGroup;
import java.util.concurrent.Callable;
import org.apache.log4j.Logger;

/**
 * 
 */
public class DisplayGroupCache extends GenericCache<String, FMDisplayGroup> {
    private static DisplayGroupCache instance = null;
    private static Logger logger = Logger.getLogger(OrderDialogCache.class);    
    
    protected DisplayGroupCache(Long shelfLife) {
        super();
        this.setShelfLifeInMilliseconds(shelfLife);
        logger.debug("instantiated DisplayGroupCache with shelf life of " + shelfLife);
    }

    public static DisplayGroupCache getInstance() {
        if (instance == null) {
            instance = new DisplayGroupCache();
            GenericCacheReaper.getInstance().addCache(instance);
        }
        return instance;
    }

    public static DisplayGroupCache getInstance(Long shelfLife) {
        if (instance == null) {
            instance = new DisplayGroupCache(shelfLife);
        } else {
            logger.debug("changing shelfLife from " + instance.getShelfLifeInMilliseconds() + " to " + shelfLife);
            instance.setShelfLifeInMilliseconds(shelfLife);
        }
        return instance;

    }

    protected DisplayGroupCache() {
        super();
        long shelfLife = (4 * 60 * 60 * 1000);
        setShelfLifeInMilliseconds(shelfLife);
    }

    
    @Override
    protected Callable<?> getCacheLoader() {
        Callable<?> cacheLoader = new Callable<Object>() {

            public Boolean call() {
                return Boolean.TRUE;
            }
        };
        return cacheLoader;
    }


}
