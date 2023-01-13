<?php
$defaultPhoneRegion = getenv('NC_DEFAULT_LOCALE');
if ($defaultPhoneRegion) {
  $CONFIG['default_locale'] = $defaultPhoneRegion;
}

$defaultLanguage = getenv('NC_DEFAULT_LANGUAGE');
if ($overwriteProtocol) {
  $CONFIG['default_language'] = $defaultLanguage;
}

$defaultPhoneRegion = getenv('NC_DEFAULT_PHONE_REGION');
if ($overwriteCliUrl) {
  $CONFIG['default_phone_region'] = $defaultPhoneRegion;
}
