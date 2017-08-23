<?php

namespace Xibo\Controller;

use Stash\Interfaces\PoolInterface;

essDeniedException;
use Xibo\Exception\ConfigurationException;
use Xibo\Exception\XiboException;
use Xibo\Factory\DayPartFactory;
use Xibo\Factory\DisplayFactory;
use Xibo\Factory\DisplayGroupFactory;
use Xibo\Factory\LayoutFactory;
use Xibo\Factory\ClientVersionFactory;
use Xibo\Factory\ModuleFactory;
use Xibo\Factory\PermissionFactory;
use Xibo\Factory\PlaylistFactory;
use Xibo\Factory\RegionFactory;
use Xibo\Factory\ScheduleFactory;
use Xibo\Factory\TagFactory;
use Xibo\Factory\UserFactory;
use Xibo\Factory\UserGroupFactory;
use Xibo\Factory\WidgetFactory;
use Xibo\Helper\ByteFormatter;
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
     * @var ModuleFactory
     */
    private $moduleFactory;

    /**
     * @var TagFactory
     */
    private $tagFactory;

    /**
     * @var ClientVersionFactory
     */
    private $clientVersionFactory;

    /**
     * @var WidgetFactory
     */
    private $widgetFactory;

    /**
     * @var PlaylistFactory
     */
    private $playlistFactory;

    /**
     * @var LayoutFactory
     */
    private $layoutFactory;

    /**
     * @var PermissionFactory
     */
    private $permissionFactory;

    /**
     * @var UserGroupFactory
     */
    private $userGroupFactory;

    /** @var  DisplayGroupFactory */
    private $displayGroupFactory;

    /** @var  RegionFactory */
    private $regionFactory;

    /** @var  DataSetFactory */
    private $dataSetFactory;

    /** @var  DisplayFactory */
    private $displayFactory;

    /** @var ScheduleFactory  */
    private $scheduleFactory;

    /** @var  DayPartFactory */
    private $dayPartFactory;

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
     * @param ModuleFactory $moduleFactory
     * @param TagFactory $tagFactory
     * @param MediaFactory $mediaFactory
     * @param WidgetFactory $widgetFactory
     * @param PermissionFactory $permissionFactory
     * @param LayoutFactory $layoutFactory
     * @param PlaylistFactory $playlistFactory
     * @param UserGroupFactory $userGroupFactory
     * @param DisplayGroupFactory $displayGroupFactory
     * @param RegionFactory $regionFactory
     * @param DataSetFactory $dataSetFactory
     * @param DisplayFactory $displayFactory
     * @param ScheduleFactory $scheduleFactory
     * @param DayPartFactory $dayPartFactory
     */
    public function __construct($log, $sanitizerService, $state, $user, $help, $date, $config, $store, $pool, $userFactory, $moduleFactory, $tagFactory, $clientVersionFactory, $widgetFactory, $permissionFactory, $layoutFactory, $playlistFactory, $userGroupFactory, $displayGroupFactory, $regionFactory, $dataSetFactory, $displayFactory, $scheduleFactory, $dayPartFactory)
    {
        $this->setCommonDependencies($log, $sanitizerService, $state, $user, $help, $date, $config);

        $this->store = $store;
        $this->moduleFactory = $moduleFactory;
        $this->clientVersionFactory = $clientVersionFactory;
        $this->widgetFactory = $widgetFactory;
        $this->pool = $pool;
        $this->userFactory = $userFactory;
        $this->tagFactory = $tagFactory;
        $this->permissionFactory = $permissionFactory;
        $this->layoutFactory = $layoutFactory;
        $this->playlistFactory = $playlistFactory;
        $this->userGroupFactory = $userGroupFactory;
        $this->displayGroupFactory = $displayGroupFactory;
        $this->regionFactory = $regionFactory;
        $this->dataSetFactory = $dataSetFactory;
        $this->displayFactory = $displayFactory;
        $this->scheduleFactory = $scheduleFactory;
        $this->dayPartFactory = $dayPartFactory;
    }

    /**
     * Get Module Factory
     * @return ModuleFactory
     */
    public function getModuleFactory()
    {
        return $this->moduleFactory;
    }
    
    public function getClientVersionFactory()
    {
        return $this->clientVersionFactory;
    }

    /**
     * Get Media Factory
     * @return MediaFactory
     */
    public function getMediaFactory()
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
     * Get Widget Factory
     * @return WidgetFactory
     */
    public function getWidgetFactory()
    {
        return $this->widgetFactory;
    }

    /**
     * Get Layout Factory
     * @return LayoutFactory
     */
    public function getLayoutFactory()
    {
        return $this->layoutFactory;
    }

    /**
     * Get Playlist Factory
     * @return PlaylistFactory
     */
    public function getPlaylistFactory()
    {
        return $this->playlistFactory;
    }

    /**
     * Get UserGroup Factory
     * @return UserGroupFactory
     */
    public function getUserGroupFactory()
    {
        return $this->userGroupFactory;
    }

    /**
     * Get RegionFactory
     * @return RegionFactory
     */
    public function getRegionFactory()
    {
        return $this->regionFactory;
    }

    /**
     * Get DisplayGroup Factory
     * @return DisplayGroupFactory
     */
    public function getDisplayGroupFactory()
    {
        return $this->displayGroupFactory;
    }

    /**
     * @return DataSetFactory
     */
    public function getDataSetFactory()
    {
        return $this->dataSetFactory;
    }

    /**
     * @return DisplayFactory
     */
    public function getDisplayFactory()
    {
        return $this->displayFactory;
    }

    /**
     * @return ScheduleFactory
     */
    public function getScheduleFactory()
    {
        return $this->scheduleFactory;
    }

    /**
     * Displays the page logic
     */
    function displayPage()
    {
        $this->getState()->template = 'client-version-page';
    }

    /**
     * Prints out a Table of all media items
     *
     * @SWG\Get(
     *  path="/library",
     *  operationId="librarySearch",
     *  tags={"library"},
     *  summary="Library Search",
     *  description="Search the Library for this user",
     *  @SWG\Parameter(
     *      name="mediaId",
     *      in="formData",
     *      description="Filter by Media Id",
     *      type="integer",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="media",
     *      in="formData",
     *      description="Filter by Media Name",
     *      type="string",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="type",
     *      in="formData",
     *      description="Filter by Media Type",
     *      type="string",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="ownerId",
     *      in="formData",
     *      description="Filter by Owner Id",
     *      type="integer",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="retired",
     *      in="formData",
     *      description="Filter by Retired",
     *      type="integer",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="tags",
     *      in="formData",
     *      description="Filter by Tags - comma seperated",
     *      type="string",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="duration",
     *      in="formData",
     *      description="Filter by Duration - a number or less-than,greater-than,less-than-equal or great-than-equal followed by a | followed by a number",
     *      type="string",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="fileSize",
     *      in="formData",
     *      description="Filter by File Size - a number or less-than,greater-than,less-than-equal or great-than-equal followed by a | followed by a number",
     *      type="string",
     *      required=false
     *   ),
     *  @SWG\Parameter(
     *      name="ownerUserGroupId",
     *      in="formData",
     *      description="Filter by users in this UserGroupId",
     *      type="integer",
     *      required=false
     *   ),
     *  @SWG\Response(
     *      response=200,
     *      description="successful operation",
     *      @SWG\Schema(
     *          type="array",
     *          @SWG\Items(ref="#/definitions/Media")
     *      )
     *  )
     * )
     */
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

    /**
     * Media Delete Form
     * @param int $mediaId
     */
    public function deleteForm($mediaId)
    {
        
    }

    /**
     * Delete Media
     * @param int $mediaId
     *
     * @SWG\Delete(
     *  path="/library/{mediaId}",
     *  operationId="libraryDelete",
     *  tags={"library"},
     *  summary="Delete Media",
     *  description="Delete Media from the Library",
     *  @SWG\Parameter(
     *      name="mediaId",
     *      in="path",
     *      description="The Media ID to Delete",
     *      type="integer",
     *      required=true
     *   ),
     *  @SWG\Parameter(
     *      name="forceDelete",
     *      in="formData",
     *      description="If the media item has been used should it be force removed from items that uses it?",
     *      type="integer",
     *      required=true
     *   ),
     *  @SWG\Response(
     *      response=204,
     *      description="successful operation"
     *  )
     * )
     */
    public function delete($mediaId)
    {
        
    }

    /**
     * Add a file to the library
     *  expects to be fed by the blueimp file upload handler
     * @throws \Exception
     *
     * @SWG\Post(
     *  path="/library",
     *  operationId="libraryAdd",
     *  tags={"library"},
     *  summary="Add Media",
     *  description="Add Media to the Library",
     *  @SWG\Parameter(
     *      name="files",
     *      in="formData",
     *      description="The Uploaded File",
     *      type="file",
     *      required=true
     *   ),
     *  @SWG\Parameter(
     *      name="name",
     *      in="formData",
     *      description="Optional Media Name",
     *      type="string",
     *      required=false
     *  ),
     *  @SWG\Parameter(
     *      name="oldMediaId",
     *      in="formData",
     *      description="Id of an existing media file which should be replaced with the new upload",
     *      type="integer",
     *      required=false
     *  ),
     *  @SWG\Parameter(
     *      name="updateInLayouts",
     *      in="formData",
     *      description="Flag (0, 1), set to 1 to update this media in all layouts (use with oldMediaId) ",
     *      type="integer",
     *      required=false
     *  ),
     *  @SWG\Parameter(
     *      name="deleteOldRevisions",
     *      in="formData",
     *      description="Flag (0 , 1), to either remove or leave the old file revisions (use with oldMediaId)",
     *      type="integer",
     *      required=false
     *   ),
     *  @SWG\Response(
     *      response=200,
     *      description="successful operation"
     *  )
     * )
     *
     * @param array $options
     */
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

    /**
     * Make sure the library exists
     * @param string $libraryFolder
     * @throws ConfigurationException when the library is not writable
     */
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
