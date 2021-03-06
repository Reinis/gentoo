# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="cffi-based Python bindings for nanomsg"
HOMEPAGE="https://github.com/nanomsg/nnpy"
SRC_URI="https://github.com/nanomsg/nnpy/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE=""

DEPEND="
	dev-python/cffi:=[${PYTHON_USEDEP}]
	dev-libs/nanomsg:=
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/py3.patch" )

python_test() {
	PYTHONPATH="${S}:${PYTHONPATH}" "${PYTHON}" "${S}/nnpy/tests.py" || die
}
