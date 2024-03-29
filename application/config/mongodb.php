<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| DATABASE CONNECTIVITY SETTINGS
| -------------------------------------------------------------------------
| This file will contain the settings needed to access your Mongo database.
|
| -------------------------------------------------------------------------
*/

$config['mongodb']['active'] = 'default';

$config['mongodb']['default']['dns'] 				=		'';
$config['mongodb']['default']['database']			=		'';
$config['mongodb']['default']['db_debug']			=		TRUE;
$config['mongodb']['default']['return_as']			=		'object';
$config['mongodb']['default']['write_concerns']		=		(int)1;
$config['mongodb']['default']['journal']			=		TRUE;
$config['mongodb']['default']['read_preference']	=		NULL;
$config['mongodb']['default']['read_preference_tags']=		NULL;

/* End of file database.php */
/* Location: ./application/config/database.php */
