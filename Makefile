##
# Build an optimized parser with caching
#
all:
	pegjs -e IGON --cache -o speed "src/IGON.pegjs" "bin/IGON.js"
