<?php

namespace Xibo\Controller;

use Stash\Interfaces\PoolInterface;

use Xibo\Exception\AccessDeniedException;
use Xibo\Exception\ConfigurationException;
use Xibo\Factory\ClientVersionFactory;
use Xibo\Factory\PermissionFactory;
use Xibo\Factory\UserFactory;
use Xibo\Helper\UpgradeUploadHandler;
use Xibo\Service\ConfigServiceInterface;
use Xibo\Service\DateServiceInterface;
use Xibo\Service\LogServiceInterface;
use Xibo\Service\SanitizerServiceInterface;
use Xibo\Storage\StorageServiceInterface;

/**
 * Class Library
 * @package Xibo\Controller
 */
class ClientVersion extends Base
{
    /**
     * @var StorageServiceInterface
     */
    private $store;

    /** @var  PoolInterface */
    private $pool;

    /**
     * @var UserFactory
     */
    private $userFactory;

    /**
     * @var ClientVersionFactory
     */
    private $clientVersionFactory;

    /**
     * @var PermissionFactory
     */
    private $permissionFactory;

    /**
     * Set common dependencies.
     * @param LogServiceInterface $log
     * @param SanitizerServiceInterface $sanitizerService
     * @param \Xibo\Helper\ApplicationState $state
     * @param \Xibo\Entity\User $user
     * @param \Xibo\Service\HelpServiceInterface $help
     * @param DateServiceInterface $date
     * @param ConfigServiceInterface $config
     * @param StorageServiceInterface $store
     * @param PoolInterface $pool
     * @param UserFactory $userFactory
     * @param PermissionFactory $permissionFactory
     */
    public function __construct($log, $sanitizerService, $state, $user, $help, $date, $config, $store, $pool, $userFactory, $clientVersionFactory, $permissionFactory)
    {
        $this->setCommonDependencies($log, $sanitizerService, $state, $user, $help, $date, $config);

        $this->store = $store;
        $this->clientVersionFactory = $clientVersionFactory;
        $this->pool = $pool;
        $this->userFactory = $userFactory;
        $this->permissionFactory = $permissionFactory;
    }

    /**
     * Get Module Factory
     * @return ClientVersionFactory
     */
    
    public function getClientVersionFactory()
    {
        return $this->clientVersionFactory;
    }

    /**
     * Get Permission Factory
     * @return PermissionFactory
     */
    public function getPermissionFactory()
    {
        return $this->permissionFactory;
    }

    /**
     * Displays the page logic
     */
    function displayPage()
    {
        $this->getState()->template = 'client-version-page';
    }

    function grid()
    {
        $user = $this->getUser();

        // Construct the SQL
        $versions = $this->clientVersionFactory->query($this->gridRenderSort(), $this->gridRenderFilter([
            'version' => $this->getSanitizer()->getString('version'),
            'retired' => $this->getSanitizer()->getInt('retired')
        ]));

        // Add some additional row content
        foreach ($versions as $version) {
            $version->includeProperty('buttons');            
            
            // Download
            $version->buttons[] = array( 
                'id' => 'content_button_download',
                'linkType' => '_self', 'external' => true,
                'url' => $this->urlFor('clientversion.download', ['id' => $version->versionId]),
                'text' => __('Download')
            );
            
            // Edit
            $version->buttons[] = array( 
                'id' => 'content_button_edit',
                'url' => $this->urlFor('clientversion.edit.form', ['id' => $version->versionId]),
                'text' => __('Edit')
            );

            // Delete
            $version->buttons[] = array(
                'id' => 'content_button_delete',
                'url' => $this->urlFor('clientversion.delete.form', ['id' => $version->versionId]),
                'text' => __('Delete')
            );
        }

        $this->getState()->template = 'grid';
        $this->getState()->recordsTotal = $this->clientVersionFactory->countLast();
        $this->getState()->setData($versions);
    }
    
    /**
     * Gets a file from the library
     * @param int $versionId
     *
     * @SWG\Get(
     *  path="/clientversion/download/{versionId}",
     *  operationId="download",
     *  tags={"clientversion"},
     *  summary="Download Client Version",
     *  description="Download a Version file from the Client Version's pool",
     *  produces={"application/octet-stream"},
     *  @SWG\Parameter(
     *      name="versionId",
     *      in="path",
     *      description="The Version ID to Download",
     *      type="integer",
     *      required=true
     *   ),
     *  @SWG\Response(
     *      response=200,
     *      description="successful operation",
     *      @SWG\Schema(type="file"),
     *      @SWG\Header(
     *          header="X-Sendfile",
     *          description="Apache Send file header - if enabled.",
     *          type="string"
     *      ),
     *      @SWG\Header(
     *          header="X-Accel-Redirect",
     *          description="nginx send file header - if enabled.",
     *          type="string"
     *      )
     *  )
     * )
     */
    public function download($versionId)
    {
        $this->getLog()->debug('Download request for versionId %d', $versionId);

        $version = $this->clientVersionFactory->getById($versionId);
        $upgradeLocation = $this->getConfig()->GetSetting('UPGRADE_LOCATION');
        $upgradeFileName = $upgradeLocation . $version->fileName;
        
        try {
            if (!file_exists($upgradeFileName))
                throw new NotFoundException('UPGRADE_LOCATION exists but file missing. ' . $upgradeLocation);
            
            $size = filesize($upgradeFileName);
            
            // Issue some headers
            $this->getApp()->expires('+1 week');
            header('Content-Type: application/octet-stream');
            header('Content-Transfer-Encoding: Binary');
            header('Content-disposition: attachment; filename="' . $version->fileName . '"');
            header('Content-Length: ' . $size);
            
            // Send via Apache X-Sendfile header?
            if ($this->getConfig()->GetSetting('SENDFILE_MODE') == 'Apache') {
                header("X-Sendfile: $upgradeFileName");
            }
            // Send via Nginx X-Accel-Redirect?
            else if ($this->getConfig()->GetSetting('SENDFILE_MODE') == 'Nginx') {
                header("X-Accel-Redirect: /download/version");
            }
            else {
                // Return the file with PHP
                readfile($upgradeFileName);
                $this->setNoOutput(true);
            }
        } catch (Exception $ex) {
            throw new ConfigurationException(__('Could not download file.'));
        }
    }

    public function deleteForm($versionId)
    {
        $version = $this->clientVersionFactory->getById($versionId);
        $this->getState()->template = 'version-form-delete';
        $this->getState()->setData([
            'version' => $version,
            'help' => $this->getHelp()->link('Version', 'Delete')
        ]);
    }
    
    function delete($versionId)
    {
        $version = $this->clientVersionFactory->getById($versionId);

        if (!$this->getUser()->checkDeleteable($version))
            throw new AccessDeniedException();

        $version->delete();
        
        $upgradeFolder = $this->getConfig()->GetSetting('UPGRADE_LOCATION');
        
        unlink($upgradeFolder . '/' . $version->fileName);

        // Return
        $this->getState()->hydrate([
            'httpStatus' => 204,
            'message' => sprintf(__('Deleted %s'), $version->version),
            'id' => $version->versionId,
            'data' => $version
        ]);
    }
    
    public function editForm($versionId)
    {
        $version = $this->clientVersionFactory->getById($versionId);
        
        if (!$this->getUser()->checkEditable($version))
           throw new AccessDeniedException();
         
        $this->getState()->template = 'client-version-form-edit';
        $this->getState()->setData([
            'version' => $version,
            'help' => $this->getHelp()->link('Upgrade Client', 'Edit')
        ]);
    }

    public function edit($versionId)
    {
        $version = $this->clientVersionFactory->getById($versionId);
        
        $version->description = $this->getSanitizer()->getString('description');
        $version->retired = $this->getSanitizer()->getCheckbox('retired');
        
        if (!$this->getUser()->checkEditable($version))
            throw new AccessDeniedException();
            
        $version->edit();

        // Return
        $this->getState()->hydrate([
            'message' => sprintf(__('Edited %s'), $version->version),
            'id' => $version->versionId,
            'data' => $version
        ]);
    }

    public function add($options = [])
    {        
        $upgradeFolder = $this->getConfig()->GetSetting('UPGRADE_LOCATION');

        // Make sure the library exists
        self::ensureFolderExists($upgradeFolder);

        $options = array(
            'userId' => $this->getUser()->userId,
            'controller' => $this,
            'upload_dir' => $upgradeFolder,
            'download_via_php' => true,
            'script_url' => $this->urlFor('clientversion.add'),
            'upload_url' => $this->urlFor('clientversion.add'),
            'image_versions' => array(),
            'accept_file_types' => '/\.zip$/i',
        );

        // Output handled by UploadHandler
        $this->setNoOutput(true);

        $this->getLog()->debug('Hand off to Upload Handler with options: %s', json_encode($options));

        // Hand off to the Upload Handler provided by jquery-file-upload
        new UpgradeUploadHandler($options);
    }

    public static function ensureFolderExists($upgradeFolder)
    {
        // Check that this location exists - and if not create it..
        if (!file_exists($upgradeFolder))
            mkdir($upgradeFolder, 0777, true);

        // Check that we are now writable - if not then error
        if (!is_writable($upgradeFolder))
            throw new ConfigurationException(__('Upgrade folder not writable'));
    }   
}
