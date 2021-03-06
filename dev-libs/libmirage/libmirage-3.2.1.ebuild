# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit cmake-utils xdg-utils

DESCRIPTION="CD and DVD image access library"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/${P}.tar.bz2"

LICENSE="GPL-2+"
SLOT="0/11" # subslot = libmirage soname version
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="doc +introspection"

RDEPEND=">=app-arch/bzip2-1:=
	>=app-arch/xz-utils-5:=
	>=dev-libs/glib-2.38:2
	>=media-libs/libsamplerate-0.1:=
	>=media-libs/libsndfile-1.0:=
	sys-libs/zlib:=
	introspection? ( >=dev-libs/gobject-introspection-1.30 )"
DEPEND="${RDEPEND}
	dev-util/desktop-file-utils
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

src_configure() {
	local mycmakeargs=(
		-DGTKDOC_ENABLED="$(usex doc)"
		-DINTROSPECTION_ENABLED="$(usex introspection)"
		-DPOST_INSTALL_HOOKS=OFF # avoid sandbox violation, #487304
	)
	cmake-utils_src_configure
}

src_install() {
	local DOCS=( AUTHORS README )
	cmake-utils_src_install
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
}
