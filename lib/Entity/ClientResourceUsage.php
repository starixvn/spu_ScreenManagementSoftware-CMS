<?php
/*
 * Xibo - Digital Signage - http://www.xibo.org.uk
 * Copyright (C) 2015 Spring Signage Ltd
 *
 * This file (Display.php) is part of Xibo.
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


namespace Xibo\Entity;


use Respect\Validation\Validator as v;
use Stash\Interfaces\PoolInterface;
use Xibo\Exception\DeadlockException;
use Xibo\Exception\InvalidArgumentException;
use Xibo\Exception\NotFoundException;
use Xibo\Factory\DisplayFactory;
use Xibo\Factory\DisplayGroupFactory;
use Xibo\Factory\DisplayProfileFactory;
use Xibo\Factory\LayoutFactory;
use Xibo\Factory\MediaFactory;
use Xibo\Factory\ScheduleFactory;
use Xibo\Service\ConfigServiceInterface;
use Xibo\Service\LogServiceInterface;
use Xibo\Storage\StorageServiceInterface;

/**
 * Class Display
 * @package Xibo\Entity
 *
 * @SWG\Definition()
 */
class ClientResourceUsage implements \JsonSerializable
{
    use EntityTrait;

    /**
     * @SWG\Property(description="The ID of this Display")
     * @var int
     */
    public $displayId;

    /**
     * @SWG\Property(description="The date and time that those values are logged")
     * @var int
     */
    public $logDate;

    /**
     * @SWG\Property(description="The percentage of CPU usage")
     * @var int
     */
    public $cpuUsage;

    /**
     * @SWG\Property(description="The total RAM amount")
     * @var int
     */
    public $ramTotal;

    /**
     * @SWG\Property(description="The amount of RAM available")
     * @var int
     */
    public $ramAvailable;

    /**
     * Entity constructor.
     * @param StorageServiceInterface $store
     * @param LogServiceInterface $log
     * @param ConfigServiceInterface $config
     * @param DisplayGroupFactory $displayGroupFactory
     * @param DisplayProfileFactory $displayProfileFactory
     * @param DisplayFactory $displayFactory
     */
    public function __construct($store, $log, $displayId, $cpuUsage, $ramTotal, $ramAvailable)
    {
        $this->setCommonDependencies($store, $log);
        $this->displayId = $displayId;
        $this->cpuUsage = $cpuUsage;
        $this->ramTotal = $ramTotal;
        $this->ramAvailable = $ramAvailable;
    }

    /**
     * Validate the Object as it stands
     */
    public function validate()
    {
        // temporary do nothing
    }

    public function add()
    {
        $this->getStore()->insert('
                INSERT INTO clientresourceusage (displayid, logdate, cpuusage, ramtotal, ramavailable)
                  VALUES (:displayid, UNIX_TIMESTAMP(NOW()), :cpuusage, :ramtotal, :ramavailable)
            ', [
                'displayid' => $this->displayId,
                'cpuusage' => $this->cpuUsage,
                'ramtotal' => $this->ramTotal,
                'ramavailable' => $this->ramAvailable,
            ]);
    }

    private function getByDisplayId($displayId)
    {
         $result = $this->getStore()->select('SELECT * FROM clientresourceusage WHERE displayid = :displayid', [
            'displayid' => $this->displayId
        ]);
        
        return $result;
    }
}
