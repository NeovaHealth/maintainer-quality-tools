#!/usr/bin/make

root_path=..

all: create_venv install_deps flake8 pylint make_addons_dir move_addons_into_dir

create_venv:
	virtualenv ${root_path}/venv

install_deps:
	${root_path}/venv/bin/pip install -r ${root_path}/requirements.txt
	${root_path}/venv/bin/pip install -r ${root_path}/../nhclinical/requirements.txt
	${root_path}/venv/bin/pip install -r ${root_path}/../openeobs/requirements.txt
	${root_path}/venv/bin/pip install -r ${root_path}/../BJSS_liveobs_client_modules/requirements.txt

flake8:
	${root_path}/venv/bin/flake8 --config=../travis/cfg/travis_run_flake8.cfg ${root_path}/nhclinical
	${root_path}/venv/bin/flake8 --config=../travis/cfg/travis_run_flake8.cfg ${root_path}/openeobs
	${root_path}/venv/bin/flake8 --config=../travis/cfg/travis_run_flake8.cfg ${root_path}/BJSS_liveobs_client_modules

pylint:
	${root_path}/venv/bin/pylint --load-plugins=pylint_odoo --rcfile=../travis/cfg/travis_run_pylint.cfg ${root_path}/nhclinical
	${root_path}/venv/bin/pylint --load-plugins=pylint_odoo --rcfile=../travis/cfg/travis_run_pylint.cfg ${root_path}/openeobs
	${root_path}/venv/bin/pylint --load-plugins=pylint_odoo --rcfile=../travis/cfg/travis_run_pylint.cfg ${root_path}/BJSS_liveobs_client_modules

checkout_branches:
	bash -c ./checkout_branches.sh

make_addons_dir:
	mkdir -p ${root_path}/liveobs_addons

move_addons_into_dir:
    # Find directories and copy them. The '-regex' test omits subdirectories like '.github' and the '-name' test omits the current directory,
    # i.e. 'nhclinical' itself is not copied.
	/bin/bash -c "find ${root_path}/nhclinical -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"
	/bin/bash -c "find ${root_path}/openeobs -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"
	/bin/bash -c "find ${root_path}/BJSS_liveobs_client_modules -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"

.PHONY: create_venv install_deps flake8 pylint make_addons_dir move_addons_into_dir