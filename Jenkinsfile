#!/usr/bin/env groovy
node {
    //Clean workspace before doing anything
    deleteDir()

    try {
        buildNumber = getCurrentBuildNumber()
        dockerImage = "ducmeit1/simple-go-lambda:v${buildNumber}"
        //Prepare stage will only checkout the last commit of master branch from remote git repository
        stage('Prepare') {
            checkout scm
        }
        //Build stage will build docker image and push to docker registry
        stage('Build') {
            docker.withRegistry("ducmeit1/simple-go-lambda", "docker-hub-credentials") {
                //Build docker image
                def image = docker.build("")
                //Push to registry
                image.push()
            }
        }
        //Deploy stage will copy build.zip from docker image by run a docker container and use aws-cli to update exist aws lambda
        stage('Deploy') {
            //Get current working directory
            wd = pwd()
            sh "docker run -v ${wd}:/ --rm --entrypoint cp ${dockerImage} ./build.zip ./build.zip"
            //Update aws lambda function code
            sh "cd ${wd} && aws lambda update-function-code --function-name simple-go-lambda --region ap-southest-1 --zip-file fileb://build.zip"
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