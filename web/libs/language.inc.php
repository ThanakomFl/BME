<?php

/**
 * Load user language, or use default if has not been set yet
 */
function load_user_language()
{
    global $CONFIG, $SESSION;

    if (!isset($SESSION['language'])) {
        $SESSION['language'] = $CONFIG['default_lang'];

        $HTTPAcceptedLanguage = $CONFIG['default_lang'];
        if (isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])) {
            $HTTPAcceptedLanguage = $_SERVER['HTTP_ACCEPT_LANGUAGE'];
        }

        $acceptedLanguages = explode(',', $HTTPAcceptedLanguage);
        foreach ($acceptedLanguages as $acceptedLanguage) {
            $languageExploded = explode(';', $acceptedLanguage);
            $regionExploded = explode('-', $languageExploded[0]);
            $languageCode = trim($regionExploded[0]);

            if ($languageCode != 'th' || $languageCode != 'en') {
                continue;
            }

            $SESSION['language'] = $languageCode;
        }
    }
}