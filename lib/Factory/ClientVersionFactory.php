<?php

namespace Xibo\Factory;


use Xibo\Entity\ClientVersion;

/**
 * Class ClientVersionFactory
 * @package Xibo\Factory
 */
class ClientVersionFactory extends BaseFactory
{
    public function __construct($store, $log, $sanitizerService, $user, $userFactory)
    {
        $this->setCommonDependencies($store, $log, $sanitizerService);

        $this->setAclDependencies($user, $userFactory);
    }

    public function createEmpty()
    {
        return new ClientVersion($this->getStore(), $this->getLog());
    }

    public function query($sortOrder = null, $filterBy = null)
    {
        $entries = array();
        $params = array();

        if ($sortOrder === null)
            $sortOrder = ['`versionId`'];

        try {
            $select = '
            SELECT `clientversion`.versionId,
                `clientversion`.version,
                `clientversion`.fileName,
                `clientversion`.description,
                `clientversion`.uploadDate,
                `clientversion`.retired,
                `clientversion`.lastUpdateOwner,
                `clientversion`.lastUpdateDate,
                `clientversion`.uploadOwner ';

            $body = '
              FROM `clientversion`
             WHERE 1 = 1
            ';

            // Filter by version
            if ($this->getSanitizer()->getString('version', $filterBy) != null) {
                // Convert into commas
                foreach (explode(',', $this->getSanitizer()->getString('version', $filterBy)) as $term) {

                    if (empty(trim($term)))
                        continue;

                    // convert into a space delimited array
                    $names = explode(' ', $term);

                    $i = 0;
                    foreach ($names as $searchName) {
                        $i++;
                        // Not like, or like?
                        if (substr($searchName, 0, 1) == '-') {
                            $body .= " AND `clientversion`.version NOT RLIKE (:version$i) ";
                            $params['group' . $i] = ltrim(($searchName), '-');
                        } else {
                            $body .= " AND `clientversion`.version RLIKE (:version$i) ";
                            $params['version' . $i] = $searchName;
                        }
                    }
                }
            }

            if ($this->getSanitizer()->getInt('retired', 0, $filterBy) != -1) {
                $body .= " AND clientversion.retired = :retired ";
                $params['retired'] = $this->getSanitizer()->getInt('retired', 0, $filterBy);
            }

            // Sorting?
            $order = '';
            if (is_array($sortOrder))
                $order .= 'ORDER BY ' . implode(',', $sortOrder);

            $limit = '';
            // Paging
            if ($filterBy !== null && $this->getSanitizer()->getInt('start', $filterBy) !== null && $this->getSanitizer()->getInt('length', $filterBy) !== null) {
                $limit = ' LIMIT ' . intval($this->getSanitizer()->getInt('start', $filterBy), 0) . ', ' . $this->getSanitizer()->getInt('length', 10, $filterBy);
            }

            $sql = $select . $body . $order . $limit;

            foreach ($this->getStore()->select($sql, $params) as $row) {
                $entries[] = $this->createEmpty()->hydrate($row);
            }

            // Paging
            if ($limit != '' && count($entries) > 0) {
                $results = $this->getStore()->select('SELECT COUNT(*) AS total ' . $body, $params);
                $this->_countLast = intval($results[0]['total']);
            }

            return $entries;

        } catch (\Exception $e) {

            $this->getLog()->error($e);

            throw $e;
        }
    }
}