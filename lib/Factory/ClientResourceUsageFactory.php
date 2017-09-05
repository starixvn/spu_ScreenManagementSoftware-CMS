<?php
/*
 * Xibo - Digital Signage - http://www.xibo.org.uk
 * Copyright (C) 2015 Spring Signage Ltd
 *
 * This file (DisplayFactory.php) is part of Xibo.
 *
 * Xibo is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * Xibo is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with Xibo.  If not, see <http://www.gnu.org/licenses/>.
 */


namespace Xibo\Factory;

use Xibo\Entity\ClientResourceUsage;
use Xibo\Entity\Display;
use Xibo\Entity\User;
use Xibo\Exception\NotFoundException;
use Xibo\Service\LogServiceInterface;
use Xibo\Service\SanitizerServiceInterface;
use Xibo\Storage\StorageServiceInterface;

/**
 * Class ClientResourceUsageFactory
 * @package Xibo\Factory
 */
class ClientResourceUsageFactory extends BaseFactory
{
    /**
     * Construct a factory
     * @param StorageServiceInterface $store
     * @param LogServiceInterface $log
     * @param SanitizerServiceInterface $sanitizerService
     */
    public function __construct($store, $log, $sanitizerService)
    {
        $this->setCommonDependencies($store, $log, $sanitizerService);
    }

    /**
     * Create Empty ClientResourceUsage Object
     * @return ClientResourceUsage
     */
    public function create($displayId, $cpuUsage, $ramTotal, $ramAvailable)
    {
        return new ClientResourceUsage($this->getStore(), $this->getLog(), $displayId, $cpuUsage, $ramTotal, $ramAvailable);
    }

    /**
     * @param string $displayIds
     * @return ClientResourceUsage[]
     */
    public function getByDisplayIds($displayIds)
    {
        $queryString = 'SELECT cru.displayId, cru.logdate , cru.cpuUsage, cru.ramAvailable, cru.ramTotal
            FROM `clientresourceusage` cru
                INNER JOIN (
                SELECT displayId, MAX(logdate) AS logdate
                FROM `clientresourceusage`
                GROUP BY displayId
            ) AS max USING (displayId, logdate)
            WHERE displayId IN ('.$displayIds.')';
        $result = $this->getStore()->select($queryString, []);
        
        return $result;
    }
}