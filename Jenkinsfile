pipeline {
    agent any

        environment {
        AWS_DOCKER_REGISTRY = '924917172028.dkr.ecr.us-east-2.amazonaws.com'
        // your ECR repository name
        APP_NAME = 'our_final_project_image'
        AWS_DEFAULT_REGION = 'us-east-2'
    }

    stages {
        stage('Docker'){
            steps{
                sh 'docker build -t my-docker-image .'
            }
        }

        // stage('Build') {
        //     agent {
        //         docker { 
        //             image 'node:22.13.1-alpine' 
        //             reuseNode true
        //         }
        //     }
        //     steps {
        //         sh '''
        //             ls -la
        //             node --version
        //             npm --version
        //             npm install
        //             npm run build
        //             ls -la
        //         '''
        //     }
        // }

        // stage('Test') {
        //     agent {
        //         docker { 
        //             image 'node:22.13.1-alpine' 
        //             reuseNode true
        //         }
        //     }
        //     steps {
        //         sh '''
        //             test -f build/index.html
        //             npm test
        //         '''
        //     }
        // }

        stage('Build My Docker Image'){

            agent{
                docker{
                    image 'amazon/aws-cli'
                    reuseNode true
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=""'
                }
            }
            steps{
                withCredentials([usernamePassword(credentialsId: 'finalProjectUser', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    
                    sh '''
                        amazon-linux-extras install docker
                        docker build -t $AWS_DOCKER_REGISTRY/$APP_NAME .
                        aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_DOCKER_REGISTRY
                        docker push $AWS_DOCKER_REGISTRY/$APP_NAME:latest
                    '''
                }
            }
        }
    }
}