#!/usr/bin/make

all: create_venv install_deps make_addons_dir move_addons_into_dir flake8 pylint

create_venv:
	virtualenv ${root_path}/venv

install_deps:
	${root_path}/venv/bin/pip install -r ../requirements.txt
	${root_path}/venv/bin/pip install -r ${root_path}/nhclinical/requirements.txt
	${root_path}/venv/bin/pip install -r ${root_path}/openeobs/requirements.txt
	${root_path}/venv/bin/pip install -r ${root_path}/BJSS_liveobs_client_modules/requirements.txt

flake8:
	${root_path}/venv/bin/flake8 --config=../travis/cfg/travis_run_flake8.cfg ${root_path}/liveobs_addons

pylint:
	${root_path}/venv/bin/pylint --load-plugins=pylint_odoo --rcfile=../travis/cfg/travis_run_pylint.cfg -r n --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" ${root_path}/liveobs_addons > ${root_path}/pylint_report.txt

make_addons_dir:
	mkdir -p ${root_path}/liveobs_addons

move_addons_into_dir:
    # Find directories and copy them. The '-regex' test omits subdirectories like '.github' and the '-name' test omits the current directory,
    # i.e. 'nhclinical' itself is not copied.
	/bin/bash -c "find ${root_path}/nhclinical -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"
	/bin/bash -c "find ${root_path}/openeobs -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"
	/bin/bash -c "find ${root_path}/client_modules -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"
	/bin/bash -c "rm -rf ${root_path}/liveobs_addons/nhclinical"
	/bin/bash -c "rm -rf ${root_path}/liveobs_addons/openeobs"
	/bin/bash -c "rm -rf ${root_path}/liveobs_addons/client_modules"

run_sonar_scanner:
	sonar-scanner -Dproject.settings=sonar-project.properties -X

.PHONY: create_venv install_deps flake8 pylint make_addons_dir move_addons_into_dir run_sonar_scanner