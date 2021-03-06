<?php
/**
 * IoT tests
 *
 * @package Test
 * @author Andreas Götz <cpuidle@gmx.de>
 */

namespace Tests;

use Volkszaehler\Util;

class IotTest extends Middleware
{
	protected $uuid;

	function testRetrievel() {
		$secret = str_replace('-', '', Util\UUID::mint());
		$this->getJson('/channel.json', array(
			'operation' => 'add',
			'title' => 'Power',
			'type' => 'power',
			'resolution' => 1,
			'owner' => $secret
		), 'GET');
		$this->assertTrue(isset($this->json->entity), "Expected <entity> got none");
		$this->assertTrue(isset($this->json->entity->uuid));

		$uuid = $this->json->entity->uuid;

		// retrieve by secret
		$this->getJson('/iot/' . $secret . '.json');
		$this->assertTrue(isset($this->json->entities), "Expected <entities> got none");
		$this->assertEquals(1, count($this->json->entities));
		$this->assertEquals($uuid, $this->json->entities[0]->uuid);
	}
}

?>
