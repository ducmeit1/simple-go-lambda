#!/usr/bin/env groovy
node {
    //Clean workspace before doing anything
    deleteDir()

    try {
        buildNumber = getCurrentBuildNumber()
        dockerImage = "ducmeit1/simple-go-lambda:v${buildNumber}"
        dockerFile = "Dockerfile"
        //Prepare stage will only checkout the last commit of master branch from remote git repository
        stage('Prepare') {
            //Set working dir for working space
            dir("simple-go-lambda") {
                checkout scm
            }
        }
        //Build stage will build docker image and push to docker registry
        stage('Build') {
            dir("simple-go-lambda") {
                docker.withRegistry("", "docker-hub-credentials") {
                    //Build docker image
                    def image = docker.build("${dockerImage}", "-f ${dockerFile} .")
                    //Push to registry
                    image.push()
                }
            }
        }
        //Deploy stage will copy build.zip from docker image by run a docker container and use aws-cli to update exist aws lambda
        stage('Deploy') {
            dir("simple-go-lambda") {
                //Get current working directory
                wd = pwd()
                //Map wd with build folder in docker (we can't mapping with root path of docker container)
                sh "docker run -v ${wd}:/build --rm --entrypoint cp ${dockerImage} ./build.zip /build/build.zip"
                //Update aws lambda function code
                sh "cd ${wd} && ls -la && aws lambda update-function-code --function-name simple-go-lambda --region ap-southest-1 --zip-file fileb://build.zip"
            }
        }

    } catch (exception) {
        //Set result = 'FAILED' if any exception occur
        currentBuild.result = 'FAILED'
        throw exception
    }
}

def getCurrentBuildNumber() {
    return env.BUILD_NUMBER
}