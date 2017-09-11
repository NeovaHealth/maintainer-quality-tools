#!/usr/bin/make

all: create_venv install_deps flake8 pylint make_addons_dir move_addons_into_dir

create_venv:
	@cd ${root_path}
	virtualenv venv

install_deps:
	${root_path}/venv/bin/pip install -r ${root_path}/maintainer_quality_tools/requirement.txt
	${root_path}/venv/bin/pip install -r ${root_path}/nhclinical/requirement.txt
	${root_path}/venv/bin/pip install -r ${root_path}/openeobs/requirement.txt
	${root_path}/venv/bin/pip install -r ${root_path}/client_modules/requirement.txt

flake8:
	${root_path}/venv/bin/flake8 --config=${root_path}/maintainer-quality-tools/travis/cfg/travis_run_flake8.cfg nhclinical
	${root_path}/venv/bin/flake8 --config=${root_path}/maintainer-quality-tools/travis/cfg/travis_run_flake8.cfg openeobs
	${root_path}/venv/bin/flake8 --config=${root_path}/maintainer-quality-tools/travis/cfg/travis_run_flake8.cfg client_modules

pylint:
	${root_path}/venv/bin/pylint --load-plugins=pylint_odoo --rcfile=maintainer-quality-tools/travis/cfg/travis_run_pylint.cfg nhclinical
	${root_path}/venv/bin/pylint --load-plugins=pylint_odoo --rcfile=maintainer-quality-tools/travis/cfg/travis_run_pylint.cfg openeobs
	${root_path}/venv/bin/pylint --load-plugins=pylint_odoo --rcfile=maintainer-quality-tools/travis/cfg/travis_run_pylint.cfg client_modules

make_addons_dir:
	mkdir -p ${root_path}/liveobs_addons

move_addons_into_dir:
	/bin/bash -c "find ${root_path}/nhclinical -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"
	/bin/bash -c "find ${root_path}/openeobs -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"
	/bin/bash -c "find ${root_path}/client_modules -maxdepth 1 -type d ! -regex '\.\/\..*' -not -name \".\" -exec cp -r {}  ${root_path}/liveobs_addons \;"

.PHONY create_venv install_deps flake8 pylint make_addons_dir move_addons_into_dir