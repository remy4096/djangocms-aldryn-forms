APP = aldryn_forms

.PHONY: default msg msg-compile msg-py msg-make-py msg-sort-py msg-js msg-make-js msg-sort-js test isort check-css

default: test

# Translations
msg: msg-py msg-js

msg-py: msg-make-py msg-sort-py

msg-make-py:
	unset -v DJANGO_SETTINGS_MODULE; cd ${APP} && django-admin makemessages -l cs

msg-sort-py:
	msgattrib --sort-output --no-location --no-obsolete -o ${TRANSLATIONS} ${TRANSLATIONS}

msg-js: msg-make-js msg-sort-js

msg-make-js:
	unset -v DJANGO_SETTINGS_MODULE; cd ${APP} && django-admin makemessages -l cs -d djangojs

msg-sort-js:
	msgattrib --sort-output --no-location --no-obsolete -o ${TRANSLATIONS_JS} ${TRANSLATIONS_JS}

msg-compile:
	msgfmt ${APP}/locale/cs/LC_MESSAGES/django.po -o ${APP}/locale/cs/LC_MESSAGES/django.mo
	msgfmt ${APP}/locale/cs/LC_MESSAGES/djangojs.po -o ${APP}/locale/cs/LC_MESSAGES/djangojs.mo
	msgfmt ${APP}/locale/de/LC_MESSAGES/django.po -o ${APP}/locale/de/LC_MESSAGES/django.mo
	msgfmt ${APP}/locale/fa/LC_MESSAGES/django.po -o ${APP}/locale/fa/LC_MESSAGES/django.mo
	msgfmt ${APP}/locale/fr/LC_MESSAGES/django.po -o ${APP}/locale/fr/LC_MESSAGES/django.mo
	msgfmt ${APP}/locale/it/LC_MESSAGES/django.po -o ${APP}/locale/it/LC_MESSAGES/django.mo
	msgfmt ${APP}/locale/lt/LC_MESSAGES/django.po -o ${APP}/locale/lt/LC_MESSAGES/django.mo
	msgfmt ${APP}/locale/nl/LC_MESSAGES/django.po -o ${APP}/locale/nl/LC_MESSAGES/django.mo

test:
	tox --parallel all --parallel-live

test-coverage:
	LANG=en_US.UTF-8 PYTHONPATH='./tests:${PYTHONPATH}' DJANGO_SETTINGS_MODULE='settings' coverage run --source=${APP} --branch -m django test ${APP}

isort:
	isort ${APP}

check-css:
	npm run check-css

check-js:
	npm run check-js

build-js-css:
	npm run build
