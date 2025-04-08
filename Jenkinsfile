pipeline {
    agent any

    stages {
        stage('Docker'){
            steps{
                sh 'docker build -t my-docker-image .'
            }
        }

        stage('Build') {
            agent {
                docker { 
                    image 'node:22.13.1-alpine' 
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm install
                    npm run build
                    ls -la
                '''
            }
        }

        stage('Test') {
            agent {
                docker { 
                    image 'node:22.13.1-alpine' 
                    reuseNode true
                }
            }
            steps {
                sh '''
                    test -f build/index.html
                    npm test
                '''
            }
        }
    }
}