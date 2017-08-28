<?php

namespace Xibo\Controller;

use Stash\Interfaces\PoolInterface;

essDeniedException;
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
        $mediaList = $this->clientVersionFactory->query($this->gridRenderSort(), $this->gridRenderFilter([
            'version' => $this->getSanitizer()->getString('version'),
            'retired' => $this->getSanitizer()->getInt('retired')
        ]));

        // Add some additional row content
        foreach ($mediaList as $media) {
            $media->buttons[] = array(
                    'id' => 'content_button_edit',
                    'url' => $this->urlFor('library.edit.form', ['id' => $media->mediaId]),
                    'text' => __('Edit')
                );

            // Delete
                $media->buttons[] = array(
                    'id' => 'content_button_delete',
                    'url' => $this->urlFor('library.delete.form', ['id' => $media->mediaId]),
                    'text' => __('Delete')
                );

            // Permissions
                $media->buttons[] = array(
                    'id' => 'content_button_permissions',
                    'url' => $this->urlFor('user.permissions.form', ['entity' => 'Media', 'id' => $media->mediaId]),
                    'text' => __('Permissions')
                );

            // Download
            $media->buttons[] = array(
                'id' => 'content_button_download',
                'linkType' => '_self', 'external' => true,
                'url' => $this->urlFor('library.download', ['id' => $media->mediaId]) . '?attachment=' . $media->fileName,
                'text' => __('Download')
            );

            $media->buttons[] = ['divider' => true];

            $media->buttons[] = array(
                'id' => 'usage_report_button',
                'url' => $this->urlFor('library.usage.form', ['id' => $media->mediaId]),
                'text' => __('Usage Report')
            );
        }

        $this->getState()->template = 'grid';
        $this->getState()->recordsTotal = $this->clientVersionFactory->countLast();
        $this->getState()->setData($mediaList);
    }

    public function deleteForm($mediaId)
    {
        
    }

    public function delete($mediaId)
    {
        
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
