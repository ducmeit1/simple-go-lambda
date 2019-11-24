FROM golang:1.12.13 as build

#Install zip package to using zip
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  zip

#Copy all project to src directory of default GOPATH address with name of project
COPY . /go/src/simple-go-lambda

#CD to simple-go-lambda folder by set WORKDIR
WORKDIR /go/src/simple-go-lambda

#RUN Makefile with test first, and build right after
RUN make test && make build

#chmod to 755
RUN chmod 755 build.zip

FROM busybox
#Copy build.zip to build folder
COPY --from=build /go/src/simple-go-lambda/build.zip ./build
