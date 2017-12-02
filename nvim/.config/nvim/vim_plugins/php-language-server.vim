if exists('g:vim_plug_installing_plugins')
	Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}
	finish
endif
