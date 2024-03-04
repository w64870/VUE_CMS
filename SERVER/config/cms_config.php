<?php

return [
    'baza_danych' => [
        'host' 		    => '127.0.0.1',
        'port'          => '1521',
        'sid'           => 'orcl',
        'alias'         => '',
        'uzytkownik'    => 'sys',
        'haslo' 	    => 'haslo',
    ],
    'strona_logowania' => [
        'sciezka_do_pliku_logo' => '',
        'tekst_pod_logo' => '',
        'pokaz_biezaca_date' => 'false',
    ],
    'format_daty' => [
        'separator' => '/',
        'czy_malejaca_jednostka' => 'true',
        'czy_czterocyfrowy_rok' => 'true',
        'czy_czas_z_sekundami' => 'false',
    ],
    'pozostale' => [
        'tryb_debuggowania' => 'true',
    ], 
];

