<?php

namespace Xibo\Helper;

use Exception;
use Xibo\Entity\Layout;

/**
 * Class UpgradeUploadHandler
 * @package Xibo\Helper
 */
class UpgradeUploadHandler extends BlueImpUploadHandler
{
    /**
     * @param $file
     * @param $index
     * @throws \Xibo\Exception\ConfigurationException
     */
    protected function handle_form_data($file, $index)
    {
        $controller = $this->options['controller'];
        /* @var \Xibo\Controller\Layout $controller */

        // Handle form data, e.g. $_REQUEST['description'][$index]
        $fileName = $file->name;

        $controller->getLog()->debug('Upload complete for ' . $fileName . '.');

        // Upload and Save
        try {
            $filePath = $controller->getConfig()->GetSetting('UPGRADE_LOCATION') . $fileName;
            $user = $controller->getUser();          
            $noteContent = file_get_contents('zip://' . $filePath . '#version.txt');
            
            $contents = explode(PHP_EOL, $noteContent);
            
            $path_parts = pathinfo($filePath);
            
            $newFileName = $path_parts['filename'] . '_' .$contents[0]. '_' . date("Y-m-d_H:i:s") . '.zip';
            
            rename($filePath, $path_parts['dirname'] . '\\'. $newFileName);
            
            $upgradeItem = $controller->getClientVersionFactory()->createEmpty();
            
            $upgradeItem->add($contents[0], $newFileName, $contents[1], $user->userId);
            
        } catch (Exception $e) {
            $controller->getLog()->error('Error uploading upgrade file: %s', $e->getMessage());
            $controller->getLog()->debug($e->getTraceAsString());

            $file->error = $e->getMessage();

            $controller->getApp()->commit = false;
        }
    }
}