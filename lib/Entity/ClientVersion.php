<?php

namespace Xibo\Entity;

use Respect\Validation\Validator as v;
use Xibo\Exception\InvalidArgumentException;
use Xibo\Service\LogServiceInterface;
use Xibo\Storage\StorageServiceInterface;

/**
 * Class ClientVersion
 * @package Xibo\Entity
 *
 * @SWG\Definition()
 */
class ClientVersion implements \JsonSerializable
{
    use EntityTrait;

    /**
     * @SWG\Property(description="The ID of this Version")
     * @var int
     */
    public $versionId;

    /**
     * @SWG\Property(description="Detailed Info of Version")
     * @var int
     */
    public $version;

    /**
     * @SWG\Property(description="The File Name to install the Version")
     * @var string
     */
    public $fileName;
    
    /**
     * @SWG\Property(description="The Version Description")
     * @var string
     */
    public $description;

    /**
     * @SWG\Property(description="The Upload Date")
     * @var string
     */
    public $uploadDate;

    /**
     * @SWG\Property(description="The User who had uploaded")
     * @var int
     */
    public $uploadOwner;

    /**
     * @SWG\Property(description="The Name of the User who had uploaded")
     * @var string
     */
    public $uploadOwnerName;

    /**
     * @SWG\Property(description="Last modification date")
     * @var int
     */
    public $lastUpdateDate;

    /**
     * @SWG\Property(description="The one who had taken the last modification")
     * @var int
     */
    public $lastUpdateOwner;

    /**
     * @SWG\Property(description="The name of the one who had taken the last modification")
     * @var int
     */
    public $lastUpdateName;

    /**
     * @SWG\Property(description="Is this version retired?")
     * @var int
     */
    public $retired;

    /**
     * Entity constructor.
     * @param StorageServiceInterface $store
     * @param LogServiceInterface $log
     */
    public function __construct($store, $log)
    {
        $this->setCommonDependencies($store, $log);

        // Initialise extra validation rules
        v::with('Xibo\\Validation\\Rules\\');
    }

    /**
     * Validate the Object as it stands
     */
    public function validate()
    {
        if (!v::string()->notEmpty()->validate($this->version))
            throw new InvalidArgumentException(__('Can not have a empty version'), 'name');

        if (strlen((string)$this->version) > 15) {            
            throw new InvalidArgumentException(sprintf(__('You have exceeded your maximum %d characters of version.'), 15), 'version');
        }
        
        if (strlen((string)$this->description) > 2000) {            
            throw new InvalidArgumentException(sprintf(__('You have exceeded your maximum %d characters of version.'), 2000), 'description');
        }
    }

    /**
     * Delete by Id
     * @throws \Xibo\Exception\NotFoundException
     */
    public function delete()
    {
        $this->getStore()->update('DELETE FROM `clientversion` WHERE versionId = :versionId', ['versionId' => $this->versionId]);
        $this->getLog()->audit('Version', $this->versionId, 'Version Deleted By Id', ['versionId' => $this->versionId]);
    }
    
    public function deleteByVersion()
    {
        $this->getStore()->update('DELETE FROM `clientversion` WHERE version = :version', ['version' => $this->version]);
        $this->getLog()->audit('Version', $this->version, 'Version Deleted', ['version' => $this->version]);
    }

    public function add($version, $fileName, $description, $creator)
    {
        $this->version = $version;
        $this->fileName = $fileName;
        $this->description = $description;
        $this->uploadOwner = $creator;
        $this->lastUpdateOwner = $creator;
        
        $this->versionId = $this->getStore()->insert('
            INSERT INTO clientversion (version, fileName, description, uploadDate, uploadOwner, lastUpdateDate, lastUpdateOwner)
              VALUES (:version, :fileName, :description, UNIX_TIMESTAMP(NOW()), :uploadOwner, UNIX_TIMESTAMP(NOW()), :lastUpdateOwner)
        ', [
            'version' => $this->version,
            'fileName' => $this->fileName,
            'description' => $this->description,
            'uploadOwner' => $this->uploadOwner,
            'lastUpdateOwner' => $this->lastUpdateOwner
        ]);
    }

    public function edit()
    {                
        if (strlen((string)$description) > 2000) {            
            throw new InvalidArgumentException(sprintf(__('You have exceeded your maximum %d characters of version.'), 2000), 'description');
        }
        
        $this->getStore()->update('
            UPDATE clientversion
                SET description = :description,
                    lastUpdateDate = UNIX_TIMESTAMP(NOW()),
                    lastUpdateOwner = :lastUpdateOwner,
                    retired = :retired
            WHERE versionId = :versionId
        ', [
            'description' => $this->description,
            'lastUpdateOwner' => $this->lastUpdateOwner,
            'retired' => $this->retired,
            'versionId' => $this->versionId
        ]);
        
        $this->getLog()->audit('Version', $this->versionId, 'Update Version Info.', ['versionId' => $this->versionId]);
    }
}