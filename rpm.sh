#!/bin/bash -x

SOURCE=$1
DIST_DIR=./dist
TOP_DIR=./staging
BUILD_DIR=${TOP_DIR}/BUILD
RPMS_DIR=${TOP_DIR}/RPMS
SOURCES_DIR=${TOP_DIR}/SOURCES
SPECS_DIR=${TOP_DIR}/SPECS
SRPMS_DIR=${TOP_DIR}/SRPMS

rm -rf $TOP_DIR
mkdir ${TOP_DIR}
mkdir ${BUILD_DIR}
mkdir ${RPMS_DIR}
mkdir ${SOURCES_DIR}
mkdir ${SPECS_DIR}
mkdir ${SRPMS_DIR}
mkdir ${DIST_DIR}

RELEASE_DATE=`date +%Y%m%d%H%M`
sed "s/@RELEASE@/${RELEASE_DATE}/" rpm/cdk.spec > ${SPECS_DIR}/cdk.spec

SOURCE_TAR_GZ="${SOURCE}.tar.gz"
cp $SOURCE_TAR_GZ ${SOURCES_DIR}

rpmbuild -ba --target noarch --define "_topdir ${PWD}/staging" staging/SPECS/cdk.spec

RPM_FILE=${SOURCE}-${RELEASE_DATE}.noarch.rpm
cp ${RPMS_DIR}/noarch/$RPM_FILE ${DIST_DIR}/.
gzip $DIST_DIR/$RPM_FILE
