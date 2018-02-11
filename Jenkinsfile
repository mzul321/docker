pipeline {
    agent none
    stages {
        stage('Parallel Checkout') {
            parallel {
                stage('Docker Repo') {
                    agent {
                        label "master"
                    }
                    steps {
                        dir('docker') {
                            git url: 'https://github.com/mzul321/docker.git'
                        }
                    }
                }
                stage('Sample Repo') {
                    agent {
                        label "master"
                    }
                    steps {
                        dir('sample') {
                            git url: 'https://github.com/mzul321/sample.git'
                        }
                    }
                }
            }
        }
    }
}
