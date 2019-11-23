.PHONY: all
all: build test
#Set binary file name
PKG = main
#Set zip file name
ZIPNAME = build.zip

#Set default value for GOOS and GOARCH
GOOS = linux
GOARCH = amd64

#Directories
WD = $(subst $(BSLASH),$(FLASH),$(shell pwd))
DISTDIR = $(WD)/dist

_build:
	#Set output dir of binary file
	$(eval OUTPUTDIR := $(DISTDIR))
	#Make directory if not exist
	@mkdir -p "$(DISTDIR)"
	@echo "[build] ..."
	#Set GOOS and GOARCH
	@GOOS=$(GOOS) GOARCH=$(GOARCH)
	#Build 
	go build -ldflags="-s -w" -o "$(OUTPUTDIR)/bin/$(PKG)" main.go
	@echo "[build] done"

#Zip file binary
_zip_build:
	$(eval OUTPUTDIR := $(DISTDIR)/bin)
	@echo "[zip build] ..."
	@cd "$(OUTPUTDIR)" && zip "$(ZIPNAME)" "./$(PKG)" && mv "$(OUTPUTDIR)/$(ZIPNAME)" "$(WD)"
	@echo "[zip done]"

#Clean output directory
_clean_build:
	$(eval OUTPUTDIR := $(DISTDIR))
	@echo "[clean build] $(OUTPUTDIR) ..."
	@rm -rf "$(OUTPUTDIR)"
	@echo "[clean build] done"

#Test with Unit Test and Coverage
_test:
	@go test -short ./...

#build
build: _build
build: _zip_build
build: _clean_build

#test
test: _test